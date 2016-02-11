# rFlex

rFlex is a lexical analysis library built in ruby

version 0.1.1

# changelog

0.1.1 fixes and issue with unconsumed input

# Library Documentation

**Install**

> gem install rFlex

or

> git clone https://github.com/The-Duchess/rFlex

> cd rflex/rflexGem

> gem install rFlex-0.1.1.gem


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

**Usage in demonstration**

> ruby .\example.rb .\inputFile.txt .\regexpxFile.txt

**Demonstration**

![Alttext](http://i.imgur.com/5EIsmxM.png)

**Example Input File**

> [inputFile](https://github.com/The-Duchess/rFlex/blob/master/inputFile.txt)


**Example Regexps File**

> [regexpsFile](https://github.com/The-Duchess/rFlex/blob/master/regexpsFile.txt)


# COPYING

Published under the MIT License

See [COPYING](https://github.com/The-Duchess/rFlex/blob/master/COPYING.md)
