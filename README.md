# Analisador Léxico de linguagem C
Implementação de um analisador léxico utilizando Flex para analisar uma linguagem C.

## O que é um analisador léxico?
Um analisador léxico, ou scanner, é um programa que implementa um autômato finito, reconhecendo (ou não) strings como símbolos válidos de uma linguagem. A implementação de um analisador léxico requer uma descrição do autômato que reconhece as sentenças da gramática ou expressão regular de interesse. A sentença a ser reconhecida é estruturada como uma lista de símbolos, que é passada como argumento para o analisador léxico juntamente com a referência para o autômato.

Em linguagens de programação é o analisador léxico que analisa o código fonte para verificar se todas as sentenças fazem parte da linguagem e, para isso, transforma as strings em tokens. Um Token em computação é um segmento de texto ou símbolo que pode ser manipulado por um analisador sintático, que fornece um significado ao texto, ou seja, é um conjunto de caracteres com um significado coletivo. Esses tokens são passados para o analisador sintático, que irá verificar se a estrutura gramatical do código está correta.

Analisadores léxicos podem ser implementados em linguagens de programação para reconhecer e verificar uma sequência de strings e gerar os tokens. Devido à complexidade de implementação de um analisador existem geradores automáticos que facilitam o trabalho de criar um desses para sua linguagem regular. Nesse trabalho será utilizado o Flex (fast lexical analyzer generator), que a partir das regras de gramática impostas gera automaticamente um analisador léxico em linguagem C.

## Construindo uma linguagem regular
As descrições da linguagem regular irão definir as regras e os símbolos aceitos na nossa linguagem. Definir o alfabeto e as expressões regulares da sua linguagem é o ponto mais importante da criação de um analisador léxico. Para esse trabalho foi tomada como referência a linguagem de programação C.

### Alfabeto
O alfabeto é o conjunto de todos os caracteres que irão formar as strings da nossa linguagem regular. O alfabeto estabelecido para essa linguagem é:

Σ = (0, 1, ..., 9, a, ..., z, A, ..., Z, //, , +, -, *, /, %, =, <, >, !, {, }, ; , ', , , ", ., #, &, (, ), [, ])
