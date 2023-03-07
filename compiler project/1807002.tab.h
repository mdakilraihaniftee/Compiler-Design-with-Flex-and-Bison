
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     FUNC_NUM = 258,
     NUM = 259,
     VAR = 260,
     FUNC_STR = 261,
     IF = 262,
     ELIF = 263,
     ELSE = 264,
     MAIN = 265,
     INT = 266,
     FLOAT = 267,
     DOUBLE = 268,
     CHAR = 269,
     LP = 270,
     RP = 271,
     LB = 272,
     RB = 273,
     CM = 274,
     SM = 275,
     PLUS = 276,
     MINUS = 277,
     MULT = 278,
     DIV = 279,
     POW = 280,
     ASSIGN = 281,
     FOR = 282,
     FOR_END = 283,
     COL = 284,
     WHILE = 285,
     WHILE_END = 286,
     BREAK = 287,
     DEFAULT = 288,
     CASE = 289,
     SWITCH = 290,
     SWITCH_END = 291,
     inc = 292,
     dec = 293,
     MOD = 294,
     LTE = 295,
     GTE = 296,
     EEQL = 297,
     NEQL = 298,
     AND = 299,
     OR = 300,
     NOT = 301,
     XOR = 302,
     SIN = 303,
     COS = 304,
     TAN = 305,
     SQRT = 306,
     LOG = 307,
     LOG2 = 308,
     LN = 309,
     FACTORIAL = 310,
     ARRAY = 311,
     size_of = 312,
     CALL = 313,
     GT = 314,
     LT = 315
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 58 "1807002.y"

        int number;
        char *string;



/* Line 1676 of yacc.c  */
#line 119 "1807002.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


