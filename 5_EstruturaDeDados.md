# Estruturas de dados
Jônatan Tatsch  
`r format(Sys.Date(), format = '%d-%m-%Y')`  



- - -

![](figs/adar.png)

- - -

# Objetivos

Nesta seção vamos:

- ver como os dados podem ser estruturados no R 
- conhecer os atributos dessas estruturas
- criar e manipular essas estruturas

#  Estruturas de dados

Existem diferentes formas de armazenar dados no R. Algumas vezes os dados precisam ser armazenados de forma mais complexa do que por exemplo vetores. 

O R possui uma variedade de estruturas (**Figura 1**). As mais utilizadas são:

- *data frame* (tabela de dados)

- *matrix* (matriz)

- *list* (lista)

- *array* e *vector* (vetor)

![Figura 1. Estruturas de dados no R](figs/dataStructuresR.png)

# Vetor

Um vetor é uma coleção de elementos. Os vetores são amplamente usados e compõem a estrutura básica de dados do R, por ser uma linguagem vetorizada. 

Os vetores podem ser de dois tipos: **vetores atômicos** e **listas**. 

## Vetores atômicos 

Os **vetores atômicos** são constituem a estrutura de dadosmais simples do R (como se fossem os átomos do R). Um vetor atômico é uma coleção de elementos, em que todos são do mesmo tipo de dado (todos `double`, ou `integer`, ou `logical`, etc). 

Como linguagem vetorizada, as operações são aplicadas a cada elemento do vetor automaticamente, sem a necessidade de laços (ou *loopings*) ao longo do vetor. Esse conceito pode ser estranho para quem vem de outras linguagens, mas é uma das grandes vantagens do R.

Vetores não tem dimensões, ou seja não existem é um vetor linha ou vetor coluna. 

### Propriedades

+ `typeof()` (tipo de dado?)

+ `length()` (tamanho?) e 

+ `attributes` (informações adionais específicas do dado), entre eles o atributo mais comum está o `names()`.

### Criação

**Vetores atômicos** são geralmente criados com `c()`, abreviatura para o verbo **combinar ou concatenar**.


```r
# vetor numérico
vetor_num <- c(5, 2.5, 4.5)
# Note o sufixo L que distingue variaveis "double" de "integers"
vetor_int <- c(1L, 6L, 10L)
# Vetor logico
vetor_log <- c(T, FALSE, TRUE, FALSE)
# Vetor de caracteres
vetor_char <- c("Analise de dados", "ambientais com o R")
```

Vetores atômicos podem ser criados a partir de outros vetores aninhados entre si pela função `c()`.


```r
v1 <- 1           # vetor com 1 elemento
v2 <- c(2)        # vetor com 1 elemento
v3 <- c(4, 6)     # vetor com 2 elemento
```

Formas diferentes para criação de vetor que resultam num mesmo vetor:


```r
(v_123 <- c(v1, v2, v3))
```

```
[1] 1 2 4 6
```

```r
(v_123a <- c(1, c(v2, v3)))
```

```
[1] 1 2 4 6
```

```r
(v_123b <- c(vetor_num, c(v1, v2), v3))
```

```
[1] 5.0 2.5 4.5 1.0 2.0 4.0 6.0
```

```r
v <- c(1, 2, 4, 6)
v
```

```
[1] 1 2 4 6
```

### Coerção de vetores


```r
c("a", 1)
```

```
[1] "a" "1"
```

```r
as.numeric(c(F, F, T))
```

```
[1] 0 0 1
```

Você pode manualmente forçar um tipo de vetor para outro usando funções de coerção: `as.character()`, `as.double()`,`as.integer()`, `as.logical()`. Coerção frequentemente acontece automaticamente, mas geralmente será mostrada uma mensagem quando ocorrer.

Vamos usar a coerção no seguinte caso. Imagine um vetor com valores de chuva mensal de um ano e outro vetor com os meses do ano. Note a diferença da forma como criamos o vetor `meses` e o vetor `months`. Como descobrir o número de meses sem chuva nesse ano?

```r
# vetor com nomes criados com 1 comando
meses <- c(jan = 1, fev = 2, mar = 3 , abr = 4, mai = 5, jun = 6,
           jul = 7, ago = 8, set = 9, out = 10, nov = 11, dez = 12)
meses
```

```
jan fev mar abr mai jun jul ago set out nov dez 
  1   2   3   4   5   6   7   8   9  10  11  12 
```

```r
## vetor definido e depois adiciona-se o nome das variáveis
months <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
names(months) <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
months
```

```
Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec 
  1   2   3   4   5   6   7   8   9  10  11  12 
```

```r
# o atibuto mais comum de um vetor
attributes(meses)
```

```
$names
 [1] "jan" "fev" "mar" "abr" "mai" "jun" "jul" "ago" "set" "out" "nov"
[12] "dez"
```

```r
length(meses)
```

```
[1] 12
```

```r
# Vetor com dados de prec
chuva <- c(100, 0, 20, 140, 110, 50, 90, 0, 0 , 10, 0, 6)
length(chuva)
```

```
[1] 12
```

```r
# quando nao choveu?
seco <- chuva == 0
seco
```

```
 [1] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE FALSE  TRUE
[12] FALSE
```

```r
# coerção de lógico para numérico
seco01 <- as.numeric(seco)
#seco01 <- as.integer(seco)
seco01
```

```
 [1] 0 1 0 0 0 0 0 1 1 0 1 0
```

```r
# total de meses secos no ano
sum(seco01)
```

```
[1] 4
```

```r
# também funciona com vetores lógicos
sum(seco)
```

```
[1] 4
```

### Nomeando vetores

Nós podemos nomear um vetor de 3 formas:

+ Durante a criação

+ Modificando um vetor

+ Criando um vetor modificado

Nomes devem ser únicos (sem repetições), porque para filtragem de elementos de um vetor ou a seleção de um subconjunto (razão pela qual usam-se os `names`) retornará somente o primeiro elemento que tiver nome repetido.

```r
# Durante a criação:
x <- c(a = 1, b = 2, c = 3)
x
```

```
a b c 
1 2 3 
```

```r
# Modificando um vetor: 
x <- 1:3; names(x) <- c("a", "b", "c")
x
```

```
a b c 
1 2 3 
```

```r
# Criando um vetor modificado
x <- setNames(1:3, c("a", "b", "c"))
x
```

```
a b c 
1 2 3 
```

Nem todos elementos precisam ter nomes. Se os nomes são faltantes, `names()` retornará um string vazia ("") para aqueles elementos. Se todos forem faltantes, `names()` retornará `NULL`.

```r
y <- c(a = 1, 2, 3)
names(y)
```

```
[1] "a" ""  "" 
```

```r
z <- c(1, 2, 3)
names(z)
```

```
NULL
```

Podemos criar um vetor sem nomes usando a função `unname(x)`, ou remover `names` com `names(x) <- NULL`.


```r
a <- c(dia1 = 12, dia2 = 20, dia3 = 10)
a
```

```
dia1 dia2 dia3 
  12   20   10 
```

```r
names(a)
```

```
[1] "dia1" "dia2" "dia3"
```

```r
a_novo <- unname(a)
a_novo
```

```
[1] 12 20 10
```

```r
names(a_novo)
```

```
NULL
```

- - -

## Operações com vetores

Para multiplicar cada elemento de um vetor por um valor é usar o operador de multiplicação  (*). O mesmo procedimento se aplica as demais operações de soma, subtração, divisão, exponenciação e etc.

```r
x <- 1:10
x * 3
```

```
 [1]  3  6  9 12 15 18 21 24 27 30
```

```r
x + 2
```

```
 [1]  3  4  5  6  7  8  9 10 11 12
```

```r
x - 3
```

```
 [1] -2 -1  0  1  2  3  4  5  6  7
```

```r
x/4
```

```
 [1] 0.25 0.50 0.75 1.00 1.25 1.50 1.75 2.00 2.25 2.50
```

```r
x^2
```

```
 [1]   1   4   9  16  25  36  49  64  81 100
```

```r
sqrt(x)
```

```
 [1] 1.000000 1.414214 1.732051 2.000000 2.236068 2.449490 2.645751
 [8] 2.828427 3.000000 3.162278
```

Operações vetoriais podem ser extendidas para dois vetores por exemplo.

```r
# criando 2 vetores de mesmo tamanho
x <- 1:10
y <- -5:4
# somando-os
x + y
```

```
 [1] -4 -2  0  2  4  6  8 10 12 14
```

```r
x - y
```

```
 [1] 6 6 6 6 6 6 6 6 6 6
```

```r
x * y
```

```
 [1] -5 -8 -9 -8 -5  0  7 16 27 40
```

```r
x/y
```

```
 [1] -0.2 -0.5 -1.0 -2.0 -5.0  Inf  7.0  4.0  3.0  2.5
```

```r
x^y
```

```
 [1] 1.000000e+00 6.250000e-02 3.703704e-02 6.250000e-02 2.000000e-01
 [6] 1.000000e+00 7.000000e+00 6.400000e+01 7.290000e+02 1.000000e+04
```

```r
x %% y
```

```
 [1] -4 -2  0  0  0 NA  0  0  0  2
```

```r
length(x)
```

```
[1] 10
```

```r
length(y)
```

```
[1] 10
```

```r
length(x + y)
```

```
[1] 10
```

Note como as coisas funcionam para vetores de tamanhos diferentes. O vetor menor é reciclado, ou seja seus elementos são repetidos em ordem até eles atingirem o tamanho do mais longo.  Se o vetor mais longo não é múltiplo do mais curto um aviso é dados.


```r
v1 <- c(3, 5, 88, 90)
v2 <- c(2, 1)
v1 + v2
```

```
[1]  5  6 90 91
```

Se os tamanhos dos vetores não são múltiplos um do outro, o R imprime um aviso.


```r
v1 <- c(3, 5, 88, 90)
v2 <- c(2, 1, 3)
v1 + v2
```

```
Warning in v1 + v2: longer object length is not a multiple of shorter
object length
```

```
[1]  5  6 91 92
```

A reciclagem é intrinsicamente aplicada a operação envolvendo vetores.


```r
v1 <- c(3, 5, 88, 90)
cte <- 4
v1 * cte
```

```
[1]  12  20 352 360
```

O número 4 nesse caso é reciclado 4 vezes e então multiplicado por cada elemento do vetor `v1`.
Avisos e erros:


```r
v1 <- c(3, 5, 88, 90)
srt(v1)
```

```
Error in eval(expr, envir, enclos): could not find function "srt"
```

```r
sqrt(-v1)
```

```
Warning in sqrt(-v1): NaNs produced
```

```
[1] NaN NaN NaN NaN
```

Comparações também funcionam com vetores.


```r
x <= 5
```

```
 [1]  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE
```

```r
x > y
```

```
 [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
```

```r
x < y
```

```
 [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
```

