/* final */
%{
	#include<stdio.h>
	#include <math.h>
	int cnt=1,cntt=0,val,track=0;
	typedef struct entry {
    	char *str;
    	int n;
		int isArray;
		int size;
		int arrayVal[1000];
	}vartable;
	vartable fntn[1000],f[1000],vptr[1000];
	
	int cnt2=1; 
	


		int total_Var=0;
		int is_var_exist(char *varName){
            for(int i = 0 ; i<total_Var; i++){
                if(strcmp(vptr[i].str,varName)==0){
                    return 1;
                }
            }
            return 0;
        }

        /* Get the index of variable that is called. If not found return -1. */
        int get_Var_Id(char *varName){
            for(int i = 0 ; i<total_Var; i++){
                if(strcmp(vptr[i].str,varName)==0){
                    return i;
                }
            }
            return -1;
        }
		void showExistance(char *varName){
            
            printf("%s is already Declared.\n",varName);
            
        }

		void declare_Var_table(char *varName,int val)
		{
			vptr[total_Var].str = varName;
			vptr[total_Var].n = val;
			
		}





	
%}
%union 
{
        int number;
        char *string;
}
/* BISON Declarations */

%token FUNC_NUM
%token<number> NUM 
%token<string> VAR FUNC_STR
%token<string> IF ELIF ELSE MAIN INT FLOAT DOUBLE CHAR LP RP LB RB CM SM PLUS MINUS MULT DIV POW ASSIGN FOR FOR_END COL WHILE WHILE_END BREAK DEFAULT CASE SWITCH SWITCH_END inc dec MOD LTE GTE EEQL NEQL AND OR NOT XOR
%token<string> SIN COS TAN SQRT LOG LOG2 LN FACTORIAL ARRAY size_of CALL
%type <string> para
%type <string> TYPE
%type <string> statement 
 
%type <number> expression
%type <number> switch_expression
%nonassoc ELIF
%nonassoc ELSE
%left LT GT LTE GTE EEQL NEQL
%left PLUS MINUS
%left MULT DIV
%left POW

/* Simple grammar rules */

%%

program: 
        | MAIN LP RP LB cstatement RB { printf("\nSuccessful compilation\n"); }
		| func_block program
	 ;

cstatement: /* empty */

	| cstatement statement cstatement
	
	| cstatement cdeclaration cstatement
	
	| cstatement func_call cstatement
	
	;

func_block: FUNC_NUM VAR LP Parameter RP LB statement RB
		{
			{
				int id = get_Var_Id($2);
            
            
            	if(id!=-1)
            	{
                	printf("already declared\n");
            	}
            	else
            	{
                	vptr[total_Var].str=$2;
					printf("func save %s\n",$2);
                	vptr[total_Var].n= $7;
					printf("%d func output %d\n",total_Var,$7);
                	total_Var++;
            	}

				


			}
			
			
			printf("Function name : %s\n",$2);
	
		}
 
func_call: CALL VAR LP pass_Parameter RP SM		
		{
			int id = get_Var_Id($2);
			printf("%s Fuction called\n",$2);
			printf("output of fuction : %d\n",vptr[id].n);									}

Parameter :
		| Parameter CM para		
		|	para					
		;
para : TYPE VAR						{printf("Parameter %s: %s\n",$1,$2);}
		;

pass_Parameter :
		| pass_Parameter CM NUM		
		| NUM					
		;


cdeclaration:	
				| cdeclaration TYPE ID1 SM	{ printf("\nvalid declaration\n"); }
				| ARRAY LP TYPE RP LP NUM RP VAR SM 	{
					
					int id = get_Var_Id($8);

            
            		if(id!=-1)
            		{	
                		printf("already declared\n");
            		}
            		else
            		{
                		vptr[total_Var].isArray = 1;
						vptr[total_Var].str = $8 ;
                		vptr[total_Var].size = $6;
                		total_Var++;
            		}
					
					printf("Array declaration Successful\n");
					printf("Printing table\n");
					for(int i = 0 ; i<total_Var; i++){
                		printf("%d %s\n",i,vptr[i].str);
                	}
            
 
				}

TYPE : INT		{ $$ = $1;  }

     | FLOAT	{ $$ = $1;  }

     | CHAR		{ $$ = $1;  }
     ;


ID1  : ID1 CM ID		{}
		| ID			{}
		;
