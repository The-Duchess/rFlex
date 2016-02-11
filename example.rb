require 'rflex'

def main
	lexertemp = LexicalAnalyzer.new(ARGV[0].to_s, ARGV[1].to_s)

	lexertemp.lexers.each do |lexerT|
			lexerT.do :lex do |token, regexp, type|
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

end

main