A função `nchar()` também funciona sobre cada elemento do vetor. Esse é mais um exemplo de função vetorizada do R.


```r
nchar(month.name)
```

```
 [1] 7 8 5 5 3 4 4 6 9 7 8 8
```

```r
nchar(y)
```

```
 [1] 2 2 2 2 2 1 1 1 1 1
```

### Operadores `any` e `all`


```r
vetor <- c(0, 1, -1, -2, 3, 5, -5)
all(vetor < 0)  # todas as posições são maiores que 0 ?
```

```
[1] FALSE
```

```r
any(vetor > 0)  # alguma posição é maior que 0?
```

```
[1] TRUE
```

- - -

## Sequências

Vimos nas seções anteriores que é muito simples criar sequências de números inteiros com o operador `:`.  Nesta seção veremos outras formas de gerar sequências, como uma sequência de números não inteiros e sequências de números repetidos. 

### Sequências de números inteiros

Sequências de números formam um vetor. Há diversas formas de se gerar sequências no R. Para gerar uma sequência de 1 até 365, em vez de escrevermos cada número e combiná-los usando `c(1,2,3,...,365)`, podemos usar o operador `:` da seguinte forma:
 

```r
# dias do ano
dda <- 1:365
dda
```

```
  [1]   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17
 [18]  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34
 [35]  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51
 [52]  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68
 [69]  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85
 [86]  86  87  88  89  90  91  92  93  94  95  96  97  98  99 100 101 102
[103] 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119
[120] 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136
[137] 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153
[154] 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170
[171] 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187
[188] 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204
[205] 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221
[222] 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238
[239] 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255
[256] 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272
[273] 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289
[290] 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306
[307] 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323
[324] 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340
[341] 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357
[358] 358 359 360 361 362 363 364 365
```

```r
# sequencia de anos
anos <- 1961:1990
anos
```

```
 [1] 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974
[15] 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988
[29] 1989 1990
```

```r
# sequencia de inteiros decrescente
si_dec <- 10:-10
si_dec
```

```
 [1]  10   9   8   7   6   5   4   3   2   1   0  -1  -2  -3  -4  -5  -6
[18]  -7  -8  -9 -10
```

```r
# sequencia de numeros não inteiros
seqn <- 1.5:10
seqn
```

```
[1] 1.5 2.5 3.5 4.5 5.5 6.5 7.5 8.5 9.5
```

```r
c(seqn, 10)
```

```
 [1]  1.5  2.5  3.5  4.5  5.5  6.5  7.5  8.5  9.5 10.0
```

### Sequências de números não inteiros

Mas para gerar uma sequencia de números não inteiros há uma função específica para tal tarefa.

```r
# igual a c(snum, 10), mas usando o seq
(snum_b <- seq(from = 1.5, to = 10, by = 0.5))
```

```
 [1]  1.5  2.0  2.5  3.0  3.5  4.0  4.5  5.0  5.5  6.0  6.5  7.0  7.5  8.0
[15]  8.5  9.0  9.5 10.0
```

Exemplos de sequência de anos, meses e dias.

```r
# vetor com de anos decimais (2 valores por dia)
anos_dec <- seq(2010, 2011, length.out = 365*2)
# para ver só o início do vetor ao invés de todo o vetor
head(anos_dec)
```

```
[1] 2010.000 2010.001 2010.003 2010.004 2010.005 2010.007
```

```r
# mas não dá pra ver a parte decimal, vamos alterar as opções 
# aumentando as casas decimais
options(digits = 6)
# verifique agora
head(anos_dec)
```

```
[1] 2010.00 2010.00 2010.00 2010.00 2010.01 2010.01
```

```r
# só os primeiros 30 elementos
head(anos_dec, 30)
```

```
 [1] 2010.00 2010.00 2010.00 2010.00 2010.01 2010.01 2010.01 2010.01
 [9] 2010.01 2010.01 2010.01 2010.02 2010.02 2010.02 2010.02 2010.02
[17] 2010.02 2010.02 2010.02 2010.03 2010.03 2010.03 2010.03 2010.03
[25] 2010.03 2010.03 2010.04 2010.04 2010.04 2010.04
```

```r
# para ver só o final do vetor yrFrac
tail(anos_dec)
```

```
[1] 2010.99 2010.99 2011.00 2011.00 2011.00 2011.00
```

```r
# para ver só os último 50 elementos do yrFrac
tail(anos_dec, 50)
```

```
 [1] 2010.93 2010.93 2010.94 2010.94 2010.94 2010.94 2010.94 2010.94
 [9] 2010.94 2010.95 2010.95 2010.95 2010.95 2010.95 2010.95 2010.95
[17] 2010.95 2010.96 2010.96 2010.96 2010.96 2010.96 2010.96 2010.96
[25] 2010.97 2010.97 2010.97 2010.97 2010.97 2010.97 2010.97 2010.98
[33] 2010.98 2010.98 2010.98 2010.98 2010.98 2010.98 2010.98 2010.99
[41] 2010.99 2010.99 2010.99 2010.99 2010.99 2010.99 2011.00 2011.00
[49] 2011.00 2011.00
```

```r
# pentadas
pent <- seq(from = 1, to = 365, by = 5)
# dencendios
decd <- seq(from = 1, to = 365, by = 10)
# fracoes de dia 
frac_d30mn <- seq(0, 365, length.out = 365*48) + 1
head(frac_d30mn, 48*2)
```

```
 [1] 1.00000 1.02083 1.04167 1.06250 1.08334 1.10417 1.12501 1.14584
 [9] 1.16668 1.18751 1.20835 1.22918 1.25001 1.27085 1.29168 1.31252
[17] 1.33335 1.35419 1.37502 1.39586 1.41669 1.43752 1.45836 1.47919
[25] 1.50003 1.52086 1.54170 1.56253 1.58337 1.60420 1.62504 1.64587
[33] 1.66670 1.68754 1.70837 1.72921 1.75004 1.77088 1.79171 1.81255
[41] 1.83338 1.85422 1.87505 1.89588 1.91672 1.93755 1.95839 1.97922
[49] 2.00006 2.02089 2.04173 2.06256 2.08340 2.10423 2.12506 2.14590
[57] 2.16673 2.18757 2.20840 2.22924 2.25007 2.27091 2.29174 2.31257
[65] 2.33341 2.35424 2.37508 2.39591 2.41675 2.43758 2.45842 2.47925
[73] 2.50009 2.52092 2.54175 2.56259 2.58342 2.60426 2.62509 2.64593
[81] 2.66676 2.68760 2.70843 2.72927 2.75010 2.77093 2.79177 2.81260
[89] 2.83344 2.85427 2.87511 2.89594 2.91678 2.93761 2.95845 2.97928
```

```r
tail(frac_d30mn, 48*2)
```

```
 [1] 364.021 364.042 364.062 364.083 364.104 364.125 364.146 364.167
 [9] 364.187 364.208 364.229 364.250 364.271 364.292 364.312 364.333
[17] 364.354 364.375 364.396 364.417 364.437 364.458 364.479 364.500
[25] 364.521 364.542 364.562 364.583 364.604 364.625 364.646 364.667
[33] 364.687 364.708 364.729 364.750 364.771 364.792 364.812 364.833
[41] 364.854 364.875 364.896 364.917 364.937 364.958 364.979 365.000
[49] 365.021 365.042 365.062 365.083 365.104 365.125 365.146 365.167
[57] 365.187 365.208 365.229 365.250 365.271 365.292 365.312 365.333
[65] 365.354 365.375 365.396 365.417 365.437 365.458 365.479 365.500
[73] 365.521 365.542 365.562 365.583 365.604 365.625 365.646 365.667
[81] 365.687 365.708 365.729 365.750 365.771 365.792 365.812 365.833
[89] 365.854 365.875 365.896 365.917 365.937 365.958 365.979 366.000
```

```r
# diferentes funções para gerar uma sequência
an <- c(1,7,2,5,3,2)
# gerando uma sequencia a partir de um número
seq_len(length.out = 6)
```

```
[1] 1 2 3 4 5 6
```

```r
# gerando uma sequencia a partir de um número
seq(6)
```

```
[1] 1 2 3 4 5 6
```

```r
# de acordo com o tamanho do vetor gera-se uma sequencia 
seq(along = an)
```

```
[1] 1 2 3 4 5 6
```

```r
seq(along = 0) #! melhor opção para gerar sequencias do tamanho do vetor
```

```
[1] 1
```

```r
seq(0) #! cuidado
```

```
[1] 1 0
```

```r
# conflito entre parâmetros
# a <-seq(from = -5, to = 5, by = 0.05, length.out=200)
s5_by <- seq(from = -5, to = 5, by = 0.05)
length(s5_by)
```

```
[1] 201
```

```r
tail(s5_by)
```

```
[1] 4.75 4.80 4.85 4.90 4.95 5.00
```

```r
s5_len <- seq(from = -5, to = 5, length.out = 200)
length(s5_len)
```

```
[1] 200
```

```r
tail(s5_len)
```

```
[1] 4.74874 4.79899 4.84925 4.89950 4.94975 5.00000
```

### Sequências de números repetidos


```r
rep_t4 <- rep(1:2, times = 4)
rep_t4
```

```
[1] 1 2 1 2 1 2 1 2
```

```r
rep_e31 <-rep(1:12, each = 31)
rep_e31
```

```
  [1]  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
 [24]  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2
 [47]  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  3  3  3  3  3  3  3
 [70]  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3
 [93]  3  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4
[116]  4  4  4  4  4  4  4  4  4  5  5  5  5  5  5  5  5  5  5  5  5  5  5
[139]  5  5  5  5  5  5  5  5  5  5  5  5  5  5  5  5  5  6  6  6  6  6  6
[162]  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6
[185]  6  6  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7
[208]  7  7  7  7  7  7  7  7  7  7  8  8  8  8  8  8  8  8  8  8  8  8  8
[231]  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  9  9  9  9  9
[254]  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9
[277]  9  9  9 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10
[300] 10 10 10 10 10 10 10 10 10 10 10 11 11 11 11 11 11 11 11 11 11 11 11
[323] 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 12 12 12 12
[346] 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12 12
[369] 12 12 12 12
```

```r
rep_t13 <- rep(c("chuva","sol"), times = c(1,3))
rep_t13
```

```
[1] "chuva" "sol"   "sol"   "sol"  
```

```r
rep_t13_t4 <- rep(rep(c("chuva","sol"), times = c(1,3)), times = 4)
rep_t13_t4
```

```
 [1] "chuva" "sol"   "sol"   "sol"   "chuva" "sol"   "sol"   "sol"  
 [9] "chuva" "sol"   "sol"   "sol"   "chuva" "sol"   "sol"   "sol"  
```

- - -

- - -

## Seleção ou filtragem de vetores

### Por índices inteiros positivos

Considere os seguintes vetores:

