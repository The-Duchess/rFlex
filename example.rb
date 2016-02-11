require 'rFlex'

def main
	lexertemp = LexicalAnalyzer.new(ARGV[0].to_s, ARGV[1].to_s)

	lexertemp.lexers.each do |lexer|
			lexer.do :lex do |token, regexp, type|
				if type != "ignore"
					puts "lexeme: #{type} | value: #{token}"
					puts "-------~-----~--~------~---~-------~----~------------~---~------------~-----"
				end
			end
	end

	puts "------------------------------------------------------------------------------"
	puts "Tokens"
	puts "------------------------------------------------------------------------------"

	lexertemp.lex

	puts "------------------------------------------------------------------------------"
	puts "lexemes"
	puts "------------------------------------------------------------------------------"

	lexertemp.lexers.each do |lexer|
	#	puts "#{lexer.type} #{lexer.regexp}"
	end

end

main