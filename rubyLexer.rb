
# ruby Lexer
# Author: Alice "Duchess" Archer
# takes a file and a config for token definitions and creates a stream of tokens
# options
# usage: ruby rubyLexer.rb <file> <config>

class Lexer
	def initialize file, config
		@types = {}
		@typeH = []
		@typeList = []
		@unmatchedTokens = []
		@file = file
		@streamTokens = []
		configure(config)
	end

	def getFile
		return @file
	end

	def getStream
		return @streamTokens
	end

	def getErrors
		return @unmatchedTokens
	end

	def getTypes
		return @typeH
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
			@typeH.push({ :type => cur_Type, :regexp => cur_Reg })
		end
	end

	def lex

		lines = File.readlines(@file)
		input = ""
		lines.each do |line|
			input.concat("#{line} ")
		end

		input = input[0..-2].to_s

		tokens = []

	    until input.length == 0
	     	matched = @types.detect do |(type, regex)|
	        	if token = input.slice!(regex)
	        		tokens << { :type => type, :value => token, :regexp => regex }
	        	end
	    	end

	    	raise "Uncomsumed input: #{input}" unless matched
	  	end

	  	tokens.delete_if { |i| i[:type] =~ /^ignore$/i } # delete whitespace

		@streamTokens = tokens
	end
end

def main
	lexertemp = Lexer.new(ARGV[0].to_s, ARGV[1].to_s)
	lexertemp.lex

	prfxo  = "\033[0;31;40m"
	pstfx  = "\033[0m" 

	lexertemp.getStream.each do |token|
		if token[:type] == "number"
			print "[#{prfxo}#{token[:value]}#{pstfx}]"
		else
			print token[:value]
		end
		#puts "Type: #{token[:type]} | Value: #{token[:value]} | Regexp: #{token[:regexp]} |"
		#puts "------------------------------------------------------------------------------"
	end

	puts "\n\n"
end

main