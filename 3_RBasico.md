# Básico de R
Jônatan Tatsch  
19-03-2015  



- - -

![](figs/adar.png)

- - -

# CalculadoRa

## Aritmética básica

Todas operações que realizamos com uma calculadora podem ser feitas diretamente na linha de comando do R.


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
11 %% 2
```

```
[1] 1
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

## Constantes

O R tem 4 constantes pré-definidas:

```r
pi
```

```
[1] 3.141593
```

```r
# vetores predefinidos no R
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

O código abaixo ilustra como sortear número(s) a partir de uma sequência numérica de 1 à 10. A função `set.seed()` especifica uma semente para geração de números aleatórios. Ao definirmos a semente (argumento *seed* da função `set.seed`) os números sorteados serão reproduzidos igualmente na sua máquina.


```r
set.seed(seed = 5)
# sorteio de um número dentro da sequência de 1 a 10
sample(x = 1:6, size = 1)
```

```
[1] 2
```

```r
# sorteio de 5 números dentro da sequência de 1 a 10
sample(x = 1:6, size = 5)
```

```
[1] 5 6 2 1 4
```

```r
# sorteio de 10 números dentro da sequência de 1 a 10
# resultado sem números repetidos
sample(x = 1:6, size = 5, replace = TRUE)
```

```
[1] 4 5 6 1 2
```

```r
# resultado com números repetidos
sample(x = 1:10, size = 10, replace = TRUE)
```

```
 [1] 5 4 6 3 3 4 9 6 9 9
```

```r
# sorteio de 20 números dentro da sequência de 1 a 10
# nesse caso a reposição deve ser feita (size > n) então podem 
# ocorrer números repetidos
sample(x = 1:10, size = 20, replace = TRUE)
```

```
 [1]  8  3  3  2  5  5 10  2 10  5  1  3  1  1  5  6  6  4  4  9
```

Os argumentos de uma função são obtidos pela função `args()`. Por exemplo quais são os argumentos da função `sample()`?


```r
args(sample)
```

```
function (x, size, replace = FALSE, prob = NULL) 
NULL
```


<span style="color:red; font-size:1.7em;">Fim da 2a aula [GitHub](https://github.com/jdtatsch/adar-ufsm) </span>

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

# Objetos

## Formas de atribuição 

### Objeto recebe valor

Até agora nós usamos expressões para fazer uma operação e obter um resultado. O resultado não foi armazenado para que pudéssemos reutilizá-lo posteriormente. Podemos armazenar dados em um objeto dentro do R. O que é um objeto? É um nome usado para guardar os dados, ou seja a nossa variável. Por exemplo para atribuir o valor 2 ao objeto chamado "a". Usamos a combinação dos símbolos menor (`<`) e menos (`-`) `<-`. Esse é o símbolo de atribuição a um objeto.

```r
# a recebe 2
a <- 2
a
```

```
[1] 2
```

O R diferencia letras maiúsculas de minúsculas. Portanto `a` e `A` são objetos diferentes.

```r
a
```

```
[1] 2
```

```r
A
```

```
Error in eval(expr, envir, enclos): object 'A' not found
```

Como criamos apenas o objeto **a**, o objeto A não foi encontrado. 

O objeto **a** pode ser utilizado para criar outros objetos.


```r
x <- 10*a
x
```

```
[1] 20
```

A seta de atribuição pode ser usada em qualquer sentido. Parênteses são também utilizados para indicar a prioridade dos cálculos.


```r
 (7/3) + 0.6 -> y1
 y1
```

```
[1] 2.933333
```

```r
7/3 + 0.6 -> y2
 y2
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

Vamos criar um objeto chamado `ndias3` que recebe o nº de dias no mês de Março e `ndias4` que recebe o nº de dias no mês de Abril.


```r
nd3 <- 31
nd4 <- 30
```

O total de dias nos meses de março e abril serão armazenados no objeto totdias:

```r
totd <- nd3 + nd4
totd
```

```
[1] 61
```

A atribuição de um mesmo valor para diferentes objetos pode ser feita da seguinte forma:


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

Nós estamos definindo o objeto, digitando o nome do objeto na linha de comando e teclando enter para ver o resultado. Há uma forma mais prática de definir um objeto e ao mesmo tempo já  mostrar o seu resultado. Isso pode ser feito cercando a atribuição por parênteses:


```r
(tar <- -10:10)
```

```
 [1] -10  -9  -8  -7  -6  -5  -4  -3  -2  -1   0   1   2   3   4   5   6
[18]   7   8   9  10
```

```r
0.5*(x <- 4)^2 + 2*x + 5
```

```
[1] 21
```

Quando usamos o próprio objeto numa sequência de atribuições o seu valor é sobrescrito. Portanto não é bom usar nomes que já foram usados antes. Para saber nomes dos objetos já usados use a função `ls()`:


```r
ls()
```

```
 [1] "a"    "abr"  "ago"  "dez"  "jan"  "jul"  "jun"  "mar"  "may"  "nd3" 
[11] "nd4"  "nov"  "out"  "pcks" "set"  "tar"  "totd" "x"    "y1"   "y2"  
[21] "y3"  
```

Os objetos criados também estão disponíveis no painel **Environment** do RStudio.

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
y1
```

```
[1] 2.933333
```

```r
assign(x = "x", value = 10*y1)
x
```

```
[1] 29.33333
```

Para ilustrar um caso em que a função `assign` pode ser útil, vamos supor que você tenha um vetor com os nomes que você deseja usar para definir alguns objetos, cujo resultado já está em um vetor previamente criado. 

Considere os nomes dos meses do ano (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec) para serem usados como nomes para os novos objetos. E os valores a serem atribuídos estão armazenados no objeto `nums`, que poderia ser um vetor com resultados de uma análise para cada mês. Mas para fins de ilustração, no código abaixo, os valores do objeto `nums` são simplesmente uma sequência de 1 a 12. Ao invés de repetirmos 12 vezes a atribuição `Jan <- 1; Feb <- 2, Mar <- 3, ...`, podemos fazer um laço (ou *looping*) de 1 até o tamanho do vetor `nums` (ou seja 1:12) e usar o vetor `month.abb` para nomear os objetos.


```r
# vetor de 1 a 12
nums <- 1:12
# laço em cada elemento de nums
for (i in 1 : length(nums)) assign(month.abb[i], i)
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

Não se preocupe se você não entendeu completamente a expressão acima, pois as funções `assign` e `for`(para fazer laços) serão exploradas futuramente.

## Nomeando objetos

É preciso ter cuidado ao nomear objetos no R porque existem algumas regras:

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
   

