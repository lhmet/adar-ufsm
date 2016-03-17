# Tipos de dados
Jônatan Tatsch  
`r format(Sys.Date(), format = '%d-%m-%Y')`  



- - -

![](figs/adar.png)

- - -

# Objetivos

Nesta seção vamos:

- conhecer os tipos de dados mais usados no R
- como descobrir qual tipo de dado de uma variável
- aprender a fazer testes com operadores lógicos
- saber como converter uma variável de um tipo para outro

# Tipos de dados

Existem vários classes de dados no R. As mais utilizadas são:

* `numeric`

* `character` (sequência de caracteres)

* `logical` (TRUE/FALSE)

* `Date` (datas)

* `POSIXct` (datas e horários) 

A classe dos dados de um objeto é verificada com a função `class()`.


```r
x <- 51
class(x)
```

```
[1] "numeric"
```
 
## numeric

É a classe de objeto mais usada. Essa classe é similar a *float* ou *double* em outras linguagens. Ele lida com inteiros e decimais, positivos e negativos e zero. Um valor numérico armazenado em um objeto é automaticamente assumido ser numérico. Para testar se um objeto é numérico usa-se a função `is.numeric()`.


```r
is.numeric(x)
```

```
[1] TRUE
```

```r
is.numeric(pi)
```

```
[1] TRUE
```

Outro tipo é o `integer` (inteiro), ou seja não há parte decimal. Para definir um objeto como inteiro é necessário acrescentar ao valor numérico um `L`. Analogamente, uma forma de verificação se o objeto é inteiro é através função `is.integer()`.



```r
i <- 3L
is.integer(i)
```

```
[1] TRUE
```

```r
is.integer(pi)
```

```
[1] FALSE
```
 
Mesmo com o objeto `i` sendo inteiro, ele também passa na verificação `is.numeric()`.


```r
is.numeric(i)
```

```
[1] TRUE
```

O R converte inteiros para numéricos quando necessário. Vamos usar a função `typeof()` para determinar o tipo de dado e as conversões que o R faz. Por exemplo:


```r
## integer * numeric
typeof(5L)
```

```
[1] "integer"
```

```r
typeof(4.5)
```

```
[1] "double"
```

```r
(prod_i <- 5L * 4.5)
```

```
[1] 22.5
```

```r
typeof(prod_i)
```

```
[1] "double"
```

```r
## integer/integer
typeof(5L)
```

```
[1] "integer"
```

```r
typeof(2L)
```

```
[1] "integer"
```

```r
typeof(5L/2L)
```

```
[1] "double"
```


## character

O tipo de dado *character* (*string*) é bastante utilizado e deve ser manipulado com cuidado. No R há duas principais formas de lidar com caracteres: a função `character()` e `factor()`. Embora pareçam similares eles são tratados de forma diferente.


```r
(char <- "Vai chover hoje?")
```

```
[1] "Vai chover hoje?"
```

```r
charf <- factor("Vai chover hoje?")
charf
```

```
[1] Vai chover hoje?
Levels: Vai chover hoje?
```

```r
levels(charf)
```

```
[1] "Vai chover hoje?"
```

```r
ordered(charf)
```

```
[1] Vai chover hoje?
Levels: Vai chover hoje?
```

`char` contém as palavras  \"Vai chover hoje?\", enquanto, `charf` tem as mesmas palavras porém sem as aspas e a segunda linha de informação sobre os níveis (*levels*) de `charf`. Nós veremos esse tipos de dado futuramente em vetores.


> **Lembre-se que caracteres em letras minúsculas e maiúsculas são coisas diferentes no R.**

Para encontrar o tamanho de um `character` usamos a função `nchar()`.
        

```r
nchar(char)
```

```
[1] 16
```

```r
nchar("abc")
```

```
[1] 3
```

Esta função não funcionará para um objeto do tipo `factor`.


```r
nchar(charf)
```

```
Error in nchar(charf): 'nchar()' requires a character vector
```

## logical
   
`logical` (lógico) é uma forma de representar dados que podem assumir valores booleanos, isto é, **TRUE** (verdadeiro) ou **FALSE** (falso). Numericamente, TRUE é o mesmo que 1 e FALSE é o mesmo que 0.


```r
# variável lógica
vl <- FALSE
```

Então: 


```r
vl * 5
```

```
[1] 0
```

```r
TRUE * 5
```

```
[1] 5
```

```r
TRUE + TRUE
```

```
[1] 2
```

```r
FALSE - TRUE
```

```
[1] -1
```

Assim como as outras classes de dados existe um teste associado.


```r
class(vl)
```

```
[1] "logical"
```

```r
is.logical(vl)
```

```
[1] TRUE
```

O R aceita as abreviaturas T e F para representar TRUE e FALSE, respectivamente, mas não é recomendado usá-las, conforme exemplo abaixo.


```r
TRUE
```

```
[1] TRUE
```

```r
T
```

```
[1] TRUE
```

```r
class(T)
```

```
[1] "logical"
```

```r
T <- 10
class(T)
```

```
[1] "numeric"
```

Valores lógicos resultam da comparação de números ou caracteres.


```r
4 == 3 # 4 é idêntico a 3?
```

```
[1] FALSE
```

```r
teste2i2 <- 2*2 == 2+2
teste2i2
```

```
[1] TRUE
```

```r
teste2d2 <- 2*2 != 2+2 # operador: diferente de
teste2d2
```

```
[1] FALSE
```

```r
4 < 3
```

```
[1] FALSE
```

```r
4 > 3
```

```
[1] TRUE
```

```r
4 >= 3 & 4 <= 5
```

