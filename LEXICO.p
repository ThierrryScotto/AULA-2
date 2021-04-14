%%
%class Lexer
%type Token
%line
%column
%{
	private Token token(Token.T type) {
		return new Token(type, yyline, yycolumn);
	}
	private Token token(Token.T type, Object val) {
		return new Token(type, val, yyline, yycolumn);
	}
%}

alpha				= [a-zA-Z]
dig 				= [0-9]
id          = {alpha} ({alpha} | {dig})*
inteiro 		= {dig}+
real 	    	= {dig}+ "." {dig}* | {dig}* "." {dig}+
texto       = ({alpha} | {dig})+  
se					= <=+
small				= [<]
large 			= [>]
le 					= >=+
allocation  = [:]
equal			  = [:=]

%%
{allocation}  { return token(Token.T.ALLOCATION); }
{le}					{ return token(Token.T.EL); }
{large}				{ return token(Token.T.LARGER); }
{equal}					{ return token(Token.T.EQUAL); }
{small}				{ return token(Token.T.SMALL); }
{se}					{ return token(Token.T.SE); }
real      	  { return token(Token.T.REAL); }
inteiro   	  { return token(Token.T.INTEIRO); }
executa   	  { return token(Token.T.EXECUTA); }
imprime     	{ return token(Token.T.IMPRIME); }
retorna      	{ return token(Token.T.RETORNA); }
se           	{ return token(Token.T.SE); }
senao        	{ return token(Token.T.SENAO); }
relop        	{ return token(Token.T.RELOP); }
define       	{ return token(Token.T.DEFINE); }
programa     	{ return token(Token.T.PROGRAMA); }
fimprograma  	{ return token(Token.T.FIMPROGRAMA); }
declara      	{ return token(Token.T.DECLARA); }
{inteiro}     { return token(Token.T.INTEIRO, new Integer(yytext())); }
{real}        { return token(Token.T.REAL, new Double(yytext())); }
{id}          { return token(Token.T.ID); }
{texto}       { return token(Token.T.TEXTO, yytext()); }
[ \t\n\r]+   	{ /* do nothing */ }
<<EOF>>      	{ return token(Token.T.EOF); }
.            	{ System.out.printf("error: unexpected char |%s|\n", yytext());}