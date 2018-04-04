---
title: "Operações Básicas"
author: "Jônatan Tatsch"
date: "04-04-2018"
output:
  html_document:
    fig_caption: yes
    fig_width: 6
    highlight: kate
    keep_md: yes
    number_sections: yes
    toc: yes
---




- - -

![](figs/adar.png)

- - -

# Objetivos

Nesta seção veremos:

- operações aritméticas básicas com R
- a atribuição de valores a uma variável
- o uso de funções matemáticas internas do R
- valores numéricos especiais do R
- os cuidados ao nomear variáveis

# CalculadoRa

O R é uma calculadora turbinada com diversas funções matemáticas disponíveis. Para quem não conhece o R, essa uma forma de familiarizar-se com a linha de comandos do R.

## Aritmética básica

Todas operações feitas em uma  calculadora podem ser realizadas na linha de comandos do R.


```r
10 + 2 + 4
#> [1] 16
# Exemplo de divisao 
(5 + 14)/2
#> [1] 9.5
# exponenciação
2^3
#> [1] 8
4^0.5
#> [1] 2
# operador artimético para se determinar o resto de uma divisao
10 %% 2
#> [1] 0
2001 %% 2
#> [1] 1
# operador de divisão inteira
11 %/% 2
#> [1] 5
```

Conheça mais operadores aritméticos, digitando na linha de comando:


```r
?"Arithmetic"
```

A janela aberta mostrará outros operadores aritméticos disponíveis com o R. O texto mostrado faz parte do manual de ajuda do R.

## Constantes

O R possui algumas constantes pré-definidas, como o a constante pi (π).


```r
pi
#> [1] 3.141593
```

O R também trabalha com caracteres, alguns vetores de caracteres pré-definidos são:


```r
LETTERS
#>  [1] "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q"
#> [18] "R" "S" "T" "U" "V" "W" "X" "Y" "Z"
letters
#>  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q"
#> [18] "r" "s" "t" "u" "v" "w" "x" "y" "z"
month.abb
#>  [1] "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov"
#> [12] "Dec"
month.name
#>  [1] "January"   "February"  "March"     "April"     "May"      
#>  [6] "June"      "July"      "August"    "September" "October"  
#> [11] "November"  "December"
```

Note que caracteres estão sempre entre aspas: `""`.



```r
vogais <- aeiou
#> Error in eval(expr, envir, enclos): object 'aeiou' not found
```


```r
vogais <- "aeiou"
vogais
#> [1] "aeiou"
```


## Funções matemáticas internas

Existem diversas funções internas do R que permitem, por exemplo, sortear números aleatóriamente, arrendondar números, calcular o fatorial, calcular o seno, cosseno de um ângulo e etc. A sintaxe para chamar uma função no R é:

<span style="color:black; font-size:1.3em; font-weight: bold"> funcão(argumento) </span>


Por exemplo:


```r
# funções trigonométricas
sin(pi/6)
#> [1] 0.5
cos(pi)
#> [1] -1
# raiz quadrada
sqrt(100)
#> [1] 10
# exponencial
exp(1)
#> [1] 2.718282
# fatorial
factorial(4)
#> [1] 24
```

No R você verá que parênteses são frequentemente utilizados. Eles são sempre associados à funções. Qualquer palavra antecedendo um parênteses é uma função.

Para ver a lista completa de funções trigonométricas:

```r
?"Trig"
```

