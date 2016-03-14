# Operações Básicas
Jônatan Tatsch  
19-03-2015  



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
(0:3)^Inf;
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
 
## Notação científica e precisão

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

R faz cálculos com alta precisão, mas o padrão é mostrar 7 dígitos significativos, o que pode ser verificado pela `getOptions()`. É possível mudar para `n` digítos usando a função `options()`, conforme exemplo abaixo.


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

Até agora nós usamos expressões para fazer uma operação e obter um resultado. O resultado não foi armazenado para que pudéssemos reutilizá-lo posteriormente. Podemos armazenar dados em um objeto dentro do R. O que é um objeto? É um nome usado para guardar os dados, ou seja a nossa variável. Por exemplo para atribuir o valor 2 ao objeto chamado "a" usamos a combinação dos símbolos menor (`<`) e menos (`-`) `<-` entre os dois números. Esse é o símbolo de atribuição a um objeto.


```r
p <- 1013
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
7/(3 + 0.6) -> y3
 y3
```

```
[1] 1.944444
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
jan <- mar <- may <- jul <- ago <- out <- dez <- 31
abr <- jun <- set <- nov <- 30
# verificação
jan; mar; jul
```

```
[1] 31
```

```
[1] 31
```

```
[1] 31
```

```r
abr; jun; set
```

```
[1] 30
```

```
[1] 30
```

```
[1] 30
```

Nós estamos definindo a variável, digitando o nome dela na linha de comando e teclando enter para ver o resultado. Há uma forma mais prática de fazer isso e mostrar o resultado cercando a atribuição por parênteses:


```r
(tar <- 20)
```

```
[1] 20
```

```r
# Equação de Tetens
(es <- 0.611 * exp(17.2694 * ((tar+273.16)-273.16) / ((tar+273.16)-35.86)))
```

```
[1] 2.338938
```

Quando usamos a própria variável numa sequência de atribuições o seu valor é sobrescrito. Portanto não é bom usar nomes que já foram usados antes. Para saber nomes das variáveis já usados use a função `ls()` para verificar as variáveis existentes:


```r
ls()
```

```
 [1] "abr"    "ago"    "dez"    "es"     "jan"    "jul"    "jun"   
 [8] "mar"    "may"    "nd3"    "nd4"    "nov"    "out"    "p"     
[15] "pcks"   "p_pa"   "set"    "tar"    "totd"   "vogais" "y1"    
[22] "y3"    
```

As variáveis criadas também estão disponíveis no painel *Environment* do RStudio.


```r
totdias <- nd3; totd <- totd + nd4; totd <- totd + 365
totd
```

```
[1] 456
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

### Atribuição com a função `assign`

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

Para ilustrar um caso em que a função `assign` pode ser útil, vamos supor que você tenha um vetor com os nomes que você deseja usar para definir alguns objetos, cujo resultado já está em um vetor previamente criado. 

Considere os nomes dos meses do ano (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec) para serem usados como nomes para os novos objetos. E os valores a serem atribuídos estão armazenados no objeto `nums`, que poderia ser um vetor com resultados de uma análise para cada mês. Mas para fins de ilustração, no código abaixo, os valores do objeto `nums` são simplesmente uma sequência de 1 a 12. Ao invés de repetirmos 12 vezes a atribuição `Jan <- 1; Feb <- 2, Mar <- 3, ...`, podemos fazer um laço (ou *looping*) de 1 até o tamanho do vetor `nums` (ou seja 1:12) e usar o vetor `month.abb` para nomear os objetos.


```r
# vetor de 1 a 12
nums <- 1:12
# laço em cada elemento de nums
intervalo <- 1 : length(nums)
for (i in intervalo) assign(month.abb[i], i)
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

A função `for()` será explorada futuramente.

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
   