ID	: VAR ASSIGN expression			
			{
				int id = get_Var_Id($1);
				
            	if(id==-1)
            	{

					vptr[total_Var].str=$1;
                	vptr[total_Var].n=$3;
                	total_Var++;

                	
            	}
            	else
            	{
                	vptr[id].str=$1;
                	vptr[id].n=$3;
            	}

				/*
				for(int i=0;i<total_Var;i++)
				{
					printf("%s",vptr[i].str);
					printf(" %d\n",vptr[i].n);
				}
				*/


			}
	| VAR

			{
				int id = get_Var_Id($1);
            
            
            	if(id!=-1)
            	{
                	printf("already declared\n");
            	}
            	else
            	{
                	vptr[total_Var].str=$1;
                	vptr[total_Var].n=0;
                	total_Var++;
            	}

				


			}
	

     ;


statement: SM
	| SWITCH LP switch_expression RP SWITCH_END LB BASE RB    {printf("SWITCH case.\n");val=$3;} 

	| expression SM 			{
								$$ = $1;
								printf("\nvalue of expression: %d\n", ($1)); }

	| size_of VAR SM				{
									int id = get_Var_Id($2);
									printf("total size of %s is %d \n",$2,vptr[id].size);}
	
	

    | VAR ASSIGN expression	SM		
			{
				int id = get_Var_Id($1);
				
            	if(id==-1)
            	{

					vptr[total_Var].str=$1;
                	vptr[total_Var].n=$3;
                	total_Var++;

                	
            	}
            	else
            	{
                	vptr[id].str=$1;
                	vptr[id].n=$3;
            	}

				/*
				for(int i=0;i<total_Var;i++)
				{
					printf("%s",vptr[i].str);
					printf(" %d\n",vptr[i].n);
				}
				*/ 

			}  
	
	| VAR LP NUM RP ASSIGN expression	SM		
			{
				int id = get_Var_Id($1);
				
            	if(id==-1)
            	{

					/* error */

                	
            	}
            	else
            	{
                	vptr[id].arrayVal[$3] = $6;
            	}

				/*
				for(int i=0;i<total_Var;i++)
				{
					printf("%s",vptr[i].str);
					printf(" %d\n",vptr[i].n);
				}
				*/ 

			}  

	| IF LP expression RP LB statement RB {
								if($3)
								{
									printf("\nTrue conditioin. IF executes : %d\n",($6));
								}
								else
								{
									printf("\nFalse condition.If not executes\n");
								}
							}

	| IF LP expression RP LB statement RB ELSE LB statement RB {
								 	if($3)
									{
										printf("\nTrue conditioin. IF executes : %d\n",$6);
									}
									else
									{
										printf("\nFalse condition. Else executes %d\n",$10);
									}
								   }													   
	| FOR LP NUM COL NUM RP FOR_END LB expression RB     {
	   printf("For Loop :\n");
	   int i;
	   for(i=$3;i<$5;i++){
	   printf("Iteration no : %d and expression or statement value : %d\n",i,$9);
	   }
	}
	/*while loop starts*/

	| WHILE LP NUM LT NUM RP WHILE_END LB expression RB   {
								int i = $5,j=0;
								printf("While LOOP:\n");
								while($3 < i)
								{
									printf("Iteration no : %d and expression or statement value : %d\n" ,j, $9);
									i--;
									j++;
								}
								printf("\n");
								
										

						}
	;
	
	|WHILE LP NUM GT NUM RP WHILE_END LB expression RB   {
								int i = $5,j=0;
								printf("While LOOP:\n");
								while($3 > i)
								{
									printf("Iteration no : %d and expression or statement value : %d\n" ,j, $9);
									i++;
									j++;
								}
								printf("\n");
								
										

						}
	;
///////////////////////
	
			BASE : Bas   
				 | Bas Dflt 
				 ;

			Bas   : /*NULL*/
				 | Bas Cs     
				 ;

			Cs    : CASE NUM COL expression SM   {
						
						if(val==$2){
							  track=1;
							  printf("\nCase No : %d  and Result :  %d\n",$2,$4);
						}
					}
				 ;

			Dflt    : DEFAULT COL expression SM    {
						if(track!=1){
							printf("\nResult in default Value is :  %d\n",$3);
						}
						track=0;
					}
				 ;    
	/////////////////////////////
	
	
