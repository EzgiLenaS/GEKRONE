%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char* s);
extern int yylineno;
%}

//tokens
%token ASSIGNMENT_OP
%token PLUS
%token MINUS
%token MULTIPLY
%token DIVIDE
%token REMINDER
%token EQUALITY_CHECK
%token SMALLER
%token SMALLER_OR_EQUAL
%token GREATER
%token GREATER_OR_EQUAL
%token NOT_EQUAL
%token SEMI_COLON
%token COMMA
%token LP
%token RP
%token LBRACE
%token RBRACE
%token COMMENT
%token IF
%token ELSEIF
%token ELSE
%token FOR
%token WHILE
%token DO
%token BOOLEAN_CONSTANT
%token FLOAT
%token AND
%token OR
%token DIGIT
%token INT
%token IDENTIFIER
%token HFS
%token HBS
%token VUS
%token VDS
%token TS
%token GEK
%token READ_ALTITUDE
%token READ_TEMPERATURE
%token READ_DIRECTION
%token READ_TANK
%token READ_LATITUDE
%token READ_LONGITUDE
%token READ_BATTERY
%token CONNECT_TO_DRONE
%token NOZZLE
%token VERTICAL_MOVEMENT
%token HORIZONTAL_MOVEMENT
%token TURN 
%token SET_HFS
%token SET_HBS
%token SET_VUS
%token SET_VDS
%token SET_TS
%token AUTO
%token MANUAL
%token COMMENT


%start program

%% 
//program
program : block_statements | statements
;

//Statements
statements : statement statements
		  |   statement
;

statement : if_statements 
		|   assignment_statement
		|   loops
		|   function_call
		|   function_declaration
                |   comment
;

comment: COMMENT
;

assignment_statement : IDENTIFIER ASSIGNMENT_OP additive_expressions SEMI_COLON 
                      | IDENTIFIER ASSIGNMENT_OP conditional_expression SEMI_COLON 
                      | IDENTIFIER ASSIGNMENT_OP function_call
;

block_statements : LBRACE RBRACE | LBRACE block_statements RBRACE | LBRACE statements RBRACE
;

//Variable Identifiers
constant : numeric_constant | BOOLEAN_CONSTANT
;

numeric_constant : INT | FLOAT
;

identifier_list : IDENTIFIER
		       |   identifier_list COMMA IDENTIFIER
;

//expressions (arithmetic, relational, boolean, their combination)
additive_expressions  : additive_expressions PLUS multiplicative_expressions  
			       |     additive_expressions MINUS multiplicative_expressions
			       |     multiplicative_expressions
;

multiplicative_expressions : multiplicative_expressions MULTIPLY term
				    | multiplicative_expressions DIVIDE term
				    | multiplicative_expressions REMINDER term
				    | term
;

term : IDENTIFIER | constant
;

equality_expression : additive_expressions EQUALITY_CHECK additive_expressions
    | additive_expressions NOT_EQUAL additive_expressions
;

relational_expression : additive_expressions SMALLER additive_expressions 
      | additive_expressions GREATER additive_expressions 
      | additive_expressions SMALLER_OR_EQUAL additive_expressions
      | additive_expressions GREATER_OR_EQUAL additive_expressions 
;

conditional_expression : equality_expression 
				  | relational_expression
                                  | conditional_expression AND equality_expression 
				  | conditional_expression AND relational_expression
				  | conditional_expression OR equality_expression 
			          | conditional_expression OR relational_expression
;

movement_expression : AUTO COMMA term
				| MANUAL COMMA term COMMA term
;
	
//Loops
loops :  WHILE LP conditional_expression RP block_statements
	      |    DO block_statements WHILE LP conditional_expression RP SEMI_COLON
	      |    FOR LP term RP block_statements
;

//Conditional statements
//change to statement without "s" after the test
if_statement : IF LP conditional_expression RP block_statements
;

if_else_block : ELSEIF LP conditional_expression RP block_statements
                | if_else_block ELSEIF LP conditional_expression RP block_statements
;

if_statements: if_statement 
               | if_statement if_else_block
               | if_statement if_else_block ELSE block_statements
               | if_statement ELSE block_statements
;


//Function definitions and function calls
 function_declaration :  GEK IDENTIFIER LP identifier_list RP block_statements
			  | GEK IDENTIFIER LP RP block_statements
;

function_call : IDENTIFIER LP RP SEMI_COLON
		  | IDENTIFIER LP identifier_list RP SEMI_COLON
		  | primitive_functions SEMI_COLON
;

//Primitive functions
primitive_functions : READ_ALTITUDE LP RP
			     | READ_TEMPERATURE LP RP
			     | READ_DIRECTION LP RP
			     | READ_TANK LP RP
			     | READ_LATITUDE LP RP
			     | READ_LONGITUDE LP RP
			     | READ_BATTERY LP RP
			     | CONNECT_TO_DRONE LP RP
			     | NOZZLE LP term RP
                             | VERTICAL_MOVEMENT LP movement_expression RP
                             | HORIZONTAL_MOVEMENT LP movement_expression RP
                             | TURN LP movement_expression RP
                             | SET_HFS  LP term RP
                             | SET_HBS LP term RP
                             | SET_VUS LP term RP
                             | SET_VDS LP term RP
                             | SET_TS LP term RP
;

%%
#include "lex.yy.c"
void yyerror(char *s){
	fprintf(stdout, "line %d: %s\n", yylineno, s);
}

int main(void){
yyparse();
if( yynerrs == 0 ){
		printf("Parsing is successful\n");
}
return 0;
}