```
[1] TRUE
```

```r
4 <= 3 | 4 <= 5
```

```
[1] TRUE
```

```r
"abc" == "defg"
```

```
[1] FALSE
```

```r
"abc" < "defg"
```

```
[1] TRUE
```

```r
nchar("abc") < nchar("defg")
```

```
[1] TRUE
```


----------------------------------
 Operador         Descrição       
---------- -----------------------
    <             menor que       

    <=        menor ou igual a    

    >             maior que       

    >=         maior ou igual     

    ==            idêntico        

    !=            diferente       

    !x        não é x (negação)   

  x | y            x ou y         

  x & y             x e y         

isTRUE(x)  teste se x é verdadeiro

   %in%        está contido em    
----------------------------------

Table: Tabela 1. Operadores Lógicos



## Date

Lidar com datas e horários pode ser difícil em qualquer linguagem e pode complicar mais ainda quando há diversas opções de classes de datas disponíveis, como no R.

As mais úteis são:
  
  * `Date`
  
  * `POSIXct`
  

`Date` armazena apenas a data enquanto `POSIXct` armazena a data e o horário. Ambos dados são representados como o número de dias (Date) ou segundos (POSIXct) decorridos  desde 1 de Janeiro de 1970.

```r
data1 <- as.Date("2012-06-28")
data1
```

```
[1] "2012-06-28"
```

```r
class(data1)
```

```
[1] "Date"
```

```r
as.numeric(data1)
```

```
[1] 15519
```

```r
data2 <- as.POSIXct("2012-06-28 17:42")
data2
```

```
[1] "2012-06-28 17:42:00 GMT"
```

```r
class(data2)
```

```
[1] "POSIXct" "POSIXt" 
```

```r
as.numeric(data2)
```

```
[1] 1340905320
```

A manipulação de dados da classe de datas e horários (`Date-time`) torna-se mais versátil através dos pacotes `lubridate` e `chron`, o que será visto posteriromente no curso.

Funções como `as.numeric()` e `as.Date()` não apenas mudam o formato de um objeto mas muda realmente a classe original do objeto.


```r
class(data1)
```

```
[1] "Date"
```

```r
class(as.numeric(data1))
```

```
[1] "numeric"
```

## Testes sobre tipos de dados

Além função `typeof()`, a família `is.*()` também permite descobrir o tipo de dado, p.ex.: `is.numeric()`, `is.character()` e etc.


```r
x; typeof(x)
```

```
[1] 51
```

```
[1] "double"
```

```r
vl; typeof(vl)
```

```
[1] FALSE
```

```
[1] "logical"
```

```r
data1; typeof(data1)
```

```
[1] "2012-06-28"
```

```
[1] "double"
```

```r
x; is.numeric(x)
```

```
[1] 51
```

```
[1] TRUE
```

```r
# checar se um nº é real
is.double(x/5)
```

```
[1] TRUE
```

```r
is.double(5L)
```

```
[1] FALSE
```

```r
is.character("12.34")
```

```
[1] TRUE
```

```r
charf; is.factor(charf)
```

```
[1] Vai chover hoje?
Levels: Vai chover hoje?
```

```
[1] TRUE
```

```r
i; is.integer(i)
```

```
[1] 3
```

```
[1] TRUE
```

```r
is.function(sqrt)
```

```
[1] TRUE
```

```r
is.finite(i)
```

```
[1] TRUE
```

```r
is.nan(x)
```

```
[1] FALSE
```

```r
is.na(x)
```

```
[1] FALSE
```

## Conversão entre tipos de dados

Em algumas circustâncias precisamos alterar o tipo de uma variável. A maioria das funções `is.*()` possui uma função `as.*()` correspondente de conversão para aquele tipo de dado.


```r
# de character para numeric
as.numeric("12.34") 
```

```
[1] 12.34
```

```r
# ou
as("12.34", "numeric")
```

```
[1] 12.34
```

```r
# de factor para character
as.character(charf)
```

```
[1] "Vai chover hoje?"
```

```r
# character para factor
as.factor("a")
```

```
[1] a
Levels: a
```

```r
# de double para integer
typeof(x)
```

```
[1] "double"
```

```r
typeof(as.integer(x))
```

```
[1] "integer"
```

```r
as.integer(x) == 51L
```

```
[1] TRUE
```

```r
as.integer("12.34")
```

```
[1] 12
```

```r
# arredondamento
as.integer(12.34)
```

```
[1] 12
```

```r
# lógico para inteiro
as.integer(TRUE)
```

```
[1] 1
```

```r
# numérico para lógico
as.logical(0:2)
```

```
[1] FALSE  TRUE  TRUE
```

```r
# character para numérico?
as.numeric("a")
```

```
Warning: NAs introduced by coercion
```

```
[1] NA
```

```r
# de character para data
dt_char <- "2016-03-17"
d <- as.Date(dt_char)
d
```

```
[1] "2016-03-17"
```


# Funções e operadores novos utilizados

Tipos de dados

- `class()`
- `factor()`; `levels()`; `ordered()`
- `nchar()`
- `==`; `!=`; `<`; `>`; `>=`; `<=`; `|`;`&`

Datas e horas

- `as.Date()`
- `as.POSIXct()`
- `as.numeric()`

Teste dos tipos de dados

- `typeof()`
- `is.numeric()`; `is.character()`; `is.logical()`; `is.integer()`; `is.factor()`; `is.function()`
- `is.finite()`; `is.nan()`; `is.na()`

Conversão de dados

- `as()`; `as.numeric()`; `as.character()`; `as.integer()`; `as.factor()`










