#! /bin/env ruby
#
############################################################
# Author: Alice "Duchess" Archer
# Copyright (c) 2016 under the MIT License
# see COPYING.md for full copyright
# Name: rFlex
# Description: lexical analysis library
############################################################

class TokenLexer
	def initialize type, regexp
		@type = type
		@regexp = regexp
		@blockType = nil
		@block = nil
	end

	def do type, &block
		@block = block
		@blockType = type
	end

	def lex input

		inputT = input
		temp = self.sliceL(inputT)
		token = ""
		if temp == nil
			raise "\n\nUnconsumed Input:\n\n[#{inputT}]\n\n"
		else	
			token = temp[:token]
		end

		if token.length >= 1
			if @block != nil
				analyze(token, @regexp, @type)
			end
			if temp[:inputS].length == 0 # token is not empty and remaining input is empty
				return { :success => true, :inputS => temp[:inputS], :done => true, :error => false }
			else # token is not empty and remaining input is not empty
				return { :success => true, :inputS => temp[:inputS], :done => false, :error => false }
			end
		else
			if temp[:inputS].length >= 1 # token is empty and remaining input is not empty 
				# error
				#raise "\n\nUnconsumed Input:\n\n[#{temp[:inputS]}]\n\n"
				return { :success => false, :inputS => temp[:inputS], :done => false, :error => true }
			else
				# token is empty and input is not
				return { :success => false, :inputS => temp[:inputS], :done => false, :error => false }
			end 
		end
	end

	def sliceL input

		# puts "\n\n"

		if input == nil
			return { :token => "", :input => input }
		end

		len = input.length
		ii = 0
		temp = ""
		curMatch = ""
		matched = false
		inputT = input

		until ii == len do

			temp.concat(input[ii])
			# print "[#{input[ii]}]"
			if temp.match(@regexp)
				matched = true
				curMatch = temp
				ii += 1
				if ii == len
					inputT = inputT[(ii)..-1].to_s
					return { :token => curMatch[0..-1], :inputS => inputT }
				end
				next
			else
				ii += 1
				if matched
					inputT = inputT[(ii - 1)..-1].to_s
					return { :token => curMatch[0..-2], :inputS => inputT }
				else
					if ii == len
						return { :token => "", :inputS => inputT }
					else
						next
					end
				end
			end
		end
	end

	def analyze token, regex, type
		@block.call(token, regex, type)
	end

	def type
		return @type
	end

	def regexp
		return @regexp
	end

	def block
		return @block
	end
end

class LexicalAnalyzer
	def initialize file, config
		@types = {}
		@typeList = []
		@file = file
		@streamTokens = []
		@lexers = []
		@typeList = []
		configure(config)
	end

	def configure config
		typeList = File.readlines(config)

		0.upto(typeList.length.to_i - 1) do |i|
			typeList[i].chomp!
		end

		typeList.each do |type|
			
			at_Reg = false

			cur_Type = ""
			cur_Reg = ""

			index = 0

			0.upto(type.length - 1) do |i|
				if type[i] == "{"
					index = i
					break
				else
					cur_Type.concat(type[i])
				end
			end

			cur_Reg = type[(index+1)..-2]

			cur_Type.delete! " "

			@types.store(cur_Type, Regexp.new(cur_Reg))
			cur_Reg = Regexp.new(cur_Reg)
			@lexers.push(TokenLexer.new(cur_Type, cur_Reg))
			@typeList.push(cur_Type)
		end
	end

	def lex
		lines = File.readlines(@file)
		input = ""
		lines.each do |line|
			input.concat("#{line}")
		end

		# input = input[0..-1].to_s
		inputT = input

		len = @lexers.length - 1
		j = 0

		matched = false

		until inputT.length == 1
			tempLex = { :success => false, :inputS => inputT }
			0.upto(len) do |i|
				j = i
				tempLex = @lexers[i].lex(inputT)

				if tempLex[:success]
					matched = tempLex[:success]
					inputT = tempLex[:inputS]
					if inputT.length == 0
						break
					end
				else
					matched = false
				end

				# j = i
			end

			# if we tried all options
			# and
			# we didn't match
			# and
			# there is remaining input
			## puts "j: #{j}, len: #{len}, matched: #{matched}, input: #{inputT}, length: #{inputT.length}, done: #{tempLex[:done]}, error: #{tempLex[:error]}"
			if (j == len) and tempLex[:error]
				raise "\n\nUnconsumed Input:\n\n\"#{inputT}\"\n\n"
			end

			matched = false
		end
	end

	def lexers
		return @lexers
	end

	def types
		return @typeList
	end
end