```r
# vetor de chuva mensal de um ano qualquer
prec <- c(300, 150, 210, 12, 0, 0, 12, 22, 80, 100, 0, 280)
meses <- c("Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul","Ago", "Set", "Out", "Nov", "Dez")
names(prec) <- meses
prec
```

```
Jan Fev Mar Abr Mai Jun Jul Ago Set Out Nov Dez 
300 150 210  12   0   0  12  22  80 100   0 280 
```

```r
# gráfico de barras
barplot(prec)
box()
```

![](figs/chunk720-1.png)<!-- -->

```r
# vetor de temperatura do ar média mensal de um ano qualquer  
temp <- c(25, 23.2, 22.5, 21, 19, 17.6, 18, 19.7, 21.3, 22, 24, 26.8)
 names(temp) <- meses
  temp
```

```
 Jan  Fev  Mar  Abr  Mai  Jun  Jul  Ago  Set  Out  Nov  Dez 
25.0 23.2 22.5 21.0 19.0 17.6 18.0 19.7 21.3 22.0 24.0 26.8 
```

```r
   plot(temp, type = "o")
```

![](figs/chunk720-2.png)<!-- -->

Como selecionar o valor de chuva e temperatura só para janeiro?
Vamos usar a seguinte sintaxe: `vetor[...elementos a serem selecionados...]`.

```r
# vetor de chuva mensal de um ano qualquer
prec_1 <- prec[1]
 prec_1
```

```
Jan 
300 
```

```r
# vetor de temperatura do ar média mensal de um ano qualquer  
temp_1 <- temp[1]
 temp_1
```

```
Jan 
 25 
```

Como selecionar os últimos valores dos vetores de chuva e temperatura?

```r
# vetor de temperatura do ar média mensal de um ano qualquer  
temp_ult <- temp[length(temp)]
 temp_ult
```

```
 Dez 
26.8 
```

```r
prec_ult <- prec[length(prec)]
prec_ult
```

```
Dez 
280 
```

Como selecionar os valores de chuva do trimestre JJA e de temperatura para o trimestre DJF?

```r
# vetor de chuva JJA
# posicoes de interesse
pos <- c(6,7,8)
prec_jja <- prec[pos]
prec_jja
```

```
Jun Jul Ago 
  0  12  22 
```

```r
# qual o total de chuva trimestral nesse ano?
prect_jja <- sum(prec_jja)
  prect_jja
```

```
[1] 34
```

```r
# vetor de temperatura DJF
pos2 <- c(12,1,2)
temp_djf <- temp[pos2]
temp_djf
```

```
 Dez  Jan  Fev 
26.8 25.0 23.2 
```

```r
tempm_djf <- mean(temp_djf)
tempm_djf
```

```
[1] 25
```

### Por índices inteiros negativos

Como selecionar todos valores menos o primeiro e o último?

```r
# todos valores exceto o primeiro e ultimo
prec[-c(1, length(prec))]
```

```
Fev Mar Abr Mai Jun Jul Ago Set Out Nov 
150 210  12   0   0  12  22  80 100   0 
```

```r
# todos valores exceto os 3 primeiro meses
temp[-c(1:3)]
```

```
 Abr  Mai  Jun  Jul  Ago  Set  Out  Nov  Dez 
21.0 19.0 17.6 18.0 19.7 21.3 22.0 24.0 26.8 
```

```r
# todos valores exceto os 3 últimos meses
temp[-c(length(temp):(length(temp)-2))]
```

```
 Jan  Fev  Mar  Abr  Mai  Jun  Jul  Ago  Set 
25.0 23.2 22.5 21.0 19.0 17.6 18.0 19.7 21.3 
```

### Por vetores lógicos

Vamos criar um vetor lógico e usá-lo para exemplificar a seleção de elementos de um vetor. 

```r
# recriando os vetores chuva e temp
prec <- c(300, 150, 210, 12, 0, 0, 12, 22, 80, 100, 0, 280)
# vetor de temperatura do ar média mensal de um ano qualquer
temp <- c(25, 23.2, 22.5, 21, 19, 17.6, 18, 19.7, 21.3, 22, 24, 26.8)
# atribuindo nomes
meses <- c("Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", 
    "Nov", "Dez")
names(prec) <- names(temp) <- meses

# vetor logico
vetor_l <- c(TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, 
    FALSE, TRUE)
meses[vetor_l]
```

```
[1] "Jan" "Abr" "Mai" "Jul" "Set" "Dez"
```

Os elementos de `vetor_l` correspondentes a `TRUE` foram selecionados. Se nós aplicarmos uma função aritmética ao vetor lógico (vetor_l):


```r
sum(vetor_l)
```

```
[1] 6
```
Então a operação foi realizada após a conversão de `FALSE` para 0 e `TRUE` para 1. Nesse caso o resultado é a quantidade de ocorrências verdadeiras (`TRUE`) no vetor `vetor_l`.

Vamos considerar agora a seguinte forma do vetor lógico (`vetor_l`):

```r
# vetor lógico
vetor_l <- c(T, F)
meses[vetor_l]
```

```
[1] "Jan" "Mar" "Mai" "Jul" "Set" "Nov"
```

```r
vetor_l <- c(T, F, F)
meses[vetor_l]
```

```
[1] "Jan" "Abr" "Jul" "Out"
```

```r
prec[c(T,F)]
```

```
Jan Mar Mai Jul Set Nov 
300 210   0  12  80   0 
```

```r
temp[c(rep(F,3),T)]
```

```
 Abr  Ago  Dez 
21.0 19.7 26.8 
```

### Por nomes


```r
prec["Jan"]
```

```
Jan 
300 
```

```r
prec[c("Dez", "Fev", "Jun")]
```

```
Dez Fev Jun 
280 150   0 
```

### Por comparação

Por exemplo:


```r
# vetor prec
prec
```

```
Jan Fev Mar Abr Mai Jun Jul Ago Set Out Nov Dez 
300 150 210  12   0   0  12  22  80 100   0 280 
```

```r
# teste para chuva > 80 mm/mês
prec > 80
```

```
  Jan   Fev   Mar   Abr   Mai   Jun   Jul   Ago   Set   Out   Nov   Dez 
 TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE  TRUE 
```

```r
# salvando resultado do teste
eh_acima80 <- prec > 80
# extraindo valores atendidos ao teste
prec[eh_acima80]
```

```
Jan Fev Mar Out Dez 
300 150 210 100 280 
```

```r
# teste para meses com chuva abaixo da média mensal
(prec_med <- mean(prec))
```

```
[1] 97.1667
```

```r
# salvando resultado do teste
(eh_abaixo_med <- prec < prec_med)
```

```
  Jan   Fev   Mar   Abr   Mai   Jun   Jul   Ago   Set   Out   Nov   Dez 
FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE FALSE 
```

```r
# extraindo valores atendidos ao teste
prec[eh_abaixo_med]
```

```
Abr Mai Jun Jul Ago Set Nov 
 12   0   0  12  22  80   0 
```

```r
# extraindo os 3 primeiros meses com prec abaixo da média
prec[eh_abaixo_med][1:3]
```

```
Abr Mai Jun 
 12   0   0 
```

```r
# forma equivalente
prec[prec < mean(prec)][1:3]
```

```
Abr Mai Jun 
 12   0   0 
```

```r
# teste para meses com prec diferente de zero
prec[prec != 0]
```

```
Jan Fev Mar Abr Jul Ago Set Out Dez 
300 150 210  12  12  22  80 100 280 
```

