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

		if token = input.slice!(@regexp)
			if @block != nil
				analyze(token, @regexp, @type)
			end
			return true
		end

		return false
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

		input = input[0..-2].to_s

		len = @lexers.length - 1

		matched = false

		until input.length == 0
			0.upto(len) do |i|
				if @lexers[i].lex(input)
					matched = true
				else
					matched = false
				end

				if i == len and matched != false
					puts "\n\nUnconsumed Input: #{input}\n                      ^\n\n"
					abort
				end

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