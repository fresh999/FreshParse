/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    BEG = 258,
    DOC_ID = 259,
    PREAMBLE_ID = 260,
    BEG_PREAMBLE = 261,
    END = 262,
    BEG_DISPLAY_MATH = 263,
    END_DISPLAY_MATH = 264,
    BEG_THEOREM = 265,
    BEG_PROPOSITION = 266,
    BEG_LEMMA = 267,
    BEG_PROOF = 268,
    END_THEOREM = 269,
    END_PROPOSITION = 270,
    END_LEMMA = 271,
    END_PROOF = 272,
    BEG_ENUMERATE = 273,
    END_ENUMERATE = 274,
    ITEM = 275
  };
#endif
/* Tokens.  */
#define BEG 258
#define DOC_ID 259
#define PREAMBLE_ID 260
#define BEG_PREAMBLE 261
#define END 262
#define BEG_DISPLAY_MATH 263
#define END_DISPLAY_MATH 264
#define BEG_THEOREM 265
#define BEG_PROPOSITION 266
#define BEG_LEMMA 267
#define BEG_PROOF 268
#define END_THEOREM 269
#define END_PROPOSITION 270
#define END_LEMMA 271
#define END_PROOF 272
#define BEG_ENUMERATE 273
#define END_ENUMERATE 274
#define ITEM 275

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */