# rFlex

rFlex is a lexical analysis library built in ruby

version 0.1.3

for help see [HELP](https://github.com/The-Duchess/rFlex/blob/master/HELP.md)

# changelog

0.1.1 and 0.1.2 fix an issue with unconsumed input

0.1.3 fixes issues with unconsumed input; also example.rb has been updated along with the configrFlex

# Library Documentation

**Install**

> gem install rFlex

or

> git clone https://github.com/The-Duchess/rFlex

> cd rflex/rflexGem

> gem install rFlex-0.1.3.gem


**Example**

```ruby

	require 'rFlex'

	lexer = LexicalAnalyzer.new(ARGV[0].to_s, ARGV[1].to_s)

	lexer.lexers.each do |lexerT|
		lexerT.do :lex do |token, regexp, type|
			if type != "ignore"
				puts "lexeme: #{type} | value: #{token}"
				puts "-------~-----~--~------~---~-------~----~------------~---~------------~-----"
			end
		end
	end

	puts "-------~-----~--~------~---~-------~----~------------~---~------------~-----"
	puts "Tokens"
	puts "-------~-----~--~------~---~-------~----~------------~---~------------~-----"

	lexer.lex
```


# COPYING

Published under the MIT License

See [COPYING](https://github.com/The-Duchess/rFlex/blob/master/COPYING.md)