<span style="color:red; font-size:1.7em;">Fim da 3ª aula ([site do curso](https://rawgit.com/jdtatsch/adar-ufsm/master/5_EstruturaDeDados.html)) </span>

Para selecionar os casos em que a `prec` foi registrada entre um intervalo de valores, ou seja queremos testar mais de uma relação ao mesmo tempo. Isso é feito usando os operadores lógicos `&` e `&&` (**e**), `|` e `||` (**ou**). 

A ordem das operações pode ser controladas por parênteses. Os operadores `&` e `|` são vetorizados (retornam vetores). As diferenças entre são mostradas nos exemplos a seguir.


```r
# prec
prec
```

```
Jan Fev Mar Abr Mai Jun Jul Ago Set Out Nov Dez 
300 150 210  12   0   0  12  22  80 100   0 280 
```

```r
# combinação de operador lógico e relacional
eh_abaixo_100 <- prec > 0 & prec <= 100
prec_cond1 <- prec[eh_abaixo_100]
prec_cond1
```

```
Abr Jul Ago Set Out 
 12  12  22  80 100 
```

A forma dupla (`&&` ou `||`) compara somente um elemento de cada lado, enquanto a forma normal (`&` e `|`), compara cada elemento dos vetores em cada lado.


```r
a <- c(1, 1, 0, 1)
b <- c(2, 1, 0, 1)
# forma normal verifica cada elemento de a e cada elemento de b
a == 1 & b == 1
```

```
[1] FALSE  TRUE FALSE  TRUE
```

```r
# forma dupla verifica somente o primeiro elemento de a e o primeiro
# elemento de b retornando somente um resultado
a == 1 && b == 1
```

```
[1] FALSE
```

Outra diferença entre as formas dupla e normal é como elas são processadas. 

  * forma normal: ambos os lados do operador são sempre testadas (função vetorizada);
  * forma dupla: às vezes apenas o lado esquerdo precisa ser testado (função não vetorizada)


```r
# exemplo em que o lado esquerdo não atende ao teste então nem há
# necessidade de testar o lado direito
1 == 0 && 2 == 2
```

```
[1] FALSE
```

```r
# exemplo em que o lado esquerdo é atendido, então não há razão para testar
# o lado direito
3 == 3 || 0 == 0
```

```
[1] TRUE
```

Esse aspecto pode ser útil quando o lado direito resultasse em erro se o lado esquerdo falhasse.

Podem haver mais que duas condições a serem testadas. Várias condições podem ser combinadas usando múltiplos `&` ou `|`. As diferentes condições podem ser agrupadas por parênteses assim como operações matemáticas. Sem parênteses, a ordem das operações é semelhante a das operações matemáticas (Parênteses, Expoentes, Multiplicação, Divisão, Adição e Subtração:  **PEMDAS**), onde `&`é equivalente à multiplicação e `|` é equivalente à adição, assim **e** tem precedência sobre **ou**.


```r
# vetor de horas
horas <- 0 : 23
# vetor de temperaturas horárias
tar_hor <- c(19.9, 19.8, 19.5, 19.4, 19.4, 19.3, 19.2, 19, 19.2, 19.5, 20.1, 20.6, 20.9, 21.8, 22.5, 22.6, 22.5, 22, 21.4, 20.1, 20, 19.8, 19.6, 19.4)
# gráfico do varição horária da temperatura do ar
plot(horas, tar_hor, type = "o", pch = 20)
# temperaturas noturnas abaixo de 20ºC
(eh_noite_menor20 <- (horas < 6 | horas > 18) & tar_hor < 20)
```

```
 [1]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE
[12] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
[23]  TRUE  TRUE
```

```r
tar_hor[eh_noite_menor20]
```

```
[1] 19.9 19.8 19.5 19.4 19.4 19.3 19.8 19.6 19.4
```

```r
# destacando no gráfico
points(x = horas[eh_noite_menor20], 
       y = tar_hor[eh_noite_menor20], 
       pch = 20,      # tipo de símbolo para os ponts
       col = "blue",  # cor do símbolo
       cex = 2)       # tamanho do ponto
# temperaturas abaixo de 20ºC que não ocorreram a noite
eh_dia_menor20 <- tar_hor < 20 & !eh_noite_menor20
points(horas[eh_dia_menor20], tar_hor[eh_dia_menor20], pch = 20, col = "red", cex = 2)
# adicionando linha horizontal ao longo da temperatura = 20ºC
abline(h = 20, col = "gray")
```

![](figs/chunk7292-1.png)<!-- -->

Vimos que a filtragem consiste em extrair elementos de um vetor que satisfaça uma (ou várias) condição(ões). Entretanto em alguns casos o interesse é na posição dentro do vetor  na qual a condição ocorre. Nós podemos fazer isso usando a função `which`:


```r
# prec sem nomes
names(prec) <- NULL
# combinação de operador lógico e relacional
eh_abaixo_100
```

```
  Jan   Fev   Mar   Abr   Mai   Jun   Jul   Ago   Set   Out   Nov   Dez 
FALSE FALSE FALSE  TRUE FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE FALSE 
```

```r
which(eh_abaixo_100)
```

```
Abr Jul Ago Set Out 
  4   7   8   9  10 
```

```r
# qual os meses em que a chuva foi acima da media
which(prec > prec_med)
```

```
[1]  1  2  3 10 12
```

```r
prec[which(prec > prec_med)]
```

```
[1] 300 150 210 100 280
```

```r
# Qual a temp quando a chuva ou a temp foi acima da media?
pos2 <- which(prec > prec_med | !temp < mean(temp))
pos2
```

```
Jan Fev Mar Out Nov Dez 
  1   2   3  10  11  12 
```

```r
prec[pos2]
```

```
[1] 300 150 210 100   0 280
```

```r
# quais posições do vetor prec não choveu
which(prec == 0)
```

```
[1]  5  6 11
```

```r
which(prec == max(prec))
```

```
[1] 1
```

```r
# equivalente a ...
which.max(prec)
```

```
[1] 1
```

```r
# seleciona só a primeira ocorrência!
which.min(prec)
```

```
[1] 5
```

```r
prec
```

```
 [1] 300 150 210  12   0   0  12  22  80 100   0 280
```

Um outro operador útil para comparação entre vetores é o operador `%in%`, que pode ser interpretado como "está contdo em". O **resultado é um vetor de mesmo tamanho que o vetor a esquerda do teste**. 


```r
# compare o tamanho dos vetores resultantes
meses %in% c("JAN", "Feb", "Mar")
```

```
 [1] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[12] FALSE
```

```r
# note a diferença
c("JAN", "Feb", "Mar") %in% meses
```

```
[1] FALSE FALSE  TRUE
```

```r
quais1 <- !meses %in% c("JAN", "Feb", "Mar")
quais1
```

```
 [1]  TRUE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
[12]  TRUE
```

```r
prec[names(temp) %in% c("Jun", "Jul", "Ago")]
```

```
[1]  0 12 22
```

## Substituição de elementos de um vetor


```r
# posição a ser alterada
pos <- 10
# valor da temperatura naquela posição
valor <- temp[pos]   
valor
```

```
Out 
 22 
```

```r
# vetor de temperatura
temp
```

```
 Jan  Fev  Mar  Abr  Mai  Jun  Jul  Ago  Set  Out  Nov  Dez 
25.0 23.2 22.5 21.0 19.0 17.6 18.0 19.7 21.3 22.0 24.0 26.8 
```

```r
# substituição do valor original por um novo valor
novo_valor <- 30
# alterando temperatura do mês de outubro
temp[pos] <- novo_valor
temp
```

```
 Jan  Fev  Mar  Abr  Mai  Jun  Jul  Ago  Set  Out  Nov  Dez 
25.0 23.2 22.5 21.0 19.0 17.6 18.0 19.7 21.3 30.0 24.0 26.8 
```
  
A substituição também pode ser feita também pelo nome das variáveis.


```r
prec
```

```
 [1] 300 150 210  12   0   0  12  22  80 100   0 280
```

```r
prec["Mai"] <- 5
temp
```

```
 Jan  Fev  Mar  Abr  Mai  Jun  Jul  Ago  Set  Out  Nov  Dez 
25.0 23.2 22.5 21.0 19.0 17.6 18.0 19.7 21.3 30.0 24.0 26.8 
```

```r
temp[c("Mai", "Jul")] <- temp[c("Mai", "Jul")] + 2
temp
```

```
 Jan  Fev  Mar  Abr  Mai  Jun  Jul  Ago  Set  Out  Nov  Dez 
25.0 23.2 22.5 21.0 21.0 17.6 20.0 19.7 21.3 30.0 24.0 26.8 
```

## Criação de vetores com `vector`

Outra forma de se criar vetores é através da função `vector()`.


```r
# criação de vetor v
v <- 3
v
```

```
[1] 3
```

```r
# adicionando elementos
v[2] <- 100
v
```

```
[1]   3 100
```

```r
v[5] <- 6
v
```

```
[1]   3 100  NA  NA   6
```

```r
# adicionando elementos de vetores
x <- c(88, 5, 12, 13)
x <- c(x[1:3], 168, x[4])  # insere 168 antes do 13
x
```

```
[1]  88   5  12 168  13
```

```r
# outra opção
k <- vector()
class(k)
```

```
[1] "logical"
```

```r
# vetor k existe?
ls()
```

```
 [1] "a"                "an"               "anos"            
 [4] "anos_dec"         "a_novo"           "b"               
 [7] "chuva"            "cte"              "dda"             
[10] "decd"             "eh_abaixo_100"    "eh_abaixo_med"   
[13] "eh_acima80"       "eh_dia_menor20"   "eh_noite_menor20"
[16] "frac_d30mn"       "horas"            "k"               
[19] "meses"            "months"           "novo_valor"      
[22] "pcks"             "pent"             "pos"             
[25] "pos2"             "prec"             "prec_1"          
[28] "prec_cond1"       "prec_jja"         "prec_med"        
[31] "prect_jja"        "prec_ult"         "quais1"          
[34] "rep_e31"          "rep_t13"          "rep_t13_t4"      
[37] "rep_t4"           "s5_by"            "s5_len"          
[40] "seco"             "seco01"           "seqn"            
[43] "si_dec"           "snum_b"           "tar_hor"         
[46] "temp"             "temp_1"           "temp_djf"        
[49] "tempm_djf"        "temp_ult"         "v"               
[52] "v1"               "v_123"            "v_123a"          
[55] "v_123b"           "v2"               "v3"              
[58] "valor"            "vetor"            "vetor_char"      
[61] "vetor_int"        "vetor_l"          "vetor_log"       
[64] "vetor_num"        "x"                "y"               
[67] "z"               
```

```r
# alocando o valor 45 no 3º elemento de k
k[3] <- 45
k
```

```
[1] NA NA 45
```

```r
class(k)
```

```
[1] "numeric"
```

```r
# diminuindo o tamanho de k
length(k)
```

```
[1] 3
```

```r
length(k) <- 2
k
```

```
[1] NA NA
```

```r
length(k) <- 0
k
```

```
numeric(0)
```

```r
class(k)
```

```
[1] "numeric"
```

```r
is.null(k)
```

```
[1] FALSE
```

```r
# exemplo
temp <- c(25, 23.2, 22.5, 21, 19, 17.6, 18, 19.7, 21.3, 22, 24, 26.8)
temp_orig <- temp
# mostrando o vetor temp
temp
```

```
 [1] 25.0 23.2 22.5 21.0 19.0 17.6 18.0 19.7 21.3 22.0 24.0 26.8
```

```r
temp[]
```

```
 [1] 25.0 23.2 22.5 21.0 19.0 17.6 18.0 19.7 21.3 22.0 24.0 26.8
```

```r
# substituir todos elementos do vetor temp por um vetor com apenas um valor
temp <- 0
temp
```

```
[1] 0
```

```r
# vamos redefinir temp e comparar o anterior com o obtido com o próximo
# comando
temp <- temp_orig
temp[1:length(temp)] <- 0
temp
```

```
 [1] 0 0 0 0 0 0 0 0 0 0 0 0
```

```r
# qual diferença de x <- 0 e x[] <-0 ?
temp <- temp_orig
temp[] <- 0
temp
```

```
 [1] 0 0 0 0 0 0 0 0 0 0 0 0
```

```r
# Um vetor com tamanho pre-definido e do tipo numeric
umvetor <- vector(mode = "numeric", length = 100)
umvetor
```

```
  [1] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 [36] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 [71] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
```

```r
# populando o vetor
umvetor[1] <- 10
umvetor[10] <- 100
umvetor
```

```
  [1]  10   0   0   0   0   0   0   0   0 100   0   0   0   0   0   0   0
 [18]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
 [35]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
 [52]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
 [69]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
 [86]   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
```

## Vetores nulos e elementos faltantes

Seja qual for a razão, ao realizar um experimento em condições reais sempre haverá situações em que não conhecemos o valor de uma determinada variável. Por exemplo, a série de uma variável meteorológica medida em estação de superfície, sempre ocorrem datas em que não há registro da variável. Falha instrumental, dado não coletado pelo observador (feriados), falta de energia, são causas inerentes de falhas em séries climáticas de longo prazo. 
No R dados faltantes são representados pela string `NA`.


```r
5 + NA
```

```
[1] NA
```

```r
v1 <- c(1:8,NA)
v1 > 5    # NA sai na resposta
```

```
[1] FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE    NA
```

```r
# teste lógico com o operador idêntico "=="
v1 == NA  
```

```
[1] NA NA NA NA NA NA NA NA NA
```

```r
# não funcionou, porque há funções específicas para vetores com NA
eh.na <- is.na(v1)
# função apropriada p/ checar se tem NAs
faltante <- which(is.na(v1));
v1[-faltante]
```

```
[1] 1 2 3 4 5 6 7 8
```

```r
# ou 
v1[!eh.na]
```

```
[1] 1 2 3 4 5 6 7 8
```

```r
# vamos calcular a média de v1
sum(v1)/length(v1)
```

```
[1] NA
```

```r
# vamos remover valores NA
sum(v1[-faltante])/length(v1[-faltante])
```

```
[1] 4.5
```

```r
sum(v1[!eh.na])/length(v1[!eh.na])
```

```
[1] 4.5
```

```r
# mas o R possui a função mean 
mean(v1) 
```

```
[1] NA
```

```r
# não retornou o que desejamos, removendo as posicoes dos dados faltantes
mean(v1[-faltante])
```

```
[1] 4.5
```

```r
# ok, mas olhando o help ...
#?mean
mean(v1, na.rm=TRUE)
```

```
[1] 4.5
```

```r
# definir como faltante todos elementos de v1
v1[] <- NA
v1
```

```
[1] NA NA NA NA NA NA NA NA NA
```

```r
length(v1)
```

```
[1] 9
```

```r
# vetor com dados faltantes indicados por -999
# substituir onde é -999 por NA
x <- c(-999, 10, 15, -999, 50)
x == -999
```

```
[1]  TRUE FALSE FALSE  TRUE FALSE
```

```r
x[x == -999] <- NA 
# total de dados faltantes
sum(!is.na(x))
```

```
[1] 3
```


## Diferença entre `NA` e `NULL`

O `NULL` é um tipo de dado especial do R sem `mode` (modo).


```r
# v1 existe ?
ls()
```

```
 [1] "a"                "an"               "anos"            
 [4] "anos_dec"         "a_novo"           "b"               
 [7] "chuva"            "cte"              "dda"             
[10] "decd"             "eh_abaixo_100"    "eh_abaixo_med"   
[13] "eh_acima80"       "eh_dia_menor20"   "eh.na"           
[16] "eh_noite_menor20" "faltante"         "frac_d30mn"      
[19] "horas"            "k"                "meses"           
[22] "months"           "novo_valor"       "pcks"            
[25] "pent"             "pos"              "pos2"            
[28] "prec"             "prec_1"           "prec_cond1"      
[31] "prec_jja"         "prec_med"         "prect_jja"       
[34] "prec_ult"         "quais1"           "rep_e31"         
[37] "rep_t13"          "rep_t13_t4"       "rep_t4"          
[40] "s5_by"            "s5_len"           "seco"            
[43] "seco01"           "seqn"             "si_dec"          
[46] "snum_b"           "tar_hor"          "temp"            
[49] "temp_1"           "temp_djf"         "tempm_djf"       
[52] "temp_orig"        "temp_ult"         "umvetor"         
[55] "v"                "v1"               "v_123"           
[58] "v_123a"           "v_123b"           "v2"              
[61] "v3"               "valor"            "vetor"           
[64] "vetor_char"       "vetor_int"        "vetor_l"         
[67] "vetor_log"        "vetor_num"        "x"               
[70] "y"                "z"               
```

```r
exists("v1")
```

```
[1] TRUE
```

```r
# vamos anular todo v1
v1 <- NULL
ls()
```

```
 [1] "a"                "an"               "anos"            
 [4] "anos_dec"         "a_novo"           "b"               
 [7] "chuva"            "cte"              "dda"             
[10] "decd"             "eh_abaixo_100"    "eh_abaixo_med"   
[13] "eh_acima80"       "eh_dia_menor20"   "eh.na"           
[16] "eh_noite_menor20" "faltante"         "frac_d30mn"      
[19] "horas"            "k"                "meses"           
[22] "months"           "novo_valor"       "pcks"            
[25] "pent"             "pos"              "pos2"            
[28] "prec"             "prec_1"           "prec_cond1"      
[31] "prec_jja"         "prec_med"         "prect_jja"       
[34] "prec_ult"         "quais1"           "rep_e31"         
[37] "rep_t13"          "rep_t13_t4"       "rep_t4"          
[40] "s5_by"            "s5_len"           "seco"            
[43] "seco01"           "seqn"             "si_dec"          
[46] "snum_b"           "tar_hor"          "temp"            
[49] "temp_1"           "temp_djf"         "tempm_djf"       
[52] "temp_orig"        "temp_ult"         "umvetor"         
[55] "v"                "v1"               "v_123"           
[58] "v_123a"           "v_123b"           "v2"              
[61] "v3"               "valor"            "vetor"           
[64] "vetor_char"       "vetor_int"        "vetor_l"         
[67] "vetor_log"        "vetor_num"        "x"               
[70] "y"                "z"               
```

```r
v1
```

```
NULL
```

```r
# NULL
vetor1 <- c()
vetor2 <- NULL
is.null(c(vetor1, vetor2))
```

```
[1] TRUE
```

```r
# vetor1 e vetor2 são equivalentes?
identical(vetor1, vetor2)
```

```
[1] TRUE
```

```r
# remoção de elementos de um vetor com NULL
a <- c(10, 2, NA, 20)
a
```

```
[1] 10  2 NA 20
```

```r
mode(a)
```

```
[1] "numeric"
```

```r
# remover de a o dado faltante
a <- a[!is.na(a)]
a
```

```
[1] 10  2 20
```

```r
a <- NULL
a
```

```
NULL
```

```r
mode(a)
```

```
[1] "NULL"
```

```r
b <- NA
b
```

```
[1] NA
```

```r
mode(b)
```

```
[1] "logical"
```

```r
length(a)
```

```
[1] 0
```

```r
length(b)
```

```
[1] 1
```

- - -

# Matrix

Vetores são objetos unidimensionais. Vetores multidimensionais são denominados *arrays*. As matrizes são um caso especial de *array* em que o número de dimensões é igual a 2, uma dimensão são as linhas e a outra as colunas. Os dados armazenados em uma matriz são de uma única classe (ou `numeric`, ou `character`, por exemplo).

## Criação de matrizes

### Função `dim()` 

Podemos converter um vetor atômico em uma array de n dimensões através do atributo dimensão: `dim()`. Para fazer isso, definimos o atributo `dim`(dimensão) a um vetor numérico de tamanho `n`. 
O R reorganizará os elementos do vetor de acordo com as dimensões.


```r
v <- 1:12
length(v)
```

```
[1] 12
```

```r
attributes(v)
```

```
NULL
```

```r
class(v)
```

```
[1] "integer"
```

```r
## cópia de v0
vetor <- v
## conversão de vetor para matriz
dim(v) <- c(3, 4)  # 1a dimensão: linhas , 2a dimensão: colunas 
## vetor é vector?
is.vector(v)
```

```
[1] FALSE
```

```r
## vetor é matrix?
is.matrix(v)
```

```
[1] TRUE
```

```r
## classe de vetor
class(v)
```

```
[1] "matrix"
```

```r
attributes(v)
```

```
$dim
[1] 3 4
```

```r
v
```

```
     [,1] [,2] [,3] [,4]
[1,]    1    4    7   10
[2,]    2    5    8   11
[3,]    3    6    9   12
```

```r
## invertendo as dimensões
dim(v) <- c(4, 3)
v
```

```
     [,1] [,2] [,3]
[1,]    1    5    9
[2,]    2    6   10
[3,]    3    7   11
[4,]    4    8   12
```

```r
class(v)
```

```
[1] "matrix"
```

```r
mode(v)
```

```
[1] "numeric"
```

O R usa o primeiro valor de `dim()` para o número de linhas e o segundo para o número de colunas. De forma geral em operações que usam linhas e colunas, as linhas vem sempre em primeiro.
É importante notar que o R sempre preenche cada matriz ao longo das colunas ao invés das linhas.
Para mais controle na forma como R reorganiza os dados em linhas e colunas, podemos utilizar a função `matrix()` ou `array()`. Elas fazem a mesma coisa que a `dim()` porém com argumentos mais versáteis para este processo.

### Função `matrix` 

Note como os números foram distribuídos na matriz com 3 linhas e 4 colunas. Outra forma simples de se criar uma matriz é usando a função `matrix`.

Ao aplicarmos a função `matrix` a um vetor sem especificar nenhum argumento ela produz uma matriz de uma coluna.


```r
## atribuindo novas dimensões ao vetor
m <- matrix(vetor)  # matriz de uma coluna
m
```

```
      [,1]
 [1,]    1
 [2,]    2
 [3,]    3
 [4,]    4
 [5,]    5
 [6,]    6
 [7,]    7
 [8,]    8
 [9,]    9
[10,]   10
[11,]   11
[12,]   12
```

Se desejamos construir uma matriz com 3 linhas e 4 colunas a partir do vetor `vetor` podemos usar as seguintes expressões equivalentes:


```r
## criando a matriz gerada com dim
mat <- matrix(vetor, nrow = 3, ncol = 4)
mat
```

```
     [,1] [,2] [,3] [,4]
[1,]    1    4    7   10
[2,]    2    5    8   11
[3,]    3    6    9   12
```

```r
## não há necessidade de especificar ambos ncol e nrow
mat <- matrix(vetor, nrow = 3)
mat
```

```
     [,1] [,2] [,3] [,4]
[1,]    1    4    7   10
[2,]    2    5    8   11
[3,]    3    6    9   12
```

Poderíamos criar a matriz `mat` especificando os elementos individualmente:


```r
## criando a matriz gerada com dim
mat <- matrix(nrow = 3, ncol = 4)
mat
```

```
     [,1] [,2] [,3] [,4]
[1,]   NA   NA   NA   NA
[2,]   NA   NA   NA   NA
[3,]   NA   NA   NA   NA
```

```r
mat[1, 1] <- 1
mat[2, 1] <- 2
mat[3, 1] <- 3
mat[1, 2] <- 4
mat[2, 2] <- 5
mat[3, 2] <- 6
mat[1, 3] <- 7
mat[2, 3] <- 8
mat[3, 3] <- 9
mat[1, 4] <- 10
mat[2, 4] <- 11
mat[3, 4] <- 12
mat
```

```
     [,1] [,2] [,3] [,4]
[1,]    1    4    7   10
[2,]    2    5    8   11
[3,]    3    6    9   12
```

No exemplo a seguir os dados do vetor aparecem distribuídos ao longo das linhas e não das colunas como no caso acima. Nós definimos isso com o argumento **`byrow = TRUE`** da função `matrix`:


```r
## byrow = T
mat <- matrix(vetor, ncol = 4, byrow = T)
mat
```

```
     [,1] [,2] [,3] [,4]
[1,]    1    2    3    4
[2,]    5    6    7    8
[3,]    9   10   11   12
```

## Nomes das linhas e colunas de uma matriz

Nas matrizes, assim como nos vetores, também é possível dar nomes aos elementos para tornar a leitura da informação mais clara. 
Vamos usar os vetores de temperatura mensal dos anos de `1990:1992`para construir uma matriz com os meses ao longo das colunas e  os anos ao longo das linhas. 


```r
## temperatura do ar média mensal do ano de 1990
temp90 <- c(25, 23.2, 22.5, 21, 19, 17.6, 18, 19.7, 21.3, 22, 24, 26.8)
## temperatura do ar média mensal do ano de 1991
temp91 <- c(24.89, 24.07, 23.56, 23.11, 18.29, 18.22, 16.72, 19.37, 20.08, 21.45, 
    26.61, 25.99)
## temperatura do ar média mensal do ano de 1992
temp92 <- c(23.2, 26.61, 18, 23.11, 26.8, 21.3, 18.22, 21.45, 19.7, 22.5, 24.07, 
    20.08)
## vetor com as temperaturas dos 3 anos
vtemp <- c(temp90, temp91, temp92)
vtemp
```

```
 [1] 25.00 23.20 22.50 21.00 19.00 17.60 18.00 19.70 21.30 22.00 24.00
[12] 26.80 24.89 24.07 23.56 23.11 18.29 18.22 16.72 19.37 20.08 21.45
[23] 26.61 25.99 23.20 26.61 18.00 23.11 26.80 21.30 18.22 21.45 19.70
[34] 22.50 24.07 20.08
```

```r
## arranjar matrix com meses ao longo das colunas e anos ao longo das linhas
temp_mat <- matrix(vtemp, ncol = 12, byrow = T)
temp_mat
```

```
      [,1]  [,2]  [,3]  [,4]  [,5]  [,6]  [,7]  [,8]  [,9] [,10] [,11]
[1,] 25.00 23.20 22.50 21.00 19.00 17.60 18.00 19.70 21.30 22.00 24.00
[2,] 24.89 24.07 23.56 23.11 18.29 18.22 16.72 19.37 20.08 21.45 26.61
[3,] 23.20 26.61 18.00 23.11 26.80 21.30 18.22 21.45 19.70 22.50 24.07
     [,12]
[1,] 26.80
[2,] 25.99
[3,] 20.08
```

```r
## cópia da matriz temp_mat (sem nomes)
temp_matO <- temp_mat
```

Atribuindo nomes às linhas (`rownames`) e colunas (`colnames`) da matriz criada dos vetores de temperatura mensal (`temp_mat`).


```r
## atribuindo nomes as colunas e linhas da temp_mat
rownames(temp_mat) <- c("ano1990", "ano1991", "ano1992")
colnames(temp_mat) <- c("Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", 
    "Set", "Out", "Nov", "Dez")
temp_mat
```

```
          Jan   Fev   Mar   Abr   Mai   Jun   Jul   Ago   Set   Out   Nov
ano1990 25.00 23.20 22.50 21.00 19.00 17.60 18.00 19.70 21.30 22.00 24.00
ano1991 24.89 24.07 23.56 23.11 18.29 18.22 16.72 19.37 20.08 21.45 26.61
ano1992 23.20 26.61 18.00 23.11 26.80 21.30 18.22 21.45 19.70 22.50 24.07
          Dez
ano1990 26.80
ano1991 25.99
ano1992 20.08
```

## Indexação de matrizes

Como acessamos o valor de temperatura de maio de 1991 na matriz `temp_mat`?


```r
temp_mat  # matriz de temperaturas com nomes
```

```
          Jan   Fev   Mar   Abr   Mai   Jun   Jul   Ago   Set   Out   Nov
ano1990 25.00 23.20 22.50 21.00 19.00 17.60 18.00 19.70 21.30 22.00 24.00
ano1991 24.89 24.07 23.56 23.11 18.29 18.22 16.72 19.37 20.08 21.45 26.61
ano1992 23.20 26.61 18.00 23.11 26.80 21.30 18.22 21.45 19.70 22.50 24.07
          Dez
ano1990 26.80
ano1991 25.99
ano1992 20.08
```

```r
temp_matO  # matriz de temperaturas sem nomes
```

```
      [,1]  [,2]  [,3]  [,4]  [,5]  [,6]  [,7]  [,8]  [,9] [,10] [,11]
[1,] 25.00 23.20 22.50 21.00 19.00 17.60 18.00 19.70 21.30 22.00 24.00
[2,] 24.89 24.07 23.56 23.11 18.29 18.22 16.72 19.37 20.08 21.45 26.61
[3,] 23.20 26.61 18.00 23.11 26.80 21.30 18.22 21.45 19.70 22.50 24.07
     [,12]
[1,] 26.80
[2,] 25.99
[3,] 20.08
```

```r
## qual a linha do ano de 1991
linha <- 2
## qual a coluna do mês de maio
coluna <- 5
## extraindo
temp_mat[linha, coluna]
```

```
[1] 18.29
```

```r
## ou usando os nomes
temp_mat["ano1991", "Mai"]
```

```
[1] 18.29
```

Com o operador `[` podemos usar todos os esquemas de indexação vistos na Unidade de **Seleção e filtragem de dados**.


```r
## temperaturas de todos janeiros
temp_mat[, 1]
```

```
ano1990 ano1991 ano1992 
  25.00   24.89   23.20 
```

```r
temp_mat[, "Jan"]
```

```
ano1990 ano1991 ano1992 
  25.00   24.89   23.20 
```

```r
## só as temperaturas de 1990 e 1993
temp_mat[-2, ]
```

```
         Jan   Fev  Mar   Abr  Mai  Jun   Jul   Ago  Set  Out   Nov   Dez
ano1990 25.0 23.20 22.5 21.00 19.0 17.6 18.00 19.70 21.3 22.0 24.00 26.80
ano1992 23.2 26.61 18.0 23.11 26.8 21.3 18.22 21.45 19.7 22.5 24.07 20.08
```

```r
## só as temperaturas dos verões
temp_mat[, c(12, 1, 2)]
```

```
          Dez   Jan   Fev
ano1990 26.80 25.00 23.20
ano1991 25.99 24.89 24.07
ano1992 20.08 23.20 26.61
```

```r
## invertendo ordem das colunas
temp_mat[, ncol(temp_mat):1]
```

```
          Dez   Nov   Out   Set   Ago   Jul   Jun   Mai   Abr   Mar   Fev
ano1990 26.80 24.00 22.00 21.30 19.70 18.00 17.60 19.00 21.00 22.50 23.20
ano1991 25.99 26.61 21.45 20.08 19.37 16.72 18.22 18.29 23.11 23.56 24.07
ano1992 20.08 24.07 22.50 19.70 21.45 18.22 21.30 26.80 23.11 18.00 26.61
          Jan
ano1990 25.00
ano1991 24.89
ano1992 23.20
```

```r
## invertendo ordem das colunas e das linhas
temp_mat[3:1, 12:1]
```

```
          Dez   Nov   Out   Set   Ago   Jul   Jun   Mai   Abr   Mar   Fev
ano1992 20.08 24.07 22.50 19.70 21.45 18.22 21.30 26.80 23.11 18.00 26.61
ano1991 25.99 26.61 21.45 20.08 19.37 16.72 18.22 18.29 23.11 23.56 24.07
ano1990 26.80 24.00 22.00 21.30 19.70 18.00 17.60 19.00 21.00 22.50 23.20
          Jan
ano1992 23.20
ano1991 24.89
ano1990 25.00
```

```r
## invertendo ordem das colunas e das linhas
temp_mat[c(2, 1, 3), c(6:1, 12, 10:8)]
```

```
          Jun   Mai   Abr   Mar   Fev   Jan   Dez   Out   Set   Ago
ano1991 18.22 18.29 23.11 23.56 24.07 24.89 25.99 21.45 20.08 19.37
ano1990 17.60 19.00 21.00 22.50 23.20 25.00 26.80 22.00 21.30 19.70
ano1992 21.30 26.80 23.11 18.00 26.61 23.20 20.08 22.50 19.70 21.45
```

```r
## só as temperaturas dos invernos
temp_mat[, colnames(temp_mat) %in% c("Jun", "Jul", "Ago")]
```

```
          Jun   Jul   Ago
ano1990 17.60 18.00 19.70
ano1991 18.22 16.72 19.37
ano1992 21.30 18.22 21.45
```

```r
## exceto as temperaturas dos invernos
temp_mat[, -which(colnames(temp_mat) %in% c("Jun", "Jul", "Ago"))]
```

```
          Jan   Fev   Mar   Abr   Mai   Set   Out   Nov   Dez
ano1990 25.00 23.20 22.50 21.00 19.00 21.30 22.00 24.00 26.80
ano1991 24.89 24.07 23.56 23.11 18.29 20.08 21.45 26.61 25.99
ano1992 23.20 26.61 18.00 23.11 26.80 19.70 22.50 24.07 20.08
```

```r
## seleção de colunas intercaladas da matriz: mês sim, mês nao
temp_mat[, c(T, F)]
```

```
          Jan   Mar   Mai   Jul   Set   Nov
ano1990 25.00 22.50 19.00 18.00 21.30 24.00
ano1991 24.89 23.56 18.29 16.72 20.08 26.61
ano1992 23.20 18.00 26.80 18.22 19.70 24.07
```

```r
## 2 meses sim, 1 mes não
temp_mat[, c(T, T, F)]
```

```
          Jan   Fev   Abr   Mai   Jul   Ago   Out   Nov
ano1990 25.00 23.20 21.00 19.00 18.00 19.70 22.00 24.00
ano1991 24.89 24.07 23.11 18.29 16.72 19.37 21.45 26.61
ano1992 23.20 26.61 23.11 26.80 18.22 21.45 22.50 24.07
```

Podemos fazer uso do operador `[` de forma aninhada:


```r
temp_mat[, 1:6]
```

```
          Jan   Fev   Mar   Abr   Mai   Jun
ano1990 25.00 23.20 22.50 21.00 19.00 17.60
ano1991 24.89 24.07 23.56 23.11 18.29 18.22
ano1992 23.20 26.61 18.00 23.11 26.80 21.30
```

```r
temp_mat[, 1:6]["ano1991", ]
```

```
  Jan   Fev   Mar   Abr   Mai   Jun 
24.89 24.07 23.56 23.11 18.29 18.22 
```

```r
temp_mat[, 1:6]["ano1991", ][2:4]
```

```
  Fev   Mar   Abr 
24.07 23.56 23.11 
```

Podemos substituir valores de uma submatriz da matriz:


```r
M <- temp_mat
M
```

```
          Jan   Fev   Mar   Abr   Mai   Jun   Jul   Ago   Set   Out   Nov
ano1990 25.00 23.20 22.50 21.00 19.00 17.60 18.00 19.70 21.30 22.00 24.00
ano1991 24.89 24.07 23.56 23.11 18.29 18.22 16.72 19.37 20.08 21.45 26.61
ano1992 23.20 26.61 18.00 23.11 26.80 21.30 18.22 21.45 19.70 22.50 24.07
          Dez
ano1990 26.80
ano1991 25.99
ano1992 20.08
```

```r
## 1990 e 1992 os meses de jan e dez
M[c(1, 3), c(1, 12)]
```

```
         Jan   Dez
ano1990 25.0 26.80
ano1992 23.2 20.08
```

```r
## matriz com novos valores
matrix(c(21, 22, 23, 24), ncol = 2)
```

```
     [,1] [,2]
[1,]   21   23
[2,]   22   24
```

```r
## substituindo
M[c(1, 3), c(1, 12)] <- matrix(c(21, 22, 23, 24), ncol = 2)
M
```

```
          Jan   Fev   Mar   Abr   Mai   Jun   Jul   Ago   Set   Out   Nov
ano1990 21.00 23.20 22.50 21.00 19.00 17.60 18.00 19.70 21.30 22.00 24.00
ano1991 24.89 24.07 23.56 23.11 18.29 18.22 16.72 19.37 20.08 21.45 26.61
ano1992 22.00 26.61 18.00 23.11 26.80 21.30 18.22 21.45 19.70 22.50 24.07
          Dez
ano1990 23.00
ano1991 25.99
ano1992 24.00
```

Outro exemplo:


```r
mx <- matrix(nrow = 3, ncol = 3)
my <- matrix(c(4, 5, 2, 3), nrow = 2)
my
```

```
     [,1] [,2]
[1,]    4    2
[2,]    5    3
```

```r
mx[2:3, 2:3] <- my
mx
```

```
     [,1] [,2] [,3]
[1,]   NA   NA   NA
[2,]   NA    4    2
[3,]   NA    5    3
```

## Número de linhas e colunas de uma matriz


```r
M
```

```
          Jan   Fev   Mar   Abr   Mai   Jun   Jul   Ago   Set   Out   Nov
ano1990 21.00 23.20 22.50 21.00 19.00 17.60 18.00 19.70 21.30 22.00 24.00
ano1991 24.89 24.07 23.56 23.11 18.29 18.22 16.72 19.37 20.08 21.45 26.61
ano1992 22.00 26.61 18.00 23.11 26.80 21.30 18.22 21.45 19.70 22.50 24.07
          Dez
ano1990 23.00
ano1991 25.99
ano1992 24.00
```

```r
ncol(temp_mat)
```

```
[1] 12
```

```r
nrow(temp_mat)
```

```
[1] 3
```

```r
dim(temp_mat)
```

```
[1]  3 12
```

Existem funções específicas para saber a coluna e a linha cada elemento de uma matriz.


```r
## colunas de cada elemento da matriz
col(temp_mat)
```

```
     [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12]
[1,]    1    2    3    4    5    6    7    8    9    10    11    12
[2,]    1    2    3    4    5    6    7    8    9    10    11    12
[3,]    1    2    3    4    5    6    7    8    9    10    11    12
```

```r
## linhas de cada elemento da matriz
row(temp_mat)
```

```
     [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12]
[1,]    1    1    1    1    1    1    1    1    1     1     1     1
[2,]    2    2    2    2    2    2    2    2    2     2     2     2
[3,]    3    3    3    3    3    3    3    3    3     3     3     3
```

```r
## elementos de matriz
m <- matrix(1:16, nrow = 4, byrow = T)
m
```

```
     [,1] [,2] [,3] [,4]
[1,]    1    2    3    4
[2,]    5    6    7    8
[3,]    9   10   11   12
[4,]   13   14   15   16
```

```r
## nós veremos mais sobre a função paste futuramente
elementos <- paste("m", row(m), col(m), sep = "")
mel <- matrix(elementos, ncol = 4)
mel
```

```
     [,1]  [,2]  [,3]  [,4] 
[1,] "m11" "m12" "m13" "m14"
[2,] "m21" "m22" "m23" "m24"
[3,] "m31" "m32" "m33" "m34"
[4,] "m41" "m42" "m43" "m44"
```

```r
## qual colunas de M são idênticas a 1
col(m) == 1
```

```
     [,1]  [,2]  [,3]  [,4]
[1,] TRUE FALSE FALSE FALSE
[2,] TRUE FALSE FALSE FALSE
[3,] TRUE FALSE FALSE FALSE
[4,] TRUE FALSE FALSE FALSE
```

```r
## seleciona na M colunas idênticas a 1
mel[col(m) == 1]
```

```
[1] "m11" "m21" "m31" "m41"
```

```r
## qual colunas de M são idênticas a 1 ou 3?
col(m) == 1 | col(m) == 3
```

```
     [,1]  [,2] [,3]  [,4]
[1,] TRUE FALSE TRUE FALSE
[2,] TRUE FALSE TRUE FALSE
[3,] TRUE FALSE TRUE FALSE
[4,] TRUE FALSE TRUE FALSE
```

```r
## Usando operadores relacionais
row(m) == 1
```

```
      [,1]  [,2]  [,3]  [,4]
[1,]  TRUE  TRUE  TRUE  TRUE
[2,] FALSE FALSE FALSE FALSE
[3,] FALSE FALSE FALSE FALSE
[4,] FALSE FALSE FALSE FALSE
```

```r
col(m) == 3
```

```
      [,1]  [,2] [,3]  [,4]
[1,] FALSE FALSE TRUE FALSE
[2,] FALSE FALSE TRUE FALSE
[3,] FALSE FALSE TRUE FALSE
[4,] FALSE FALSE TRUE FALSE
```

```r
row(m) == 1 | col(m) == 3
```

```
      [,1]  [,2] [,3]  [,4]
[1,]  TRUE  TRUE TRUE  TRUE
[2,] FALSE FALSE TRUE FALSE
[3,] FALSE FALSE TRUE FALSE
[4,] FALSE FALSE TRUE FALSE
```

```r
## seleciona valores de M posicionados na linha 1 OU na coluna 6
mel[row(m) == 1 | col(m) == 4]
```

```
[1] "m11" "m12" "m13" "m14" "m24" "m34" "m44"
```

```r
m[row(m) == 1 | col(m) == 4]
```

```
[1]  1  2  3  4  8 12 16
```

```r
## seleciona valores de M posicionados na linha 1 E na coluna 6
mel[row(m) == 4 & col(m) == 4]
```

```
[1] "m44"
```

```r
m[row(m) == 4 & col(m) == 4]
```

```
[1] 16
```

## Acrescentando linhas e colunas a uma matriz


```r
(temp_mat_lin <- rbind(temp90, temp91, temp92))
```

```
        [,1]  [,2]  [,3]  [,4]  [,5]  [,6]  [,7]  [,8]  [,9] [,10] [,11]
temp90 25.00 23.20 22.50 21.00 19.00 17.60 18.00 19.70 21.30 22.00 24.00
temp91 24.89 24.07 23.56 23.11 18.29 18.22 16.72 19.37 20.08 21.45 26.61
temp92 23.20 26.61 18.00 23.11 26.80 21.30 18.22 21.45 19.70 22.50 24.07
       [,12]
temp90 26.80
temp91 25.99
temp92 20.08
```

```r
(temp_mat_col <- cbind(temp90, temp91, temp92))
```

```
      temp90 temp91 temp92
 [1,]   25.0  24.89  23.20
 [2,]   23.2  24.07  26.61
 [3,]   22.5  23.56  18.00
 [4,]   21.0  23.11  23.11
 [5,]   19.0  18.29  26.80
 [6,]   17.6  18.22  21.30
 [7,]   18.0  16.72  18.22
 [8,]   19.7  19.37  21.45
 [9,]   21.3  20.08  19.70
[10,]   22.0  21.45  22.50
[11,]   24.0  26.61  24.07
[12,]   26.8  25.99  20.08
```

```r
## recursão
rbind(1:10, 11, 21:25)
```

```
     [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
[1,]    1    2    3    4    5    6    7    8    9    10
[2,]   11   11   11   11   11   11   11   11   11    11
[3,]   21   22   23   24   25   21   22   23   24    25
```

```r
cbind(10:6, 5:4, 0)
```

```
Warning in cbind(10:6, 5:4, 0): number of rows of result is not a multiple
of vector length (arg 2)
```

```
     [,1] [,2] [,3]
[1,]   10    5    0
[2,]    9    4    0
[3,]    8    5    0
[4,]    7    4    0
[5,]    6    5    0
```

## Operações matriciais

A primeira entre as diversas funções de álgebra matricial no R é a transposta `t()`.

```r
temp_mat
```

```
          Jan   Fev   Mar   Abr   Mai   Jun   Jul   Ago   Set   Out   Nov
ano1990 25.00 23.20 22.50 21.00 19.00 17.60 18.00 19.70 21.30 22.00 24.00
ano1991 24.89 24.07 23.56 23.11 18.29 18.22 16.72 19.37 20.08 21.45 26.61
ano1992 23.20 26.61 18.00 23.11 26.80 21.30 18.22 21.45 19.70 22.50 24.07
          Dez
ano1990 26.80
ano1991 25.99
ano1992 20.08
```

```r
t(temp_mat)
```

```
    ano1990 ano1991 ano1992
Jan    25.0   24.89   23.20
Fev    23.2   24.07   26.61
Mar    22.5   23.56   18.00
Abr    21.0   23.11   23.11
Mai    19.0   18.29   26.80
Jun    17.6   18.22   21.30
Jul    18.0   16.72   18.22
Ago    19.7   19.37   21.45
Set    21.3   20.08   19.70
Out    22.0   21.45   22.50
Nov    24.0   26.61   24.07
Dez    26.8   25.99   20.08
```

```r
mel
```

```
     [,1]  [,2]  [,3]  [,4] 
[1,] "m11" "m12" "m13" "m14"
[2,] "m21" "m22" "m23" "m24"
[3,] "m31" "m32" "m33" "m34"
[4,] "m41" "m42" "m43" "m44"
```

```r
t(mel)
```

```
     [,1]  [,2]  [,3]  [,4] 
[1,] "m11" "m21" "m31" "m41"
[2,] "m12" "m22" "m32" "m42"
[3,] "m13" "m23" "m33" "m43"
[4,] "m14" "m24" "m34" "m44"
```

```r
## diagonal de mel
diag(mel)
```

```
[1] "m11" "m22" "m33" "m44"
```

### Multiplicação matricial

Operações algébricas, incluindo a multiplicação `*`, atuam elemento a elemento sobre matrizes. Mas se a intenção é fazer uma multiplicação matricial usamos o operador (`%*%`).

![](figs/multilicacaoMatricial.png "Figura 1")


```r
## multiplicação de duas matrizes
A <- matrix(c(2, 1, 4, 3, 0, 5), ncol = 2)
A
```

```
     [,1] [,2]
[1,]    2    3
[2,]    1    0
[3,]    4    5
```

```r
B <- matrix(c(3, 2, 1, 4), ncol = 2)
B
```

```
     [,1] [,2]
[1,]    3    1
[2,]    2    4
```

```r
A * B
```

```
Error in A * B: non-conformable arrays
```

```r
prodMat <- A %*% B
prodMat
```

```
     [,1] [,2]
[1,]   12   14
[2,]    3    1
[3,]   22   24
```

```r
## multiplicação de uma matriz por um escalar
m
```

```
     [,1] [,2] [,3] [,4]
[1,]    1    2    3    4
[2,]    5    6    7    8
[3,]    9   10   11   12
[4,]   13   14   15   16
```

```r
m * 2
```

```
     [,1] [,2] [,3] [,4]
[1,]    2    4    6    8
[2,]   10   12   14   16
[3,]   18   20   22   24
[4,]   26   28   30   32
```

### Adição matricial


```r
m
```

```
     [,1] [,2] [,3] [,4]
[1,]    1    2    3    4
[2,]    5    6    7    8
[3,]    9   10   11   12
[4,]   13   14   15   16
```

```r
m + m
```

```
     [,1] [,2] [,3] [,4]
[1,]    2    4    6    8
[2,]   10   12   14   16
[3,]   18   20   22   24
[4,]   26   28   30   32
```

### Produto escalar


```r
u <- 1:3
v <- c(5, 12, 13)
u * v
```

```
[1]  5 24 39
```

```r
## produto escalar = u.v = 1*5 + 2*12 + 3*13
crossprod(u, v)
```

```
     [,1]
[1,]   68
```

### Determinante


```r
## matriz exemplo
mat_ex <- matrix(c(1, -7, 3, 5, -9, 2, 6, 6, 1), ncol = 3)
det(mat_ex)
```

```
[1] 182
```

### Solução de sistemas lineares
x1 + x2 = 2

-x1 + x2 = 4

 Qual os  valores de x1 e x2?

```r
## matrizes do sistema linear
coefs <- matrix(c(1, -1, 1, 1), ncol = 2)
y <- c(2, 4)
x <- solve(coefs, y)
x
```

```
[1] -1  3
```


## Conversão de `matrix` para `vector`

Frequentemente é mais conveniente trabalhar com um vetor do que com uma matriz, por isso precisamos saber como fazer o caminho inverso. Quando criamos uma matriz (p. ex.: `temp_mat`) no início da seção ela foi baseada em um vetor (`vtemp`). Como fazemos para voltar aquele vetor original a partir da matriz?


```r
## desmanchando matrizes
mel
```

```
     [,1]  [,2]  [,3]  [,4] 
[1,] "m11" "m12" "m13" "m14"
[2,] "m21" "m22" "m23" "m24"
[3,] "m31" "m32" "m33" "m34"
[4,] "m41" "m42" "m43" "m44"
```

```r
## note as diferenças
mel[1,1]
```

```
[1] "m11"
```

```r
mel[1]
```

```
[1] "m11"
```

```r
## resulta em uma submatriz
mel[1:4, 1:4]
```

```
     [,1]  [,2]  [,3]  [,4] 
[1,] "m11" "m12" "m13" "m14"
[2,] "m21" "m22" "m23" "m24"
[3,] "m31" "m32" "m33" "m34"
[4,] "m41" "m42" "m43" "m44"
```

```r
## resulta em um vetor
mel[1:4]
```

```
[1] "m11" "m21" "m31" "m41"
```

```r
## submatriz da temp_mat
temp_mat[1:3,1:3]
```

```
          Jan   Fev   Mar
ano1990 25.00 23.20 22.50
ano1991 24.89 24.07 23.56
ano1992 23.20 26.61 18.00
```

```r
## vetor gerado de 3 elementos de mat
temp_mat[1:3]
```

```
[1] 25.00 24.89 23.20
```

```r
## numero de elementos na matriz
nel <- nrow(temp_mat)*ncol(temp_mat)
nel
```

```
[1] 36
```

```r
temp_mat[1: nrow(temp_mat)*ncol(temp_mat) ]
```

```
[1] 23.11 21.45 20.08
```

```r
## vetor de temperaturas
vtemp <- temp_mat[1:(ncol(temp_mat)*nrow(temp_mat))]
vtemp
```

```
 [1] 25.00 24.89 23.20 23.20 24.07 26.61 22.50 23.56 18.00 21.00 23.11
[12] 23.11 19.00 18.29 26.80 17.60 18.22 21.30 18.00 16.72 18.22 19.70
[23] 19.37 21.45 21.30 20.08 19.70 22.00 21.45 22.50 24.00 26.61 24.07
[34] 26.80 25.99 20.08
```

```r
## outra forma de converte temp_mat para vetor
c(temp_mat)
```

```
 [1] 25.00 24.89 23.20 23.20 24.07 26.61 22.50 23.56 18.00 21.00 23.11
[12] 23.11 19.00 18.29 26.80 17.60 18.22 21.30 18.00 16.72 18.22 19.70
[23] 19.37 21.45 21.30 20.08 19.70 22.00 21.45 22.50 24.00 26.61 24.07
[34] 26.80 25.99 20.08
```

```r
## função formal para converter 
as.vector(temp_mat)
```

```
 [1] 25.00 24.89 23.20 23.20 24.07 26.61 22.50 23.56 18.00 21.00 23.11
[12] 23.11 19.00 18.29 26.80 17.60 18.22 21.30 18.00 16.72 18.22 19.70
[23] 19.37 21.45 21.30 20.08 19.70 22.00 21.45 22.50 24.00 26.61 24.07
[34] 26.80 25.99 20.08
```

```r
## mais uma forma de converte temp_mat para vetor
array(temp_mat)
```

```
 [1] 25.00 24.89 23.20 23.20 24.07 26.61 22.50 23.56 18.00 21.00 23.11
[12] 23.11 19.00 18.29 26.80 17.60 18.22 21.30 18.00 16.72 18.22 19.70
[23] 19.37 21.45 21.30 20.08 19.70 22.00 21.45 22.50 24.00 26.61 24.07
[34] 26.80 25.99 20.08
```

```r
## para desmanchar a matriz com os elementos seguindo a ordem das linhas 
c(t(temp_mat))
```

```
 [1] 25.00 23.20 22.50 21.00 19.00 17.60 18.00 19.70 21.30 22.00 24.00
[12] 26.80 24.89 24.07 23.56 23.11 18.29 18.22 16.72 19.37 20.08 21.45
[23] 26.61 25.99 23.20 26.61 18.00 23.11 26.80 21.30 18.22 21.45 19.70
[34] 22.50 24.07 20.08
```

```r
as.vector(t(temp_mat))
```

```
 [1] 25.00 23.20 22.50 21.00 19.00 17.60 18.00 19.70 21.30 22.00 24.00
[12] 26.80 24.89 24.07 23.56 23.11 18.29 18.22 16.72 19.37 20.08 21.45
[23] 26.61 25.99 23.20 26.61 18.00 23.11 26.80 21.30 18.22 21.45 19.70
[34] 22.50 24.07 20.08
```

```r
## serie temporal de temp_mat
stemp <- c(t(temp_mat))
plot(stemp, type = "o")
```

![](figs/Chunk171-1.png)<!-- -->

```r
## criar matriz com colunas temp e meses 1:12
cbind(rep(1:12, nrow(temp_mat)),stemp)
```

```
         stemp
 [1,]  1 25.00
 [2,]  2 23.20
 [3,]  3 22.50
 [4,]  4 21.00
 [5,]  5 19.00
 [6,]  6 17.60
 [7,]  7 18.00
 [8,]  8 19.70
 [9,]  9 21.30
[10,] 10 22.00
[11,] 11 24.00
[12,] 12 26.80
[13,]  1 24.89
[14,]  2 24.07
[15,]  3 23.56
[16,]  4 23.11
[17,]  5 18.29
[18,]  6 18.22
[19,]  7 16.72
[20,]  8 19.37
[21,]  9 20.08
[22,] 10 21.45
[23,] 11 26.61
[24,] 12 25.99
[25,]  1 23.20
[26,]  2 26.61
[27,]  3 18.00
[28,]  4 23.11
[29,]  5 26.80
[30,]  6 21.30
[31,]  7 18.22
[32,]  8 21.45
[33,]  9 19.70
[34,] 10 22.50
[35,] 11 24.07
[36,] 12 20.08
```

```r
## dados de temp e meses
tempdat <- cbind(1:12, stemp)
## plot da temperatura pelos meses (os meses repetem)
plot(tempdat, 
     type = "p", ## tipo de grafico: pontos
     pch = 20,   ## codigo numérico do simbolo do ponto
     col = rep(1:3, each = ncol(temp_mat)),  ## cores dos pontos
     cex = rep(seq(1, 2 , by = 0.5), each = ncol(temp_mat)), ## aumenta tamanho dos pontos
     las = 1,   ## orientação dos labels dos eixos perpendiculares ao eixo
     ylab = expression(Tar~(degree~C)), ## label da variável y
     xlab = "meses", ## label da variavel x
     main = "Temperatura mensal (1990-1992)" ## título
    )# end plot 
```

![](figs/Chunk171-2.png)<!-- -->

```r
## para entender a variação nas cores e símbolos usadas no gráfico
cbind(meses = 1:12, temp = stemp, 
      cores = rep(1:3, each = ncol(temp_mat)), ## cores
      simb_tam = rep(seq(1, 2 , by = 0.5), each = ncol(temp_mat))
      ) ## tamanho dos símbolos 
```

```
      meses  temp cores simb_tam
 [1,]     1 25.00     1      1.0
 [2,]     2 23.20     1      1.0
 [3,]     3 22.50     1      1.0
 [4,]     4 21.00     1      1.0
 [5,]     5 19.00     1      1.0
 [6,]     6 17.60     1      1.0
 [7,]     7 18.00     1      1.0
 [8,]     8 19.70     1      1.0
 [9,]     9 21.30     1      1.0
[10,]    10 22.00     1      1.0
[11,]    11 24.00     1      1.0
[12,]    12 26.80     1      1.0
[13,]     1 24.89     2      1.5
[14,]     2 24.07     2      1.5
[15,]     3 23.56     2      1.5
[16,]     4 23.11     2      1.5
[17,]     5 18.29     2      1.5
[18,]     6 18.22     2      1.5
[19,]     7 16.72     2      1.5
[20,]     8 19.37     2      1.5
[21,]     9 20.08     2      1.5
[22,]    10 21.45     2      1.5
[23,]    11 26.61     2      1.5
[24,]    12 25.99     2      1.5
[25,]     1 23.20     3      2.0
[26,]     2 26.61     3      2.0
[27,]     3 18.00     3      2.0
[28,]     4 23.11     3      2.0
[29,]     5 26.80     3      2.0
[30,]     6 21.30     3      2.0
[31,]     7 18.22     3      2.0
[32,]     8 21.45     3      2.0
[33,]     9 19.70     3      2.0
[34,]    10 22.50     3      2.0
[35,]    11 24.07     3      2.0
[36,]    12 20.08     3      2.0
```




- - - 

# Funções utilizadas

TO DO

- `c()`





<br/>

<p style="font-family: verdana; font-size: 14px; font-style: italic; background: whitesmoke; color: black; line-height: 14px;width: 900px;">Próximo: [Manipulacao de Dados](https://rawgit.com/jdtatsch/adar-ufsm/master/6_ManipulacaoDeDados.html)</p> 



