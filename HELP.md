# **Docs**

**Creating a lexeme file**

the lexeme file has a syntax that looks like

	number     {^[1-9][0-9]*$}
	word       {^[a-zA-Z]+$}
	whitespace {^[ \n\t\s]+$}

where a type is provided and then a regex that is in the perl/ruby format is provided in curly braces.

there is currently no inheriting previous regexes like with javacc or jflex.

**Creating a Lexer**

```ruby

	require 'rFlex'

	# this provides the lexer with the input it needs and the lexeme file which it constructs
	# a set of lexer objects with.
	lexer = LexicalAnalyzer.new("/path/to/input", "/path/to/lexemes")

	lexer.lexers.each do |lexer|
		# for lexers of the types you wish to have behavior
		if lexer.type =~ /one of your types/
			lexer.do :lex do |token, regexp, type|
				# you get the token value, the regexp that matched it and the type of token
				# here you can perform some action when you split this token off of input
			end
		else
			# token types you do not care about processing
			lexer.do :lex do |token, rexexp, type|
				# do nothing
			end
			next
		end
	end
```

**Lexing**

```ruby

	lexer.lex
	# there is no other function required since you have constructed the hooks to code you wish
	# to execute when a token of the desired type is seen.

	# the hooks are attached to the lexers, or a class that holds a regexp which will match
	# a token and thus cannot be matched to a specific token unless a regexp exists to match
	# a specific string. when the lexer finds a string that matched you have access to the value
	# which you can make decisions based on what it is that may differ from the regexp used to
	# find it.

	# for examples look at example.rb and file and configrFlex.
```
