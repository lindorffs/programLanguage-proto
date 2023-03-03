%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char* s);
int yylex();
%}

%token IF_TOKEN ELSE_TOKEN WHILE_TOKEN FOR_TOKEN FUNCTION_TOKEN RETURN_TOKEN
%token PLUS_TOKEN MINUS_TOKEN MULTIPLY_TOKEN DIVIDE_TOKEN ASSIGN_TOKEN
%token EQUALS_TOKEN NOT_EQUALS_TOKEN GREATER_THAN_TOKEN LESS_THAN_TOKEN
%token GREATER_THAN_EQUAL_TOKEN LESS_THAN_EQUAL_TOKEN
%token IDENTIFIER_TOKEN INTEGER_LITERAL_TOKEN LETTER_LITERAL_TOKEN

%%
program : statement_list
        ;

statement_list : statement
               | statement_list statement
               ;

statement : expression_statement
          | if_statement
		{printf("ifStatement\n");}
          | while_statement
		{printf("whileStatement\n");}
          | for_statement
		{printf("forStatement\n");}
          | function_statement
		{printf("funcStatement\n");}
          | return_statement
		{printf("retPrimaryStatement\n");}
          ;

expression_statement : expression { }
                     ;

expression : IDENTIFIER_TOKEN ASSIGN_TOKEN expression
		{ printf("exprAssign\n"); }
           | logical_or_expression
	   | IDENTIFIER_TOKEN ASSIGN_TOKEN INTEGER_LITERAL_TOKEN
		{ printf("numAssign: %d\n", $3); }
           ;

logical_or_expression : logical_and_expression
                       | logical_or_expression "||" logical_and_expression
			{ printf("lorStatement\n"); }
                       ;

logical_and_expression : equality_expression
                        | logical_and_expression "&&" equality_expression
			{ printf("landStatement\n"); }
                        ;

equality_expression : relational_expression
                     | equality_expression EQUALS_TOKEN relational_expression
			{ printf("equalsStatement\n"); }
                     | equality_expression NOT_EQUALS_TOKEN relational_expression
			{ printf("notEqualsStatement\n"); }
                     ;

relational_expression : additive_expression
                      | relational_expression GREATER_THAN_TOKEN additive_expression
			{ printf("grtStatement\n"); }
                      | relational_expression LESS_THAN_TOKEN additive_expression
			{ printf("lstStatement\n"); }
                      | relational_expression GREATER_THAN_EQUAL_TOKEN additive_expression
			{ printf("greStatement\n"); }
                      | relational_expression LESS_THAN_EQUAL_TOKEN additive_expression
			{ printf("lteStatement\n"); }
                      ;

additive_expression : multiplicative_expression
                     | additive_expression PLUS_TOKEN multiplicative_expression
			{ printf("plusStatement\n"); }
                     | additive_expression MINUS_TOKEN multiplicative_expression
			{ printf("minusStatement\n"); }
                     ;

multiplicative_expression : unary_expression
                          | multiplicative_expression MULTIPLY_TOKEN unary_expression
			{ printf("multiplyStatement\n"); }
                          | multiplicative_expression DIVIDE_TOKEN unary_expression
			{ printf("divideStatement\n"); }
                          ;

unary_expression : primary_expression
                  | MINUS_TOKEN primary_expression
			{ printf("minusUnaryStatement\n"); }
                  ;

primary_expression : IDENTIFIER_TOKEN
			{ printf("identifierPrimaryStatement\n"); }
                   | INTEGER_LITERAL_TOKEN
			{ printf("IntegerLiteralStatement\n"); }
                   | function_call
			{ printf("functionCallPrimaryStatement\n"); }
                   | '(' expression ')'
			{ printf("(expre) Statement\n"); }
                   ;

function_call : IDENTIFIER_TOKEN argument_list
			{ printf("functionCallStatement\n"); }
              ;

argument_list : expression
			{ printf("exprArgumentStatement\n"); }
              | argument_list ',' expression
			{ printf("listExpreArgumentStatement\n"); }
              ;

if_statement : IF_TOKEN expression statement
			{ printf("ifExprStatement\n"); }
             | IF_TOKEN expression statement ELSE_TOKEN statement
			{ printf("ifElseExprStatement\n"); }
             ;

while_statement : WHILE_TOKEN expression statement
			{ printf("whileStatement\n"); }
                ;

for_statement : FOR_TOKEN  expression ',' expression statement
			{ printf("forStatement\n"); }
              ;

function_statement : FUNCTION_TOKEN IDENTIFIER_TOKEN statement
			{ printf("def %s():", $2); }
                   ;

return_statement : RETURN_TOKEN expression
			{ printf("retStatement\n"); }
                 ;

%%
int main() {
    return(yyparse());
}

void yyerror(const char* s) {
    fprintf(stderr, "yyerror: %s\n", s);
}

int yywrap() {
    return 1;
}
