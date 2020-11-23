import java_cup.runtime.*;
%%

%public
%class CodeScanner
%line
%column
%unicode
%type Symbol
//%standalone
%state STRING
%cup

%{

    private StringBuffer str = new StringBuffer();      // stting buffer keeps input strings until scanner sees \"
    public Symbol token(int type){
        System.out.println(yytext() + " " + type);
        return new Symbol(type, yytext());
    }

%}
// this section is for defining all needed regex
// defined regex
letters = [A-Z|a-z]
digits = [0-9]
DecimalInt = [0-9]+
HexadecimalInt = [0][Xx][0-9a-fA-F]+

// check : should conatain WhiteSpace ???
ScientificNotation =  [eE][+-]{digits}* | [eE]{digits}*
// white spaces
EndOfLine = [\r|\n|\r\n]
WhiteSpace = {EndOfLine} | [ \t\f]

// Identifiers
Identifier = {letters}({digits}|{letters}|[_])*

// Numbers
Integer = {DecimalInt} | {HexadecimalInt}
Double = ( {digits}+[.]{digits}*  {ScientificNotation} ) |  ( {digits}+[.]{digits}* )
// punctuations

Comments = "//" [^\r\n]* [\r\n]
ERRstring = "\"" [^\r\n]* [\r\n]

%%
<YYINITIAL>{

    // keywords : define all resereved keywords
    "int"               {return token(sym.type_int);     }
    "void"              { return token(sym.type_void);      }
    "double"            {return token(sym.type_double);     }
    "bool"              {return token(sym.type_bool);     }
    "string"            {return token(sym.type_string);     }
    "class"             {return token(sym.keywords_class);     }
    "interface"          {return token(sym.keywords_interface);     }
    "null"              {return token(sym.keywords_null);     }
    "this"              {return token(sym.keywords_this);     }
    "extends"           {return token(sym.keywords_extends);     }
    "implements"        {return token(sym.keywords_implements);     }
    "for"               {return token(sym.keywords_for);     }
    "while"             {return token(sym.keywords_while);     }
    "if"               {return token(sym.keywords_if);     }
    "else"              {return token(sym.keywords_else);     }
    "return"            {return token(sym.keywords_return);     }
    "break"             {return token(sym.keywords_break);     }
    "continue"          {return token(sym.keywords_continue);     }
    "new"               {return token(sym.keywords_new);     }
    "NewArray"          {return token(sym.key_words_NewArray);     }
    "Print"             {return token(sym.keywords_Print);     }
    "Read"              {return token(sym.keywords_Read);     }
    "Integer"           {return token(sym.keywords_Integer);     }
    "ReadInteger"      {return token(sym.keywords_ReadInteger);     }
    "ReadLine"          {return token(sym.keywords_ReadLine);     }
    "dtoi"              {return token(sym.keywords_dtoi);     }
    "itod"              {return token(sym.keywords_itod);     }
    "btoi"              {return token(sym.keywords_btoi);     }
    "itob"              {return token(sym.keywords_itob);     }
    "private"           {return token(sym.keywords_private);     }
    "protected"         {return token(sym.keywords_protected);     }
    "public"            {return token(sym.keywords_public);     }
    /* OPERATORS */






    // Operators
    "+"                 {return token(sym.plus);     }
    "-"                 {return token(sym.minus);     }
    "*"                 {return token(sym.mult);     }
    "/"                 {return token(sym.divide);     }
    "%"                 {return token(sym.mod);     }
    "="                 {return token(sym.assign);     }
    // Comparators
    "<"               {return token(sym.lt);     }
    "<="              {return token(sym.le);     }
    ">"                {return token(sym.gt);     }
    ">="                {return token(sym.ge);     }
    "="                {return token(sym.assign);     }
    "=="                {return token(sym.equal);     }
    "!="               {return token(sym.nequal);     }
    // LogicalOperators
    "&&"               {return token(sym.and);     }
    "||"                {return token(sym.or);     }
    "!"                 {return token(sym.exclamation);     }
    //Seperators
    ";"                {return token(sym.semiColon);}
    ","                {return token(sym.colon);     }
    "."                 {return token(sym.dot);     }
    "["                {return token(sym.open_brace);     }
    "]"                {return token(sym.close_brace);     }
    "("                 {return token(sym.open_parenthese);     }
    ")"                 {return token(sym.close_parenthese);     }
    "{"                  {return token(sym.open_bracket);     }
    "}"                  {return token(sym.close_bracket);     }
    // Boolean Literal
    "true"               {return token(sym.bool_const);     }
    "false"             {return token(sym.bool_const);     }



    {Identifier}        {return token(sym.identifier);     }
    {EndOfLine}         {/* ignore */}  // check : what should be return ?
    {WhiteSpace}        {/* ignore */}
    {Integer}           {return token(sym.numbers);     }
    {Double}           {return token(sym.double_const);     }
     \"                 {   }
    {Comments}          { }

}


// this is a state to return STRING LITERAL
<STRING> {
    \"                  {     }
    [^\n\r\"]+          {  }
    /* error reporting */
    [\n\r]              {      }

}

    // any unknown charachter returns an error
    /* error reporting */
    [^]                 {   }


// if end of file reached, scanner returns a defined token for EOF
//<<EOF>>             { return new Token( TokenTypes.EOF ); }