%{
#include <stdio.h>
void yyerror(char *);
%}

space [ ]
tab [ \t]
new_line [\n]
alt [\_]
lp [\(]
rp [\)]
l_brace [\{]
r_brace [\}]
semicolon ;
l_square_bracket [\[]
r_square_bracket [\]]
marks ({lp}|{rp}|{l_brace}|{r_brace}|{semicolon}|{l_square_bracket}|{r_square_bracket})
assignment_operator =
comma , 
dot .
plus \+
minus \-
multiply \*
divide \/
reminder \%
equality_check (==)
smaller  \<
smaller_or_equal (<=)
bigger \>
bigger_or_equal (>=)
not_equal (!=)
boolean_constant [0|1]
digit   [0-9] 
int  [+-]?{digit}+
char [A-Za-z]
float_constant  [+-]?({digit}+\.{digit})+
if (if)
elseif (elseif)
else (else)
do (do)
read_altitude (read_altitude)
read_temperature (read_temperature)
read_direction (read_direction)
read_tank (read_tank)
read_latitude (read_latitude)
read_longitude (read_longitude)
read_battery (read_battery)
connect_to_drone (connect_to_drone)
nozzle (nozzle)
vertical_movement (vertical_movement)
horizontal_movement (horizontal_movement)
turn (turn)
auto (auto)
manual (manual)
HFS (HFS)
HBS (HBS)
VUS (VUS)
VDS (VDS)
TS (TS)
set_HFS (set_HFS)
set_HBS (set_HBS)
set_VUS (set_VUS)
set_VDS (set_VDS)
set_TS (set_TS)
all_identifiers ({space}|{plus}|{minus}|{multiply}|{divide}|{reminder}|{tab}|{assignment_operator}|{comma}|{dot}|{equality_check}|{smaller}|{smaller_or_equal}|{bigger}|{bigger_or_equal}|{not_equal}|{variable_identifier}|{int}|{alt}|{marks})
comment \/\#\#{all_identifiers}*\#\/
variable_identifier ({char})+([\_]|{char}|{digit})*

%option yylineno
%%
{plus} return PLUS;
{minus} return MINUS;
{multiply} return MULTIPLY;
{divide} return DIVIDE;
{reminder} return REMINDER;
{space} ;
{tab} ;
{new_line} ;
{assignment_operator} return ASSIGNMENT_OP ;
{comma} return COMMA ;
\&\& return AND ;
\|\| return OR ;
{equality_check} return EQUALITY_CHECK ;
{smaller} return SMALLER  ;
{smaller_or_equal}  return SMALLER_OR_EQUAL ;
{bigger} return GREATER ;
{bigger_or_equal} return GREATER_OR_EQUAL ;
{not_equal} return NOT_EQUAL ;
{int} return INT ;
{float_constant} return FLOAT ;
{boolean_constant} return BOOLEAN_CONSTANT ;
{lp} return LP ;
{rp} return RP ;
{l_brace} return LBRACE ;
{r_brace} return RBRACE ;
{semicolon} return SEMI_COLON ;
{if} return IF ;
{elseif} return ELSEIF;
{else} return ELSE;
gek return GEK ;
{do} return DO;
while return WHILE ;
for return FOR ;
{auto} return AUTO;
{manual} return MANUAL;
{HFS} return HFS;
{HBS} return HBS;
{VUS} return VUS;
{VDS} return VDS;
{TS} return TS;
{read_altitude} return READ_ALTITUDE ;
{read_temperature} return READ_TEMPERATURE ;
{read_direction} return READ_DIRECTION ;
{read_tank} return READ_TANK ;
{read_latitude} return READ_LATITUDE ;
{read_longitude} return READ_LONGITUDE ;
{read_battery} return READ_BATTERY ;
{connect_to_drone} return CONNECT_TO_DRONE ;
{nozzle} return NOZZLE ;
{vertical_movement} return VERTICAL_MOVEMENT ;
{horizontal_movement} return HORIZONTAL_MOVEMENT ;
{turn} return TURN ;
{set_HFS} return SET_HFS ;
{set_HBS} return SET_HBS ;
{set_VUS} return SET_VUS ;
{set_VDS} return SET_VDS ;
{set_TS} return SET_TS ;
{comment} return COMMENT ;
{variable_identifier} return IDENTIFIER ;
%%

int yywrap(void){
	return 1;
}