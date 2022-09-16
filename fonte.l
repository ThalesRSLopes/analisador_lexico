%{
	#include <stdio.h>
	#include <stdbool.h>
  	int linhas=1, erros=0;
%}

DIGITO		[0-9]
COMENTARIO	"//"[^\n]*
ESPACO		[\t\r" "]
LETRA  		[A-Za-z][A-Za-z]*
OPERADOR 	[+*/%-]
RELACIONAL 	[=<>!]
FORMATACAO 	[{};',".#&()]

%%

{ESPACO}

{DIGITO}+{LETRA} { //Verifica nomes de variáveis inválidas (começadas com número)
	printf("Identificador inválido: %s - ", yytext);
  	erros++;
  	printf("Linha: %d\n", linhas);
}

{LETRA}|{LETRA}+{DIGITO}* { //Verifica palavras reservadas, valores booleanos, tipos de variáveis ou nomes de variáveis
	bool flag = true; //bandeira utilizada pra garantir que a verificação ocorrerá somente uma vez por string
	
	//identifica palavras reservadas (for, if, else, do, while, main, return, printf, scanf, include e define)
	if((strcmp(yytext, "for") == 0 | strcmp(yytext, "if") == 0| strcmp(yytext, "else") == 0| strcmp(yytext, "do") == 0| strcmp(yytext, "while") == 0| strcmp(yytext, "main") == 0| strcmp(yytext, "return") == 0| strcmp(yytext, "printf") == 0| strcmp(yytext, "scanf") == 0| strcmp(yytext, "include") == 0| strcmp(yytext, "define") == 0) && flag){
    printf("Palavra reservada: %s \n", yytext);
	flag = false;
  	}
	
	//identifica valor booleano
	if((strcmp(yytext, "true") == 0 | strcmp(yytext, "false") == 0) && flag){
    printf("Valor booleano: %s \n", yytext);
	flag = false;
  	}
	
	//identifica tipo de variável (int, char, bool, float, double)
	if((strcmp(yytext, "int") == 0 | strcmp(yytext, "char") == 0| strcmp(yytext, "bool") == 0| strcmp(yytext, "float") == 0| strcmp(yytext, "double") == 0) && flag){
    printf("Tipo de variável: %s \n", yytext);
	flag = false;
  	}
	
	if(flag){
	printf("Identificador válido: %s \n", yytext);
	flag = false;
	}
}

{DIGITO}+ { //Verifica valores inteiros
	printf("Valor inteiro: %s\n",yytext);
}

{DIGITO}+"."{DIGITO}+|"."{DIGITO}+ { //Verifica valores reais (a parte inteira e a parte fracionaria é separada por ".")
	printf("Valor real: %s\n",yytext);
}

{OPERADOR} { //Verifica operador matemático
  printf("Operador matemático: %s\n",yytext);
}

{OPERADOR}+ { //Verifica operadores matemáticos em sequência
	bool flag = true; //bandeira utilizada pra garantir que a verificação ocorrerá somente uma vez por string
	
	//os operadores matemáticos que são mais de um simbolo (++,--)
	if((strcmp(yytext, "++") == 0 | strcmp(yytext, "--")) && flag){
    printf("Operador matemático: %s \n", yytext);
	flag = false;
  	}
		
    if(flag){
	printf("Operador inválido: %s - ",yytext);
    erros++;
    printf("Linha: %d\n", linhas);
	flag = false;
	}
}

{RELACIONAL} { //Verifica operador lógico
  printf("Operador relacional: %s\n",yytext);
}

{RELACIONAL}+ { //Verifica operadores lógicos em sequência
	bool flag = true; //bandeira utilizada pra garantir que a verificação ocorrerá somente uma vez por string
	
	//os operadores lógicos que são mais de um simbolo (==, <=, >=, !=)
	if((strcmp(yytext, "==") == 0 | strcmp(yytext, "<=") == 0| strcmp(yytext, ">=") == 0| strcmp(yytext, "!=") == 0) && flag){
    printf("Operador relacional: %s \n", yytext);
	flag = false;
  	}
	
	if(flag){
	printf("Operador inválido: %s - ",yytext);
    erros++;
    printf("Linha: %d\n", linhas);
	flag = false;
	}
}

{OPERADOR}{RELACIONAL} { //Verifica expressões matemáticas de atribuição
	bool flag = true; //bandeira utilizada pra garantir que a verificação ocorrerá somente uma vez por string
	
	//operadores matemáticas de atribuição (+=, -=, /=, *=, %=)
	if((strcmp(yytext, "+=") == 0 | strcmp(yytext, "-=") == 0| strcmp(yytext, "*=") == 0| strcmp(yytext, "/=") == 0| strcmp(yytext, "%=") == 0) && flag){
    printf("Operador matemático de atribuição: %s \n", yytext);
	flag = false;
  	}
	
	if(flag){
	printf("Operador inválido: %s - ",yytext);
    erros++;
    printf("Linha: %d\n", linhas);
	flag = false;
	}
}

{RELACIONAL}{OPERADOR} { //Não existe operador que seja um relacional seguido de um matemático
	printf("Operador inválido: %s - ",yytext);
    erros++;
    printf("Linha: %d\n", linhas);
}

{FORMATACAO} { //Verifica simbolos de estruturação
  printf("Simbolo de estrutura: %s\n",yytext);
}

{COMENTARIO} { //Comentários Simples
  printf("Comentário: %s\n",yytext);
}

\n {
linhas++;
}

. { //Se não for nenhuma regra válida adiciona um erro
	bool flag = true; //bandeira utilizada pra garantir que a verificação ocorrerá somente uma vez por string
	
	//os operadores lógicos que são mais de um simbolo (==, <=, >=)
	if((strcmp(yytext, "[") == 0 | strcmp(yytext, "]") == 0) && flag){
    printf("Simbolo de estrutura: %s \n", yytext);
	flag = false;
  	}
	
	if(flag){
    printf("Token inválido: %s - ",yytext);
    erros++;
    printf("Linha: %d\n", linhas);
	}
}

%%

int yywrap();
int main() {
  yylex();
  printf("Linhas: %d \n", linhas);
  printf("Total de erros encontrados: %d\n", erros);
  if(erros==0)
    puts("\nCódigo analisado com sucesso!\n");
}

int yywrap() {
  return 1;
}