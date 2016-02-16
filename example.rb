require_relative 'rflex.rb'

def main
	lexertemp = LexicalAnalyzer.new(ARGV[0].to_s, ARGV[1].to_s)

	$i = 1

	prfxo  = "\033[0;31;40m"
	pstfx  = "\033[0m"

	lexertemp.lexers.each do |lexerT|

		if lexerT.type == "number"
			lexerT.do :lex do |token, regexp, type|
				print "{\n num  => #{$i}"
				print "\n  token => \'#{prfxo}#{token}#{pstfx}\'\n"
				print "  type  => #{type}\n"
				print "}\n"
				#print "["
				#print $i
				#print "]"
				#print "[#{prfxo}#{token}#{pstfx}]"
				$i += 1
			end
		else
			lexerT.do :lex do |token, regexp, type|
				print "{\n num  => #{$i}"
				print "\n  token => \'#{token}\'\n"
				print "  type  => #{type}\n"
				print "}\n"
				$i += 1
			end
		end
	end

	puts "Consumed Input:\n\n"

	lexertemp.lex

	puts "\n\n"

end

main
