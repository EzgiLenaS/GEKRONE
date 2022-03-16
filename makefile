parser: y.tab.c lex.yy.c
	gcc -o parser y.tab.c
y.tab.c: CS315f21_team58.yacc
	yacc CS315f21_team58.yacc
lex.yy.c: CS315f21_team58.lex
	lex CS315f21_team58.lex