<span style="color:red; font-size:1.1em;"> notas de aula da aula 3 disponíveis [aqui](https://www.dropbox.com/sh/em7x1kh6xxull6k/AABix5FF0EqLJ67a7GrA2Hzga?dl=0) </span>


## Valores numéricos especiais

Um caso particular sobre operação aritméticas no R, são os valores numéricos `Inf`e `NaN` que resultam de operações como:


```r
2/0
#> [1] Inf
-12/0
#> [1] -Inf
exp(-Inf)
#> [1] 0
log(0)
#> [1] -Inf
0/Inf
#> [1] 0
(0:3)^Inf
#> [1]   0   1 Inf Inf
log(-0.5)
#> Warning in log(-0.5): NaNs produced
#> [1] NaN
sqrt(-1)
#> Warning in sqrt(-1): NaNs produced
#> [1] NaN
0/0 
#> [1] NaN
Inf-Inf
#> [1] NaN
Inf/Inf
#> [1] NaN
mean(c(NA, NA), na.rm = TRUE)
#> [1] NaN
```

`NaN` é a abreviação para *Not a Number*. Geralmente surge quando um cálculo não tem sentido matemático ou não pode ser propriamente realizado.

A demonstração das diferentes formas de se obter essas constantes especiais é importante para entender a origem delas durante a execução de um script mais extenso.

Outra constante especial do R é o `NA` (*Not Available*) que representa valor faltante, um problema comum em análise de dados. Qualquer operação envolvendo `NA` resultará em `NA` (Tabela 1). 


Table: Tabela 1. Operações com NA.

 operação    resultado 
----------  -----------
  NA + 5        NA     
 sqrt(NA)       NA     
   NA^2         NA     
  NA/NaN        NA     


## Notação científica e número de dígitos

Na maioria das vezes precisamos trabalhar com números grandes e consequentemente acabamos usando uma notação científica ou exponencial. No R há diferentes formas de representar números com expoentes:


```r
1.2e-6
#> [1] 1.2e-06
# expressões equivalentes
1.2E6; 1.2*10^6  
#> [1] 1200000
#> [1] 1200000
```

Os resultados dos cálculos no R são mostrados com 7 dígitos significativos, o que pode ser verificado pela `getOptions()`. É possível mudar para `n` dígitos usando a função `options()`, conforme exemplo abaixo.


```r
# opção de dígitos padrão
getOption("digits")
#> [1] 7
exp(1)
#> [1] 2.718282
# alterando para 14
options(digits = 14)
exp(1)
#> [1] 2.718281828459
getOption("digits")
#> [1] 14
# redefinindo para o número de casas decimais padrão
options(digits = 7)
getOption("digits")
#> [1] 7
```

# Variáveis

## Formas de atribuição 

### Variável recebe valor

Até agora nós usamos expressões para fazer uma operação e obter um resultado. O termo \"expressão\" significa uma sentença de código que pode ser executada. Se a avaliação de uma expressão é salva usando o operador `<-`, esta combinação é chamada \"atribuição\". O resultado da \"atribuição\" é armazenado e pode ser utilizado posteriormente. 

O que é uma variável? É um nome usado para guardar os dados. Por exemplo para atribuir o valor 1013 a variável chamado `p` usamos a combinação dos símbolos menor (`<`) e menos (`-`) `<-` entre os dois números. Esse é o símbolo de atribuição a uma variável.


```r
p <- 1013
# para mostrar a variável digite o nome da variável
p
#> [1] 1013
# ou use a função print()
print(p)
#> [1] 1013
```

O R diferencia letras maiúsculas de minúsculas. Portanto `p` e `P` são variáveis diferentes.


```r
p
#> [1] 1013
P
#> Error in eval(expr, envir, enclos): object 'P' not found
```

Como criamos apenas a variável `p`, `P` não foi encontrada. 

A variável `p` pode ser utilizado para criar outras variáveis.


```r
p_pa <- p * 100
# pressão em Pascal
p_pa
#> [1] 101300
```

A seta de atribuição pode ser usada em qualquer sentido. Parênteses, além de estarem sempre acompanhando uma função, também são usados para indicar a prioridade dos cálculos.


```r
7/3 + 0.6 -> y1
 y1
#> [1] 2.933333
7/(3 + 0.6) -> y2
 y2
#> [1] 1.944444
```

Os espaços em torno do símbolo de atribuição (` <- `) não são obrigatórios mas eles ajudam na legibilidade do código.


```r
x <- 1
x < -1
# atribuição ou menor que?
x<-1 
```

Vamos criar uma variável chamada `ndias3` que recebe o nº de dias no mês de Março e `ndias4` que recebe o nº de dias no mês de Abril.


```r
nd3 <- 31
nd4 <- 30
```

O total de dias nos meses de março e abril será armazenado na variável `totdias`:


```r
totd <- nd3 + nd4
totd
#> [1] 61
```

A atribuição de um mesmo valor para diferentes variáveis pode ser feita da seguinte forma:


```r
# número de dias em cada mês
jan <- mar <- mai <- jul <- ago <- out <- dez <- 31
abr <- jun <- set <- nov <- 30
fev <- 28
# verificação
jan; jul
#> [1] 31
#> [1] 31
jun; set
#> [1] 30
#> [1] 30
fev
#> [1] 28
```

Nós estamos definindo a variável, digitando o nome dela na linha de comando e teclando enter para ver o resultado. Há uma forma mais prática de fazer isso e mostrar o resultado cercando a atribuição por parênteses:


```r
# ao invés de 
# tar <- 20
# tar
# é mais prático
(tar <- 20) 
#> [1] 20
```

Se desejamos calcular e já visualizar o valor da pressão de vapor de saturação obtida com a [equação de Tetens](https://en.wikipedia.org/wiki/Tetens_equation), podemos fazer:


```r
(es <- 0.611 * exp((17.269 * tar)/(tar + 237.3)))
#> [1] 2.338865
```

Quando usamos a mesma variável numa sequência de atribuições o seu valor é sobrescrito. Portanto não é bom usar nomes que já foram usados antes, exceto se a intenção for realmente essa. Para saber os nomes das variáveis já usados use a função `ls()`[^1] para verificar as variáveis existentes:


```r
ls()
#>  [1] "abr"      "ago"      "dez"      "es"       "fev"      "jan"     
#>  [7] "jul"      "jun"      "mai"      "mar"      "nd3"      "nd4"     
#> [13] "nov"      "oper_nas" "out"      "p"        "pcks"     "p_pa"    
#> [19] "set"      "tar"      "totd"     "vogais"   "y1"       "y2"
```

[^1]: Essa lista de variáveis também é mostrada no painel *Environment* do RStudio (canto direito superior, aba *Environment*).



```r
totd <- jan*7; totd <- totd + fev; totd <- totd + 4*abr
totd
#> [1] 365
```

### Atribuição com a função `assign()`


Outra forma de atribuição é através da função `assign()`:


```r
es
#> [1] 2.338865
assign(x = "es_hpa", value = es/10)
es_hpa
#> [1] 0.2338865
# usando função assign sem nome dos parâmetros
assign("u", 2.5)
u
#> [1] 2.5
```

Um exemplo mais elaborado de uso da função `assign()` para criar várias variáveis pode ser visto [aqui](https://gist.github.com/lhmet/d28856ed16690bb45d5be36ea4f5d458#file-assign-ex-rmd).

## Removendo variáveis

Para remover variáveis usa-se a função `rm()`.


```r
# lista de variáveis existentes
ls()
#>  [1] "abr"      "ago"      "dez"      "es"       "es_hpa"   "fev"     
#>  [7] "jan"      "jul"      "jun"      "mai"      "mar"      "nd3"     
#> [13] "nd4"      "nov"      "oper_nas" "out"      "p"        "pcks"    
#> [19] "p_pa"     "set"      "tar"      "totd"     "u"        "vogais"  
#> [25] "y1"       "y2"
```

Vamos remover a variável `u` criada previamente e ver a lista de objetos no espaço de trabalho.


```r
rm(u)
# lista de variáveis existentes, sem u
ls()
#>  [1] "abr"      "ago"      "dez"      "es"       "es_hpa"   "fev"     
#>  [7] "jan"      "jul"      "jun"      "mai"      "mar"      "nd3"     
#> [13] "nd4"      "nov"      "oper_nas" "out"      "p"        "pcks"    
#> [19] "p_pa"     "set"      "tar"      "totd"     "vogais"   "y1"      
#> [25] "y2"
```

Podemos remover mais de uma variável ao mesmo tempo.


```r
rm(es_hpa, es, tar, y1, y2)
# lista de variáveis existentes, sem es_hpa, es, tar, y1, y2
ls()
#>  [1] "abr"      "ago"      "dez"      "fev"      "jan"      "jul"     
#>  [7] "jun"      "mai"      "mar"      "nd3"      "nd4"      "nov"     
#> [13] "oper_nas" "out"      "p"        "pcks"     "p_pa"     "set"     
#> [19] "totd"     "vogais"
```

Para remover todas variáveis do espaço de trabalho (use com cautela):


```r
# apagando tudo
rm(list = ls())
ls()
#> character(0)
```



## Nomeando variáveis

É preciso ter cuidado ao nomear variáveis no R porque existem algumas regras:

* não iniciar com um número e não conter espaços


```r
1oAno <- 1990
raizDe10 <- srt(2)
variavel teste <- 67
```


```r
# nomes alternativos para as variaveis
ano1 <- 1990
variavel_teste <- 67
variavel.teste <- 68
```

* não conter símbolos especiais: 
    
        ^, !, $, @, +, -, /, ou *


```r
dia-1 <- 2
#> Error in dia - 1 <- 2: object 'dia' not found
# alternativa
dia_1 <- 2
```

* evitar o uso de nomes usados em objetos do sistema (funções internas do R ou constantes como o número π):

        c q  s  t  C  D  F  I  T  diff  exp  log  mean  pi  range  rank  var

        FALSE  Inf  NA  NaN  NULL TRUE 
     
        break  else  for  function  if  in  next  repeat  while


* variáveis com acento são permitidas mas não recomendadas.


```r
verão <- "DJF"
verão
#> [1] "DJF"
```
   
Uma boa prática de programação é usar nomes informativos para as variáveis para legibilidade do código. Uma boa referência para isso é a seção [**Sintaxe**](http://style.tidyverse.org/syntax.html) do [Guia de estilo tidyverse (ou universo arrumado)](http://style.tidyverse.org/).

# Funções e operadores utilizados

Matemática

- `+`
- `-`
- `^`
- `/`
- `%%`
- `%/%`
- `*`
- `sin()`
- `cos()`
- `sqrt()`
- `exp()`
- `log()`
- `factorial()`

Sequência regular

- `:`

Opções de configuração

- `getOption()`
- `options()`

Atribuição

- `<-`
- `assign()`

Ambiente de trabalho

- `ls()`
- `rm()`


<br/>

<p style="font-family: verdana; font-size: 14px; font-style: italic; background: whitesmoke; color: black; line-height: 14px;width: 900px;">Próximo: [Tipos de Dados](https://rawgit.com/jdtatsch/adar-ufsm/master/4_TiposDeDados.html)</p> 

