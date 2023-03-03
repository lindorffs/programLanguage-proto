%{
#include <stdio.h>
#include "y.tab.h"

char upper[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
char lower[] = "abcdefghijklmnopqrstuvwxyz";
%}

%%

"if" return IF_TOKEN;
"else" return ELSE_TOKEN;
"while" return WHILE_TOKEN;
"for" return FOR_TOKEN;
"action"        return FUNCTION_TOKEN;
"return" return RETURN_TOKEN;

"+"             return PLUS_TOKEN;
"-"             return MINUS_TOKEN;
"*"             return MULTIPLY_TOKEN;
"/"             return DIVIDE_TOKEN;
"="             return ASSIGN_TOKEN;
"=="            return EQUALS_TOKEN;
"!="            return NOT_EQUALS_TOKEN;
">"             return GREATER_THAN_TOKEN;
"<"             return LESS_THAN_TOKEN;
">="            return GREATER_THAN_EQUAL_TOKEN;
"<="            return LESS_THAN_EQUAL_TOKEN;

[A-Za-z0-9_]*   { return IDENTIFIER_TOKEN; }
[0-9]+                  { yylval = atoi(yytext); return INTEGER_LITERAL_TOKEN; }

[ \t\n]    
"//"      
[()]	 
.           printf("Syntax error: invalid input: '%s'\n", yytext);
