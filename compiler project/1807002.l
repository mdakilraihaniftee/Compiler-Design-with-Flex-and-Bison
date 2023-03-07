/* final */
%{
	#include<stdio.h>
	#include <string.h>
	#include "1807002.tab.h"
	#include<stdlib.h>
	

%}

var [a-zA-Z|a-zA-Z0-9]+
increment "||"
decrement "~~"
comment [/][-][-](.*|\n)[-][-][/]
digit [0-9]+

/*RE and Action*/

%%


{comment} {
	printf("comment\n");

}
"#get*<"{var}">"   { printf("library added\n");}

{increment}   {return inc;}    /*correction*/
"{"	 { return LB; }
"}"	  { return RB; }
"op-stop"    {   return BREAK;     }

            
"T-Number"	{ yylval.string=strdup(yytext);return INT; }
"T-decimal"	{ yylval.string=strdup(yytext);return FLOAT; }
"T-symbol"	{ yylval.string=strdup(yytext);return CHAR; }
"Arr"       { yylval.string=strdup(yytext);return ARRAY; }
"SZ_OF"     {return size_of;}
"call_"      {return CALL;}

{digit}	{ 
		yylval.number = atoi(yytext);
		return NUM;
	}




"..??"      { return CASE;      }
"..|^"      { return SWITCH;	}
"^|.."      { return SWITCH_END;	}
"..!!"     {  return DEFAULT; 	}
[:]     { return COL;}






"'@-??" { return WHILE;} 
"??-@'" { return WHILE_END;} 
"'@"   { return FOR;}	
"@'"   { return FOR_END;}	
"["	{ return LP; }
"]"	{ return RP; }


","	{ return CM; }
";"	{ return SM; }



"|"	{ return PLUS;}
"~"	{ return MINUS; }
"#"	{ return MULT; }
"%"	{ return DIV; }
"/" {return MOD;}
"^"	{ return POW; }
"="	{ return ASSIGN;  }



"ck.}"	{ return GT; }
"ck.}="	{ return GTE; }
"ck.{"	{ return LT; }
"ck.{="	{ return LTE; }
"ck.<<"	{ return EEQL; }
"ck.!<<"	{ return NEQL; }

"XOR"		{return XOR;}
"AND"	    {return AND;}
"OR"		{return OR;}
"NT"		{return NOT;}
"SIN"		{return SIN;}
"COS"		{return COS;}
"TAN"		{return TAN;}
"SQRT"		{return SQRT;}
"log"		{return LOG;}
"log2"		{return LOG2;}
"ln"		{return LN;}
"FACT"			{return FACTORIAL;}


{var} {
	 yylval.string=strdup(yytext);
	 return VAR;
	}

"??"		{ return IF;}
"?:"	{ return ELIF; }
"!:"		{ return ELSE;}

"start()"	{ return MAIN; }
"def->T-Number"     {
                     printf("Function declared with return type : INTERGER\n");
                    
                    return FUNC_NUM; 
                    }
"def->T-symbol"     { return FUNC_STR; }

[ \t\n]*	

.	{
		yyerror("Unknown Character.\n");
	}
%%

/* user subroutines */

int main()
{
	yyin = freopen("input.txt","r",stdin);
	yyout = freopen("output.txt","w",stdout);
	yyparse();
	
}