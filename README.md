# rFlex

rFlex is a lexical analysis library built in ruby

# Library Documentation

**Install**

> \>gem install rFlex

or

> \>gem install rFlex-0.1.0.gem

**Example**

```ruby
	require 'rFlex'

	lexer = LexicalAnalyzer.new(ARGV[0].to_s, ARGV[1].to_s)

	lexertemp.lexers.each do |lexer|
		lexer.do :lex do |token, regexp, type|
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
**Demonstration**

[!Alttext]()

**Example Input File**

> [inputFile]()

int j = 12 / 3 * 5;
int i = 5;
def foo(int i, int j) {
	print (i + j);
}

**Example Regexps File**

> [regexpsFile]()

ignore     {[ \t\n]+}
assignment {^=}
terminal   {^;}
openBrace  {^\{}
closeBrace {^\}}
def        {^def}
openArg    {^\(}
closeArg   {^\)}
comma      {^,}
PRINT      {^print}
INT        {^int}
int        {^\d+}
comment    {^\/\*.*\*\/}
add        {^\+}
mul        {^\*}
sub        {^\-}
div        {^\/}
identifier {^[a-zA-Z]\w*}