expression: NUM				{ $$ = $1; 	}
	| VAR
			{
				int id = get_Var_Id($1);
            	$$ = vptr[id].n;

			}

	| VAR LP NUM RP
			{
				int id = get_Var_Id($1);
            	$$ = vptr[id].arrayVal[$3];

			}
	

	| expression PLUS expression	{
		 $$ = $1 + $3;
		 printf("%d + %d : \n",$1,$3); }

	| expression MINUS expression	{ $$ = $1 - $3; printf("%d - %d : \n",$1,$3);}

	| expression MULT expression	{ $$ = $1 * $3; printf("%d * %d : \n",$1,$3);}

	| expression DIV expression	{ 	if($3) 
				  		{
				     			$$ = $1 / $3;
								printf("%d / %d : \n",$1,$3);
				  		}
				  		else
				  		{
							$$ = 0;
							printf("\ndivision by zero error\t");
				  		} 	
				    	}
	| expression POW expression { $$ = pow($1,$3); printf("%d ^ %d : \n",$1,$3);}


	| expression LT expression	{ $$ = $1 < $3; }

	| expression GT expression	{ $$ = $1 > $3; }

	| LP expression RP		{ $$ = $2;	}
	
	| expression inc         { $$=$1+1; printf("inc: %d\n",$$);}
	| expression dec         { $$=$1-1; printf("dec: %d\n",$$);}

	| PLUS expression
    {
        $$ = $2;
    }
    | MINUS expression
    {
        $$ = -$2;
    }
            
    | expression MOD expression         
    {

        $$ = (int)$1 % (int)$3;
    }
            
    | expression LTE expression        
    {
        $$ = ($1 <= $3);
    }
    | expression GTE expression        
    {
        $$ = ($1 >= $3);
    }
    | expression EEQL expression         
    {
        $$ = ($1 == $3);
    }
	| expression NEQL expression        
    {
        $$ = ($1 != $3);
    }
    | expression AND expression         
    {
        $$ = ( $1 && $3);
		printf("%d AND %d : \n",$1,$3);
    }
    | expression OR expression          
    {
        $$ = ($1 || $3);
		printf("%d OR %d : \n",$1,$3);
    }
    | expression XOR expression         
    {
        $$ = ((int)$1 ^ (int)$3);
		printf("%d XOR %d : \n",$1,$3);
    }
	| NOT expression              
    {
        $$ = !$2;
    }
    | '(' expression ')'          
    {
        $$ = $2;
    }
    | SIN '(' expression ')'      
    {
        $$ = sin($3);
		printf("sin( %d ) : \n",$3);

    }
    | COS '(' expression ')'      
    {
        $$ = cos($3);
		printf("cos( %d ) : \n",$3);
    }
    | TAN '(' expression ')'      
    {
        $$ = tan($3);
		printf("tan( %d ) : \n",$3);
    }
    | LOG '(' expression ')'      
    {
        $$ = log10($3);
		printf("log10( %d ) : \n",$3);
    }
    | LOG2 '(' expression ')'     
    {
        $$ = log2($3);
		printf("log2( %d ) : \n",$3);
    }
    | LN '(' expression ')'       
    {
        $$ = log($3);
    }
    | SQRT '(' expression ')'     
    {
    	$$ = sqrt($3);
		
    }
	| expression FACTORIAL   
                {
                    long long x = 1;
                	for(long long i=1;i<=$1;i++)
					 	x*=i;
                    $$ = x;
                    
                }

	
	;
	///////////////////////////////////////
	switch_expression: NUM				{ $$ = $1; val = $$;	}

	| switch_expression PLUS switch_expression	{ $$ = $1 + $3; val = $$; }

	| switch_expression MINUS switch_expression	{ $$ = $1 - $3; val = $$; }

	| switch_expression MULT switch_expression	{ $$ = $1 * $3;  val = $$;}

	| switch_expression DIV switch_expression	{ 	if($3) 
				  		{
				     			$$ = $1 / $3; val = $$;
				  		}
				  		else
				  		{
							$$ = 0;
							 val = $$;
				  		} 	
				    	}
	| switch_expression POW switch_expression { $$ = pow($1,$3);  val = $$;}

	
	;
%%




int yywrap()
{
return 1;
}


yyerror(char *s){
	printf( "%s\n", s);
}