=== programLanguage-proto design ===

== Expression Formats ==

expression : IDENTIFIER_TOKEN ASSIGN_TOKEN expression TERMINATOR_TOKEN
           | IDENTIFIER_TOKEN ASSIGN_TOKEN INTEGER_LITERAL_TOKEN TERMINATOR_TOKEN
           | logical_or_expression TERMINATOR_TOKEN
           ;

logical_or_expression : logical_and_expression
                      | logical_or_expression "||" logical_and_expression
                      ;

logical_and_expression : equality_expression
                       : logical_and_expression "&&" equality_expression
                       ;

equality_expression : relational_expression
                    | equality_expression EQUALS_TOKEN relational_expression
                    ;
                    
relational_expression : additive_expression
                      | relational_expression GREATER_THAN_TOKEN additive_expression
                      | relational_expression LESS_THAN_TOKEN additive_expression
                      | relational_expression GREATER_THAN_EQUAL_TOKEN additive_expression
                      | relational_experssion LESS_THAN_EQUAL_TOKEN additive_expression
                      ;
                      
additive_expression : multiplicative_expression
                    | additive_expression PLUS_TOKEN multiplicative_expression
                    | additive_expression MINUS_TOKEN multiplicative_expression
                    ;
                    
multiplicative_expression : unary_expression
                          | MINUS_TOKEN primary_expression
                           ;
                           
unary_expression : IDENTIFIER_TOKEN
                 | INTEGER_LITERAL_TOKEN
                 | function_call
                 | expression
                 ;
                 
== Functionality ==
                 
function_call : IDENTIFIER_TOKEN argument_list
              ;
              
argument_list : expression
              | argument_list ',' expression
              ;

== FLOW CONTROL ==
if_statement : IF_TOKEN expression statement
             | IF_TOKEN expression statement ELSE_TOKEN statement
             ;

while_statement : WHILE_TOKEN expression statement
                ;
                
for_statement : FOR_TOKEN expression ',' expression statement
              ;
              
== RETURN ==
              
return_statement : RETURN_TOKEN expression
