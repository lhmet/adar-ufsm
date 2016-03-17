# Operações Básicas
Jônatan Tatsch  
`r format(Sys.Date(), format = '%d-%m-%Y')`  



- - -

![](figs/adar.png)

- - -

# Objetivos

Nesta seção veremos:

- como realizar operações aritméticas básicas com R
- atribuir valores a uma variável
- utilizar funções matemáticas internas do R
- alguns valores numéricos especiais do R
- os cuidados ao nomear variáveis

# CalculadoRa

O R é uma calculadora turbinada com diversas funções matemáticas disponíveis. Para quem não conhece o R, essa uma forma de familiarizar-se com a linha de comandos do R.

## Aritmética básica

Todas operações feitas em uma  calculadora podem ser realizadas na linha de comandos do R.


```r
10 + 2 + 4
```

```
[1] 16
```

```r
# Exemplo de divisao 
(5 + 14)/2
```

```
[1] 9.5
```

```r
# exponenciação
2^3
```

```
[1] 8
```

```r
4^0.5
```

```
[1] 2
```

```r
# operador artimético para se determinar o resto de uma divisao
10 %% 2
```

```
[1] 0
```

```r
2001 %% 2
```

```
[1] 1
```

```r
# operador de divisão inteira
11 %/% 2
```

```
[1] 5
```

Conheça mais operadores aritméticos, digitando na linha de comando:


```r
?"Arithmetic"
```

A janela aberta mostrará outros operadores aritméticos disponíveis com o R. O texto mostrado faz parte do manual de ajuda do R. Para sair dessa tela digite `q`

## Constantes

O R possui algumas constantes pré-definidas, como o a constante pi (π).


```r
pi
```

```
[1] 3.141593
```

O R também trabalha com caracteres, alguns vetores de caracteres pré-definidos são:


```r
LETTERS
```

```
 [1] "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q"
[18] "R" "S" "T" "U" "V" "W" "X" "Y" "Z"
```

```r
letters
```

```
 [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q"
[18] "r" "s" "t" "u" "v" "w" "x" "y" "z"
```

```r
month.abb
```

```
 [1] "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov"
[12] "Dec"
```

```r
month.name
```

```
 [1] "January"   "February"  "March"     "April"     "May"      
 [6] "June"      "July"      "August"    "September" "October"  
[11] "November"  "December" 
```

Note que caracteres estão sempre entre aspas: `""`.



```r
vogais <- abcde
```

```
Error in eval(expr, envir, enclos): object 'abcde' not found
```


```r
vogais <- "abcde"
vogais
```

```
[1] "abcde"
```


## Funções matemáticas internas

Existem diversas funções internas do R que permitem, por exemplo, sortear números aleatóriamente, arrendondar números, calcular o fatorial, calcular o seno, cosseno de um ângulo e etc. Para usar uma função no R apenas digite o nome da função seguido de parênteses:

```r
# funções trigonométricas
sin(pi/6)
```

```
[1] 0.5
```

```r
cos(pi)
```

```
[1] -1
```

```r
# raiz quadrada
sqrt(100)
```

```
[1] 10
```

```r
# exponencial
exp(1)
```

```
[1] 2.718282
```

```r
# fatorial
factorial(4)
```

```
[1] 24
```

No R você verá que parênteses são frequentemente utilizados. Isso ocorre eles estão sempre associados à funções. Qualquer palavra antecedendo um parênteses é uma função.

Para ver a lista completa de funções trigonométricas:

```r
?"Trig"
```

### Sorteando números aleatoriamente

O código abaixo ilustra como sortear número(s) a partir de uma sequência numérica de 1 à 6. A função `set.seed()` especifica uma semente para geração de números aleatórios. Ao definirmos a semente (argumento *seed* da função `set.seed`) os números sorteados serão reproduzidos igualmente na sua máquina.


```r
set.seed(seed = 5)
# sorteio de um número dentro da sequência de 1 a 6
sample(x = 1:6, size = 1)
```

```
[1] 2
```

```r
# sorteio de 5 números dentro da sequência de 1 a 6
sample(x = 1:6, size = 5)
```

```
[1] 5 6 2 1 4
```

```r
# sorteio de 5 números dentro da sequência de 1 a 6
# resultado sem números repetidos
sample(x = 1:6, size = 5, replace = TRUE)
```

```
[1] 4 5 6 1 2
```

```r
# sorteio de 20 números dentro da sequência de 1 a 6
# nesse caso a reposição deve ser feita (size > 6) então podem 
# ocorrer números repetidos
sample(x = 1:6, size = 20, replace = TRUE)
```

```
 [1] 3 2 4 2 2 3 6 4 6 6 5 2 2 1 3 3 6 1 6 3
```

Os argumentos de uma função são obtidos pela função `args()`. Por exemplo quais são os argumentos da função `sample()`?


```r
args(sample)
```

```
function (x, size, replace = FALSE, prob = NULL) 
NULL
```


<span style="color:red; font-size:1.7em;">Fim da 2ª aula ([site do curso](https://rawgit.com/jdtatsch/adar-ufsm/master/3_OperacoesBasicas.html)) </span>

## Valores numéricos especiais

Um caso particular sobre operação aritméticas no R, são os valores numéricos `Inf`e `NaN` que resultam de operações como:


```r
2/0
```

```
[1] Inf
```

```r
-12/0
```

```
[1] -Inf
```

```r
exp(-Inf)
```

```
[1] 0
```

```r
log(0)
```

```
[1] -Inf
```

```r
0/Inf
```

```
[1] 0
```

```r
(0:3)^Inf
```

```
[1]   0   1 Inf Inf
```

```r
log(-0.5)
```

```
Warning in log(-0.5): NaNs produced
```

```
[1] NaN
```

```r
0/0 
```

```
[1] NaN
```

```r
Inf-Inf
```

```
[1] NaN
```

```r
Inf/Inf
```

```
[1] NaN
```

`NaN` é a abreviação para *Not a Number*. Geralmente surge quando um cálculo não tem sentido matemático ou não pode ser propriamente realizado.

A demonstração das diferentes formas de se obter essas constantes especiais é importante para entender a origem delas durante a execução de um script mais extenso.

Outra constante especial do R é o `NA` (*Not Available*) que representa valor faltante, um problema comum em análise de dados. Qualquer operação envolvendo `NA` resultará em `NA`.


```r
NA + 5
```

```
[1] NA
```

```r
NA - Inf
```

```
[1] NA
```

```r
sqrt(NA)
```

```
[1] NA
```

```r
NA^2
```

```
[1] NA
```

```r
NA/NaN
```

```
[1] NA
```


## Notação científica e número de dígitos

Na maioria das vezes precisamos trabalhar com números grandes e consequentemente acabamos usando uma notação científica ou exponencial. No R há diferentes formas de representar números com expoentes:


```r
1.2e-6
```

```
[1] 1.2e-06
```

```r
1.2E6
```

```
[1] 1200000
```

R faz cálculos com alta precisão, mas o padrão é mostrar 7 dígitos significativos, o que pode ser verificado pela `getOptions()`. É possível mudar para `n` dígitos usando a função `options()`, conforme exemplo abaixo.


```r
# opção de dígitos padrão
getOption("digits")
```

```
[1] 7
```

```r
exp(1)
```

```
[1] 2.718282
```

```r
# alterando para 14
options(digits = 14)
exp(1)
```

```
[1] 2.718281828459
```

```r
getOption("digits")
```

```
[1] 14
```

```r
# redefinindo para o valor padrão
options(digits = 7)
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
```

```
[1] 1013
```

```r
# ou use a função print()
print(p)
```

```
[1] 1013
```

O R diferencia letras maiúsculas de minúsculas. Portanto `p` e `P` são variáveis diferentes.


```r
p
```

```
[1] 1013
```

```r
P
```

```
Error in eval(expr, envir, enclos): object 'P' not found
```

Como criamos apenas a variável `p`, `P` não foi encontrada. 

A variável `p` pode ser utilizado para criar outras variáveis.


```r
p_pa <- p * 100
# pressão em Pascal
p_pa
```

```
[1] 101300
```

A seta de atribuição pode ser usada em qualquer sentido. Parênteses, além de estarem sempre acompanhando uma função, também são usados para indicar a prioridade dos cálculos.


```r
7/3 + 0.6 -> y1
 y1
```

```
[1] 2.933333
```

```r
7/(3 + 0.6) -> y2
 y2
```

```
[1] 1.944444
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
```

```
[1] 61
```

A atribuição de um mesmo valor para diferentes variáveis pode ser feita da seguinte forma:


```r
# número de dias em cada mês
jan <- mar <- mai <- jul <- ago <- out <- dez <- 31
abr <- jun <- set <- nov <- 30
fev <- 28
# verificação
jan; jul
```

```
[1] 31
```

```
[1] 31
```

```r
jun; set
```

```
[1] 30
```

```
[1] 30
```

```r
fev
```

```
[1] 28
```

Nós estamos definindo a variável, digitando o nome dela na linha de comando e teclando enter para ver o resultado. Há uma forma mais prática de fazer isso e mostrar o resultado cercando a atribuição por parênteses:


```r
(tar <- 20)
```

```
[1] 20
```

Na expressão note como a variável `tk` definida e já utilizada.


```r
(es <- 0.611 * exp(17.2694 * ((tk <- tar+273.16)-273.16) / ((tk)-35.86)))
```

```
[1] 2.338938
```

```r
tk
```

```
[1] 293.16
```

Essa é mais uma utilidade dos `()` no R. Na expressão acima, conhecida como [fórmula de Teten](http://www.met.wau.nl/metlukweb/Reading/Clausius-Clapeyron.pdf) além de já mostrar o resultado da expressão, nós criamos as variáveis `tk` e `es` simultaneamente.

Quando usamos a mesma variável numa sequência de atribuições o seu valor é sobrescrito. Portanto não é bom usar nomes que já foram usados antes, exceto se a intenção for realmente essa. Para saber os nomes das variáveis já usados use a função `ls()`[^1] para verificar as variáveis existentes:


```r
ls()
```

```
 [1] "abr"    "ago"    "dez"    "es"     "fev"    "jan"    "jul"   
 [8] "jun"    "mai"    "mar"    "nd3"    "nd4"    "nov"    "out"   
[15] "p"      "pcks"   "p_pa"   "set"    "tar"    "tk"     "totd"  
[22] "vogais" "y1"     "y2"    
```

[^1]: Essa lista de variáveis também é mostrada no painel *Environment* do RStudio (canto direito superior, aba *Environment*).



```r
totd <- jan*7; totd <- totd + fev; totd <- totd + 4*abr
totd
```

```
[1] 365
```

Quando fazemos a atribuição para diversas variáveis elas podem ser agrupadas com colchetes.


```r
{
  tmax <- 32
  tmin <- 23
  amp <- tmax - tmin
  tmed <- (tmax + tmin)/2
}
```

### Atribuição com a função `assign()`

Outra forma de atribuição é através da função `assign()`:


```r
es
```

```
[1] 2.338938
```

```r
assign(x = "es_hpa", value = es/10)
es_hpa
```

```
[1] 0.2338938
```

```r
# usando função assign sem nome dos parâmetros
assign("u", 2.5)
u
```

```
[1] 2.5
```

Para ilustrar um caso em que a função `assign` pode ser útil, vamos supor que você tenha um vetor com os nomes que você deseja usar para definir alguns objetos, cujo resultado já está em um vetor previamente criado. 

Considere os nomes dos meses do ano (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec) para serem usados como nomes para os novos objetos. E os valores a serem atribuídos estão armazenados no objeto `nums`, que poderia ser um vetor com resultados de uma análise para cada mês. Mas para fins de ilustração, no código abaixo, os valores do objeto `nums` são simplesmente uma sequência de 1 a 12. Ao invés de repetirmos 12 vezes a atribuição `jan <- 1; fev <- 2, mar <- 3, ...`, podemos fazer um laço (ou *looping*) de 1 até o tamanho do vetor `nums` (ou seja 1:12) e usar o vetor `month.abb` para nomear os objetos.


```r
# vetor de 1 a 12
nums <- 1:12
for (i in nums) assign(month.abb[i], i)
# verificando os valores dos objetos criados
Jan
```

```
[1] 1
```

```r
Feb
```

```
[1] 2
```

```r
Mar
```

```
[1] 3
```

```r
Apr
```

```
[1] 4
```

```r
ls()
```

```
 [1] "abr"    "ago"    "Apr"    "Aug"    "Dec"    "dez"    "es"    
 [8] "es_hpa" "Feb"    "fev"    "i"      "jan"    "Jan"    "jul"   
[15] "Jul"    "jun"    "Jun"    "mai"    "mar"    "Mar"    "May"   
[22] "nd3"    "nd4"    "nov"    "Nov"    "nums"   "Oct"    "out"   
[29] "p"      "pcks"   "p_pa"   "Sep"    "set"    "tar"    "tk"    
[36] "totd"   "u"      "vogais" "y1"     "y2"    
```

A função `for()` será explorada futuramente.

## Removendo variáveis

Para remover variáveis usa-se a função `rm()`.


```r
# lista de variáveis existentes
ls()
```

```
 [1] "abr"    "ago"    "Apr"    "Aug"    "Dec"    "dez"    "es"    
 [8] "es_hpa" "Feb"    "fev"    "i"      "jan"    "Jan"    "jul"   
[15] "Jul"    "jun"    "Jun"    "mai"    "mar"    "Mar"    "May"   
[22] "nd3"    "nd4"    "nov"    "Nov"    "nums"   "Oct"    "out"   
[29] "p"      "pcks"   "p_pa"   "Sep"    "set"    "tar"    "tk"    
[36] "totd"   "u"      "vogais" "y1"     "y2"    
```

```r
rm(u)
# lista de variáveis existentes, sem u
ls()
```

```
 [1] "abr"    "ago"    "Apr"    "Aug"    "Dec"    "dez"    "es"    
 [8] "es_hpa" "Feb"    "fev"    "i"      "jan"    "Jan"    "jul"   
[15] "Jul"    "jun"    "Jun"    "mai"    "mar"    "Mar"    "May"   
[22] "nd3"    "nd4"    "nov"    "Nov"    "nums"   "Oct"    "out"   
[29] "p"      "pcks"   "p_pa"   "Sep"    "set"    "tar"    "tk"    
[36] "totd"   "vogais" "y1"     "y2"    
```

```r
rm(es_hpa, es, tar, y1, y2)
# lista de variáveis existentes, sem es_hpa, es, tar, y1, y2
ls()
```

```
 [1] "abr"    "ago"    "Apr"    "Aug"    "Dec"    "dez"    "Feb"   
 [8] "fev"    "i"      "jan"    "Jan"    "jul"    "Jul"    "jun"   
[15] "Jun"    "mai"    "mar"    "Mar"    "May"    "nd3"    "nd4"   
[22] "nov"    "Nov"    "nums"   "Oct"    "out"    "p"      "pcks"  
[29] "p_pa"   "Sep"    "set"    "tk"     "totd"   "vogais"
```

Para remover todas variáveis do espaço de trabalho (use com cautela):


```r
# apagando tudo
rm(list = ls())
ls()
```

```
character(0)
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
```

```
Error in dia - 1 <- 2: object 'dia' not found
```

```r
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
```

```
[1] "DJF"
```
   
Uma boa prática de programação é usar nomes informativos para as variáveis para legibilidade do código. Uma boa referência para isso é a seção [**Style guide**](http://adv-r.had.co.nz/Style.html) do livro [**R Advanced**](http://adv-r.had.co.nz/).

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

Geração de números aleatórios

- `set.seed()`
- `sample()`

Argumentos de uma função
- `args()`

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

