# Programação
Jônatan Tatsch  
`r format(Sys.Date(), format = '%d-%m-%Y')`  




- - -

![](figs/adar.png)

- - -




# Introdução 

Datas e horas são referências temporais e indicam a ordem cronológica dos dados. Em climatologia dados passados na escala diária são suficientes para maioria das pesquisas. Em micrometeorologia é comum o uso de dados na escala sub-horária (até frações de segundo). 

Datas e horas podem ser expressas em diferentes formatos o que  pode dificultar o reconhecimento e a sua manipulação. Quanto a manipulação frequentemente precisamos extrair componentes das datas  e horas.

O R possui várias opções de classes de objetos e pacotes para o tratamento de datas e horas. As três classes principais são:

+ `Date` (p.ex. 31/12/2000), para lidar somente com datas, p.ex.: `31/12/2000`.

+ `POSIXct` e `POSIXt` (Date-Time), p.ex.: `31/12/2000 14:10:00`, para lidar com datas e horas

# Datas

Objeto da class `Date` são representados internamente no **R** como o número (inteiro) de dias desde 1 de janeiro de 1970. Essa classe é usada quando não temos interesse no horário do dia. Frações de dias podem ser geradas, mas nesse caso a classe POSIX é melhor nessa situação.

A função `Sys.Date()` permite-nos obter a data de hoje em um objeto da classe `Date`.


```r
## data atual no computador
(hoje <- Sys.Date())
```

```
[1] "2016-06-23"
```

```r
## classe 
class(hoje)
```

```
[1] "Date"
```

```r
typeof(hoje)
```

```
[1] "double"
```

A data parece como um caractere quando mostrada no cursor do R o seu tipo de dado é `double` e a classe `Date`.

A função `unclass()` remove o atributo classe do objeto usado como argumento. No caso de um objeto da classe `Date` ele retorna o número usado pelo sistema para representar a data.


```r
## remove o atributo classe do onjeto
ndias <- unclass(hoje)
ndias
```

```
[1] 16975
```

Para recriarmos a data de hoje:


```r
## vamos recriar a data desse dia
(as.Date(x = ndias, origin = "1970-01-01"))
```

```
[1] "2016-06-23"
```

Para reconstruirmos a data que se refere aquele número foi usada a função `as.Date()`, que converte para a classe `Date` o argumento de entrada (n° de dias decorridos) a partir da data de origem.

## Formatando datas

Podemos extrair partes ou informações de objetos na classe `Date`. Nesse caso a informação será convertida para `character`. Essas informações podem ser o ano, dia, mês, por exemplo.


```r
## qual o ano da data de hoje
format(hoje, "%Y")
```

```
[1] "2016"
```

```r
## qual o mes da data de hoje
format(hoje, "%m");format(hoje, "%b")
```

```
[1] "06"
```

```
[1] "Jun"
```

```r
## qual o dia da data de hoje
format(hoje, "%d")
```

```
[1] "23"
```

```r
## qual o dia do ano da data de hoje
format(hoje, "%j")
```

```
[1] "175"
```

Podemos manipular o formato de saída da data.


```r
format(hoje, "%d%b%Y")
```

```
[1] "23Jun2016"
```

```r
format(hoje, "%d/%m/%Y")
```

```
[1] "23/06/2016"
```

```r
format(hoje, "%d_%m_%Y.txt")
```

```
[1] "23_06_2016.txt"
```

```r
format(hoje, "Hoje é %d de %B de %Y.")
```

```
[1] "Hoje é 23 de junho de 2016."
```

Existem algumas funções prontas para extrair informações padrões, como:


```r
months(hoje)
```

```
[1] "junho"
```

```r
weekdays(hoje)
```

```
[1] "quinta"
```

O dia correspondente no calendário juliano. Para saber mais sobre dia juliano veja [aqui](http://en.wikipedia.org/wiki/Julian_day). 


```r
julian(hoje)
```

```
[1] 16975
attr(,"origin")
[1] "1970-01-01"
```

A função `format()` permite representar um objeto da classe `Date` de muitas formas. Através do seu segundo argumento é possível formatar uma data em inúmeros formatos. 
Consulte o `help` da função `strptime` para saber mais sobre estas variantes. 

- - - 


```r
help(strptime)
```

- - - 


## Conversão de caracteres para `Date`

Um procedimento mais frequente é a conversão de uma string ou caractere de um arquivo texto para um objeto da classe `Date`.


```r
# vetor de caracteres com datas
dts <-  c("2/2/2001", "04/4/2003", "03/03/2002", "5/05/2004", "1/1/2000")
datas <- as.Date(dts, format = "%d/%m/%Y")
class(datas)
```

```
[1] "Date"
```

Suponha que tivesse arquivos nomeados da seguinte forma:


```r
arqs <- format(datas, "%d%b%y.txt")
arqs
```

```
[1] "02Fev01.txt" "04Abr03.txt" "03Mar02.txt" "05Mai04.txt" "01Jan00.txt"
```

```r
# obter datas a partir do nome dos arquivos
as.Date(arqs, "%d%b%y.txt")
```

```
[1] "2001-02-02" "2003-04-04" "2002-03-03" "2004-05-05" "2000-01-01"
```

```r
## ordenar os arquivos pela data
arqs_dates <- as.Date(arqs, "%d%b%y.txt")
arqs[order(arqs_dates)]
```

```
[1] "01Jan00.txt" "02Fev01.txt" "03Mar02.txt" "04Abr03.txt" "05Mai04.txt"
```

Vamos criar um data frame com informações de ano, mês e dia e então convertê-las em um objeto da classe `Date`.


```r
eg <- expand.grid(dias = 1:31, mes = 1:12 ,anos = 2000:2001)
head(eg)
```

```
  dias mes anos
1    1   1 2000
2    2   1 2000
3    3   1 2000
4    4   1 2000
5    5   1 2000
6    6   1 2000
```

```r
tail(eg)
```

```
    dias mes anos
739   26  12 2001
740   27  12 2001
741   28  12 2001
742   29  12 2001
743   30  12 2001
744   31  12 2001
```

```r
char_dates <- paste(eg$anos,  eg$mes, eg$dias, sep = "-")
head(char_dates)
```

```
[1] "2000-1-1" "2000-1-2" "2000-1-3" "2000-1-4" "2000-1-5" "2000-1-6"
```

```r
datas_eg <- as.Date(char_dates)
class(datas_eg)
```

```
[1] "Date"
```

```r
# foram criados NAs, pq?
datas_eg[55:70]
```

```
 [1] "2000-02-24" "2000-02-25" "2000-02-26" "2000-02-27" "2000-02-28"
 [6] "2000-02-29" NA           NA           "2000-03-01" "2000-03-02"
[11] "2000-03-03" "2000-03-04" "2000-03-05" "2000-03-06" "2000-03-07"
[16] "2000-03-08"
```

```r
head(datas_eg)
```

```
[1] "2000-01-01" "2000-01-02" "2000-01-03" "2000-01-04" "2000-01-05"
[6] "2000-01-06"
```

```r
tail(datas_eg)
```

```
[1] "2001-12-26" "2001-12-27" "2001-12-28" "2001-12-29" "2001-12-30"
[6] "2001-12-31"
```

```r
## removendo datas inexistentes
datas_eg_ok <- datas_eg[!is.na(datas_eg)]
head(datas_eg_ok, 10)
```

```
 [1] "2000-01-01" "2000-01-02" "2000-01-03" "2000-01-04" "2000-01-05"
 [6] "2000-01-06" "2000-01-07" "2000-01-08" "2000-01-09" "2000-01-10"
```

## Sequência de datas


```r
# sequencia de datas diarias
datas_1d <- seq(from = as.Date("2000-01-01"), as.Date("2001-12-31"), by = "days")
head(datas_1d, 32)
```

```
 [1] "2000-01-01" "2000-01-02" "2000-01-03" "2000-01-04" "2000-01-05"
 [6] "2000-01-06" "2000-01-07" "2000-01-08" "2000-01-09" "2000-01-10"
[11] "2000-01-11" "2000-01-12" "2000-01-13" "2000-01-14" "2000-01-15"
[16] "2000-01-16" "2000-01-17" "2000-01-18" "2000-01-19" "2000-01-20"
[21] "2000-01-21" "2000-01-22" "2000-01-23" "2000-01-24" "2000-01-25"
[26] "2000-01-26" "2000-01-27" "2000-01-28" "2000-01-29" "2000-01-30"
[31] "2000-01-31" "2000-02-01"
```

```r
tail(datas_1d, 32)
```

```
 [1] "2001-11-30" "2001-12-01" "2001-12-02" "2001-12-03" "2001-12-04"
 [6] "2001-12-05" "2001-12-06" "2001-12-07" "2001-12-08" "2001-12-09"
[11] "2001-12-10" "2001-12-11" "2001-12-12" "2001-12-13" "2001-12-14"
[16] "2001-12-15" "2001-12-16" "2001-12-17" "2001-12-18" "2001-12-19"
[21] "2001-12-20" "2001-12-21" "2001-12-22" "2001-12-23" "2001-12-24"
[26] "2001-12-25" "2001-12-26" "2001-12-27" "2001-12-28" "2001-12-29"
[31] "2001-12-30" "2001-12-31"
```

```r
# quantos dias por mês em cada ano
table(format(datas_1d, "%m"), format(datas_1d, "%Y"))
```

```
    
     2000 2001
  01   31   31
  02   29   28
  03   31   31
  04   30   30
  05   31   31
  06   30   30
  07   31   31
  08   31   31
  09   30   30
  10   31   31
  11   30   30
  12   31   31
```

```r
# quantos dias por ano
table(format(datas_1d, "%Y"))
```

```

2000 2001 
 366  365 
```

```r
## sequencia de pentadas
pentadas <- seq(from = as.Date("2000-01-01"), as.Date("2001-12-31"), by = "5 days")
pentadas
```

```
  [1] "2000-01-01" "2000-01-06" "2000-01-11" "2000-01-16" "2000-01-21"
  [6] "2000-01-26" "2000-01-31" "2000-02-05" "2000-02-10" "2000-02-15"
 [11] "2000-02-20" "2000-02-25" "2000-03-01" "2000-03-06" "2000-03-11"
 [16] "2000-03-16" "2000-03-21" "2000-03-26" "2000-03-31" "2000-04-05"
 [21] "2000-04-10" "2000-04-15" "2000-04-20" "2000-04-25" "2000-04-30"
 [26] "2000-05-05" "2000-05-10" "2000-05-15" "2000-05-20" "2000-05-25"
 [31] "2000-05-30" "2000-06-04" "2000-06-09" "2000-06-14" "2000-06-19"
 [36] "2000-06-24" "2000-06-29" "2000-07-04" "2000-07-09" "2000-07-14"
 [41] "2000-07-19" "2000-07-24" "2000-07-29" "2000-08-03" "2000-08-08"
 [46] "2000-08-13" "2000-08-18" "2000-08-23" "2000-08-28" "2000-09-02"
 [51] "2000-09-07" "2000-09-12" "2000-09-17" "2000-09-22" "2000-09-27"
 [56] "2000-10-02" "2000-10-07" "2000-10-12" "2000-10-17" "2000-10-22"
 [61] "2000-10-27" "2000-11-01" "2000-11-06" "2000-11-11" "2000-11-16"
 [66] "2000-11-21" "2000-11-26" "2000-12-01" "2000-12-06" "2000-12-11"
 [71] "2000-12-16" "2000-12-21" "2000-12-26" "2000-12-31" "2001-01-05"
 [76] "2001-01-10" "2001-01-15" "2001-01-20" "2001-01-25" "2001-01-30"
 [81] "2001-02-04" "2001-02-09" "2001-02-14" "2001-02-19" "2001-02-24"
 [86] "2001-03-01" "2001-03-06" "2001-03-11" "2001-03-16" "2001-03-21"
 [91] "2001-03-26" "2001-03-31" "2001-04-05" "2001-04-10" "2001-04-15"
 [96] "2001-04-20" "2001-04-25" "2001-04-30" "2001-05-05" "2001-05-10"
[101] "2001-05-15" "2001-05-20" "2001-05-25" "2001-05-30" "2001-06-04"
[106] "2001-06-09" "2001-06-14" "2001-06-19" "2001-06-24" "2001-06-29"
[111] "2001-07-04" "2001-07-09" "2001-07-14" "2001-07-19" "2001-07-24"
[116] "2001-07-29" "2001-08-03" "2001-08-08" "2001-08-13" "2001-08-18"
[121] "2001-08-23" "2001-08-28" "2001-09-02" "2001-09-07" "2001-09-12"
[126] "2001-09-17" "2001-09-22" "2001-09-27" "2001-10-02" "2001-10-07"
[131] "2001-10-12" "2001-10-17" "2001-10-22" "2001-10-27" "2001-11-01"
[136] "2001-11-06" "2001-11-11" "2001-11-16" "2001-11-21" "2001-11-26"
[141] "2001-12-01" "2001-12-06" "2001-12-11" "2001-12-16" "2001-12-21"
[146] "2001-12-26" "2001-12-31"
```

```r
length(pentadas)
```

```
[1] 147
```

```r
## quantas pentadas por ano
table(format(pentadas, "%Y"))
```

```

2000 2001 
  74   73 
```

```r
# quantas pentadas por mês e ano
table(format(pentadas, "%Y"), format(pentadas, "%m"))
```

```
      
       01 02 03 04 05 06 07 08 09 10 11 12
  2000  7  5  7  6  6  6  6  6  6  6  6  7
  2001  6  5  7  6  6  6  6  6  6  6  6  7
```

```r
## sequencia de meses
datas_15s <- seq(from = as.Date("2000-01-15"), as.Date("2001-12-15"), by = "months")
datas_15s
```

```
 [1] "2000-01-15" "2000-02-15" "2000-03-15" "2000-04-15" "2000-05-15"
 [6] "2000-06-15" "2000-07-15" "2000-08-15" "2000-09-15" "2000-10-15"
[11] "2000-11-15" "2000-12-15" "2001-01-15" "2001-02-15" "2001-03-15"
[16] "2001-04-15" "2001-05-15" "2001-06-15" "2001-07-15" "2001-08-15"
[21] "2001-09-15" "2001-10-15" "2001-11-15" "2001-12-15"
```

## Operações aritméticas


```r
## diferença enre datas
as.Date("2006-9-23") - as.Date("2003-04-30")
```

```
Time difference of 1242 days
```

```r
## diferença entre cada dia de um vetor de datas
diff(pentadas)
```

```
Time differences in days
  [1] 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
 [36] 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
 [71] 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
[106] 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
[141] 5 5 5 5 5 5
```

```r
## útil para verificação de continuidade temporal
datas_irreg <- datas_1d[-c(10, 100, 201, 303, 405, 506)]
difs <- diff(datas_irreg)
difs
```

```
Time differences in days
  [1] 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
 [36] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
 [71] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1
[106] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[141] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[176] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1
[211] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[246] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[281] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[316] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[351] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[386] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[421] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[456] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[491] 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[526] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[561] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[596] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[631] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[666] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[701] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
```

```r
## encontrado datas descontínuas
datas_irreg[c(1, difs) == 2]
```

```
[1] "2000-01-11" "2000-04-10" "2000-07-20" "2000-10-30" "2001-02-09"
[6] "2001-05-21"
```

```r
## só os primeiros 203 elementos
df <- data.frame(d = datas_irreg[1:203], i = (c(1, difs) == 2)[1:203])
df
```

```
             d     i
1   2000-01-01 FALSE
2   2000-01-02 FALSE
3   2000-01-03 FALSE
4   2000-01-04 FALSE
5   2000-01-05 FALSE
6   2000-01-06 FALSE
7   2000-01-07 FALSE
8   2000-01-08 FALSE
9   2000-01-09 FALSE
10  2000-01-11  TRUE
11  2000-01-12 FALSE
12  2000-01-13 FALSE
13  2000-01-14 FALSE
14  2000-01-15 FALSE
15  2000-01-16 FALSE
16  2000-01-17 FALSE
17  2000-01-18 FALSE
18  2000-01-19 FALSE
19  2000-01-20 FALSE
20  2000-01-21 FALSE
21  2000-01-22 FALSE
22  2000-01-23 FALSE
23  2000-01-24 FALSE
24  2000-01-25 FALSE
25  2000-01-26 FALSE
26  2000-01-27 FALSE
27  2000-01-28 FALSE
28  2000-01-29 FALSE
29  2000-01-30 FALSE
30  2000-01-31 FALSE
31  2000-02-01 FALSE
32  2000-02-02 FALSE
33  2000-02-03 FALSE
34  2000-02-04 FALSE
35  2000-02-05 FALSE
36  2000-02-06 FALSE
37  2000-02-07 FALSE
38  2000-02-08 FALSE
39  2000-02-09 FALSE
40  2000-02-10 FALSE
41  2000-02-11 FALSE
42  2000-02-12 FALSE
43  2000-02-13 FALSE
44  2000-02-14 FALSE
45  2000-02-15 FALSE
46  2000-02-16 FALSE
47  2000-02-17 FALSE
48  2000-02-18 FALSE
49  2000-02-19 FALSE
50  2000-02-20 FALSE
51  2000-02-21 FALSE
52  2000-02-22 FALSE
53  2000-02-23 FALSE
54  2000-02-24 FALSE
55  2000-02-25 FALSE
56  2000-02-26 FALSE
57  2000-02-27 FALSE
58  2000-02-28 FALSE
59  2000-02-29 FALSE
60  2000-03-01 FALSE
61  2000-03-02 FALSE
62  2000-03-03 FALSE
63  2000-03-04 FALSE
64  2000-03-05 FALSE
65  2000-03-06 FALSE
66  2000-03-07 FALSE
67  2000-03-08 FALSE
68  2000-03-09 FALSE
69  2000-03-10 FALSE
70  2000-03-11 FALSE
71  2000-03-12 FALSE
72  2000-03-13 FALSE
73  2000-03-14 FALSE
74  2000-03-15 FALSE
75  2000-03-16 FALSE
76  2000-03-17 FALSE
77  2000-03-18 FALSE
78  2000-03-19 FALSE
79  2000-03-20 FALSE
80  2000-03-21 FALSE
81  2000-03-22 FALSE
82  2000-03-23 FALSE
83  2000-03-24 FALSE
84  2000-03-25 FALSE
85  2000-03-26 FALSE
86  2000-03-27 FALSE
87  2000-03-28 FALSE
88  2000-03-29 FALSE
89  2000-03-30 FALSE
90  2000-03-31 FALSE
91  2000-04-01 FALSE
92  2000-04-02 FALSE
93  2000-04-03 FALSE
94  2000-04-04 FALSE
95  2000-04-05 FALSE
96  2000-04-06 FALSE
97  2000-04-07 FALSE
98  2000-04-08 FALSE
99  2000-04-10  TRUE
100 2000-04-11 FALSE
101 2000-04-12 FALSE
102 2000-04-13 FALSE
103 2000-04-14 FALSE
104 2000-04-15 FALSE
105 2000-04-16 FALSE
106 2000-04-17 FALSE
107 2000-04-18 FALSE
108 2000-04-19 FALSE
109 2000-04-20 FALSE
110 2000-04-21 FALSE
111 2000-04-22 FALSE
112 2000-04-23 FALSE
113 2000-04-24 FALSE
114 2000-04-25 FALSE
115 2000-04-26 FALSE
116 2000-04-27 FALSE
117 2000-04-28 FALSE
118 2000-04-29 FALSE
119 2000-04-30 FALSE
120 2000-05-01 FALSE
121 2000-05-02 FALSE
122 2000-05-03 FALSE
123 2000-05-04 FALSE
124 2000-05-05 FALSE
125 2000-05-06 FALSE
126 2000-05-07 FALSE
127 2000-05-08 FALSE
128 2000-05-09 FALSE
129 2000-05-10 FALSE
130 2000-05-11 FALSE
131 2000-05-12 FALSE
132 2000-05-13 FALSE
133 2000-05-14 FALSE
134 2000-05-15 FALSE
135 2000-05-16 FALSE
136 2000-05-17 FALSE
137 2000-05-18 FALSE
138 2000-05-19 FALSE
139 2000-05-20 FALSE
140 2000-05-21 FALSE
141 2000-05-22 FALSE
142 2000-05-23 FALSE
143 2000-05-24 FALSE
144 2000-05-25 FALSE
145 2000-05-26 FALSE
146 2000-05-27 FALSE
147 2000-05-28 FALSE
148 2000-05-29 FALSE
149 2000-05-30 FALSE
150 2000-05-31 FALSE
151 2000-06-01 FALSE
152 2000-06-02 FALSE
153 2000-06-03 FALSE
154 2000-06-04 FALSE
155 2000-06-05 FALSE
156 2000-06-06 FALSE
157 2000-06-07 FALSE
158 2000-06-08 FALSE
159 2000-06-09 FALSE
160 2000-06-10 FALSE
161 2000-06-11 FALSE
162 2000-06-12 FALSE
163 2000-06-13 FALSE
164 2000-06-14 FALSE
165 2000-06-15 FALSE
166 2000-06-16 FALSE
167 2000-06-17 FALSE
168 2000-06-18 FALSE
169 2000-06-19 FALSE
170 2000-06-20 FALSE
171 2000-06-21 FALSE
172 2000-06-22 FALSE
173 2000-06-23 FALSE
174 2000-06-24 FALSE
175 2000-06-25 FALSE
176 2000-06-26 FALSE
177 2000-06-27 FALSE
178 2000-06-28 FALSE
179 2000-06-29 FALSE
180 2000-06-30 FALSE
181 2000-07-01 FALSE
182 2000-07-02 FALSE
183 2000-07-03 FALSE
184 2000-07-04 FALSE
185 2000-07-05 FALSE
186 2000-07-06 FALSE
187 2000-07-07 FALSE
188 2000-07-08 FALSE
189 2000-07-09 FALSE
190 2000-07-10 FALSE
191 2000-07-11 FALSE
192 2000-07-12 FALSE
193 2000-07-13 FALSE
194 2000-07-14 FALSE
195 2000-07-15 FALSE
196 2000-07-16 FALSE
197 2000-07-17 FALSE
198 2000-07-18 FALSE
199 2000-07-20  TRUE
200 2000-07-21 FALSE
201 2000-07-22 FALSE
202 2000-07-23 FALSE
203 2000-07-24 FALSE
```

```r
## quantos dias por semana há na série de datas
table(cut(datas_irreg, "weeks"))
```

```

1999-12-27 2000-01-03 2000-01-10 2000-01-17 2000-01-24 2000-01-31 
         2          7          6          7          7          7 
2000-02-07 2000-02-14 2000-02-21 2000-02-28 2000-03-06 2000-03-13 
         7          7          7          7          7          7 
2000-03-20 2000-03-27 2000-04-03 2000-04-10 2000-04-17 2000-04-24 
         7          7          6          7          7          7 
2000-05-01 2000-05-08 2000-05-15 2000-05-22 2000-05-29 2000-06-05 
         7          7          7          7          7          7 
2000-06-12 2000-06-19 2000-06-26 2000-07-03 2000-07-10 2000-07-17 
         7          7          7          7          7          6 
2000-07-24 2000-07-31 2000-08-07 2000-08-14 2000-08-21 2000-08-28 
         7          7          7          7          7          7 
2000-09-04 2000-09-11 2000-09-18 2000-09-25 2000-10-02 2000-10-09 
         7          7          7          7          7          7 
2000-10-16 2000-10-23 2000-10-30 2000-11-06 2000-11-13 2000-11-20 
         7          6          7          7          7          7 
2000-11-27 2000-12-04 2000-12-11 2000-12-18 2000-12-25 2001-01-01 
         7          7          7          7          7          7 
2001-01-08 2001-01-15 2001-01-22 2001-01-29 2001-02-05 2001-02-12 
         7          7          7          7          6          7 
2001-02-19 2001-02-26 2001-03-05 2001-03-12 2001-03-19 2001-03-26 
         7          7          7          7          7          7 
2001-04-02 2001-04-09 2001-04-16 2001-04-23 2001-04-30 2001-05-07 
         7          7          7          7          7          7 
2001-05-14 2001-05-21 2001-05-28 2001-06-04 2001-06-11 2001-06-18 
         6          7          7          7          7          7 
2001-06-25 2001-07-02 2001-07-09 2001-07-16 2001-07-23 2001-07-30 
         7          7          7          7          7          7 
2001-08-06 2001-08-13 2001-08-20 2001-08-27 2001-09-03 2001-09-10 
         7          7          7          7          7          7 
2001-09-17 2001-09-24 2001-10-01 2001-10-08 2001-10-15 2001-10-22 
         7          7          7          7          7          7 
2001-10-29 2001-11-05 2001-11-12 2001-11-19 2001-11-26 2001-12-03 
         7          7          7          7          7          7 
2001-12-10 2001-12-17 2001-12-24 2001-12-31 
         7          7          7          1 
```

```r
## dias por mes
table(cut(pentadas, "month"))
```

```

2000-01-01 2000-02-01 2000-03-01 2000-04-01 2000-05-01 2000-06-01 
         7          5          7          6          6          6 
2000-07-01 2000-08-01 2000-09-01 2000-10-01 2000-11-01 2000-12-01 
         6          6          6          6          6          7 
2001-01-01 2001-02-01 2001-03-01 2001-04-01 2001-05-01 2001-06-01 
         6          5          7          6          6          6 
2001-07-01 2001-08-01 2001-09-01 2001-10-01 2001-11-01 2001-12-01 
         6          6          6          6          6          7 
```

# Datas e horas

Este tipo de objeto permite guardar registros temporais com informação sobre a data, como os anteriores, mas também sobre as horas, minutos e segundos. Existem duas sub-classes de `POSIXt`:

+ `POSIXct` que representam as datas como o número de segundos que passaram
desde 1970.

+ `POSIXlt` que representam as datas como uma lista com várias componentes,
como: `sec`, `min`, `hour`, `mday`, `mon`, `year` e etc.

A função `Sys.time()` obtém a data/hora atual no computador num objeto do
tipo `POSIXt`.


```r
## data e hora atual informada pelo sistema
dt <- Sys.time()
dt
```

```
[1] "2016-06-23 20:38:43 GMT"
```

```r
## numero de segundos desde 1970
unclass(dt)
```

```
[1] 1466714323
```

```r
## mostrando número preservando o formato inteiro 
print(unclass(dt), digits = 10)
```

```
[1] 1466714323
```

A função `as.POSIXlt()` pode ser usada para converter diferentes
objetos para a classe `POSIXlt`. Vamos também converter a data e hora para outro fuso horário.


```r
# definindo globalmente tz = "GMT" 
# evita de ter que estar especificando tz = "GMT"
# Sys.setenv(TZ = 'GMT')
dt_lt <- as.POSIXlt(Sys.time(), tz = "GMT")
dt_lt
```

```
[1] "2016-06-23 20:38:43 GMT"
```

```r
as.POSIXlt(Sys.time(), tz = "UTC")
```

```
[1] "2016-06-23 20:38:43 UTC"
```

```r
class(dt_lt)
```

```
[1] "POSIXlt" "POSIXt" 
```

```r
## qual fuso horário indicado pelo sistema operacional
Sys.timezone()
```

```
[1] "GMT"
```

Que horas corresponde esse horário em Londres?
Para detalhes sobre as  strings usadas para  os fusos horários veja [aqui](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).



```r
as.POSIXlt(Sys.time(), tz = "Europe/London")
```

```
[1] "2016-06-23 21:38:43 BST"
```

```r
as.POSIXlt(Sys.time(), tz = "America/Los_Angeles")
```

```
[1] "2016-06-23 13:38:43 PDT"
```

Uma lista com nomes dos fusos horários por continente/cidade ? fornecido pela função `OlsonNames()`.



```r
OlsonNames()[56:190]
```

```
  [1] "America/Anchorage"                "America/Anguilla"                
  [3] "America/Antigua"                  "America/Araguaina"               
  [5] "America/Argentina/Buenos_Aires"   "America/Argentina/Catamarca"     
  [7] "America/Argentina/ComodRivadavia" "America/Argentina/Cordoba"       
  [9] "America/Argentina/Jujuy"          "America/Argentina/La_Rioja"      
 [11] "America/Argentina/Mendoza"        "America/Argentina/Rio_Gallegos"  
 [13] "America/Argentina/Salta"          "America/Argentina/San_Juan"      
 [15] "America/Argentina/San_Luis"       "America/Argentina/Tucuman"       
 [17] "America/Argentina/Ushuaia"        "America/Aruba"                   
 [19] "America/Asuncion"                 "America/Atikokan"                
 [21] "America/Atka"                     "America/Bahia"                   
 [23] "America/Bahia_Banderas"           "America/Barbados"                
 [25] "America/Belem"                    "America/Belize"                  
 [27] "America/Blanc-Sablon"             "America/Boa_Vista"               
 [29] "America/Bogota"                   "America/Boise"                   
 [31] "America/Buenos_Aires"             "America/Cambridge_Bay"           
 [33] "America/Campo_Grande"             "America/Cancun"                  
 [35] "America/Caracas"                  "America/Catamarca"               
 [37] "America/Cayenne"                  "America/Cayman"                  
 [39] "America/Chicago"                  "America/Chihuahua"               
 [41] "America/Coral_Harbour"            "America/Cordoba"                 
 [43] "America/Costa_Rica"               "America/Creston"                 
 [45] "America/Cuiaba"                   "America/Curacao"                 
 [47] "America/Danmarkshavn"             "America/Dawson"                  
 [49] "America/Dawson_Creek"             "America/Denver"                  
 [51] "America/Detroit"                  "America/Dominica"                
 [53] "America/Edmonton"                 "America/Eirunepe"                
 [55] "America/El_Salvador"              "America/Ensenada"                
 [57] "America/Fortaleza"                "America/Fort_Nelson"             
 [59] "America/Fort_Wayne"               "America/Glace_Bay"               
 [61] "America/Godthab"                  "America/Goose_Bay"               
 [63] "America/Grand_Turk"               "America/Grenada"                 
 [65] "America/Guadeloupe"               "America/Guatemala"               
 [67] "America/Guayaquil"                "America/Guyana"                  
 [69] "America/Halifax"                  "America/Havana"                  
 [71] "America/Hermosillo"               "America/Indiana/Indianapolis"    
 [73] "America/Indiana/Knox"             "America/Indiana/Marengo"         
 [75] "America/Indiana/Petersburg"       "America/Indianapolis"            
 [77] "America/Indiana/Tell_City"        "America/Indiana/Vevay"           
 [79] "America/Indiana/Vincennes"        "America/Indiana/Winamac"         
 [81] "America/Inuvik"                   "America/Iqaluit"                 
 [83] "America/Jamaica"                  "America/Jujuy"                   
 [85] "America/Juneau"                   "America/Kentucky/Louisville"     
 [87] "America/Kentucky/Monticello"      "America/Knox_IN"                 
 [89] "America/Kralendijk"               "America/La_Paz"                  
 [91] "America/Lima"                     "America/Los_Angeles"             
 [93] "America/Louisville"               "America/Lower_Princes"           
 [95] "America/Maceio"                   "America/Managua"                 
 [97] "America/Manaus"                   "America/Marigot"                 
 [99] "America/Martinique"               "America/Matamoros"               
[101] "America/Mazatlan"                 "America/Mendoza"                 
[103] "America/Menominee"                "America/Merida"                  
[105] "America/Metlakatla"               "America/Mexico_City"             
[107] "America/Miquelon"                 "America/Moncton"                 
[109] "America/Monterrey"                "America/Montevideo"              
[111] "America/Montreal"                 "America/Montserrat"              
[113] "America/Nassau"                   "America/New_York"                
[115] "America/Nipigon"                  "America/Nome"                    
[117] "America/Noronha"                  "America/North_Dakota/Beulah"     
[119] "America/North_Dakota/Center"      "America/North_Dakota/New_Salem"  
[121] "America/Ojinaga"                  "America/Panama"                  
[123] "America/Pangnirtung"              "America/Paramaribo"              
[125] "America/Phoenix"                  "America/Port-au-Prince"          
[127] "America/Porto_Acre"               "America/Port_of_Spain"           
[129] "America/Porto_Velho"              "America/Puerto_Rico"             
[131] "America/Rainy_River"              "America/Rankin_Inlet"            
[133] "America/Recife"                   "America/Regina"                  
[135] "America/Resolute"                
```

Convertendo para POSIXct para determinar intervalos de tempo.


```r
as.POSIXct("2006-12-23 12:45") - as.POSIXct("2006-12-21 21:54")
```

```
Time difference of 1.61875 days
```

Qual a hora à 3 horas atrás?


```r
as.POSIXct("2006-12-23 12:45") - 3600*3 
```

```
[1] "2006-12-23 09:45:00 GMT"
```

A função `format()` que já vimos anteriormente, funciona também para objetos `POSIXt`.


```r
format(Sys.time(), "%a %b %d %X %Y %Z")
```

```
[1] "Qui Jun 23 20:38:43 2016 GMT"
```

Ao importar dados que envolvem datas geralmente recebemos essas datas como strings ou `character`, e portanto temos que extrair dessas strings as nossas datas/horas. Entretanto não existe uma padrão seguido por todos para representar datas. 
Por isso usamos a função `strptime()` que pode ser usada para extrair datas/horas de strings indicando o formato em que essas datas/horas estão representadas nas *strings*. Isso é feito através do segundo argumento da função que usa um conjunto de códigos com vários significados, análogo ao que vimos na função `format()`. Para mais detalhes sobre estes códigos veja o help da função.

**Note que a função `format()` é usado para conversão de `POSIXt` ou `Date` para caractere. A `strptime()` converte vetores caracteres para classe `POSIXlt`.**


```r
## vetor de caracteres com informação de data
x <- c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
strptime(x, format = "%d%b%Y")
```

```
[1] "1960-01-01 GMT" "1960-01-02 GMT" "1960-03-31 GMT" "1960-07-30 GMT"
```

```r
## vetores caracteres com informações de data e hora 
datas <- c("02/27/92", "02/27/92", "01/14/92", "02/28/92", "02/01/92")
horas <- c("23:03:20", "22:29:56", "01:03:30", "18:21:03", "16:56:26")
## convertendo para formato padrão de data e hora do POSIXt
x <- paste(datas, horas, sep = " ")
x_pxlt <- strptime(x, "%m/%d/%y %H:%M:%S", tz = "GMT")
x_pxlt
```

```
[1] "1992-02-27 23:03:20 GMT" "1992-02-27 22:29:56 GMT"
[3] "1992-01-14 01:03:30 GMT" "1992-02-28 18:21:03 GMT"
[5] "1992-02-01 16:56:26 GMT"
```

```r
str(x_pxlt)
```

```
 POSIXlt[1:5], format: "1992-02-27 23:03:20" "1992-02-27 22:29:56" ...
```

```r
## mesma operação usando as.POSIXct
x_pxct <- as.POSIXct(x, format = "%m/%d/%y %H:%M:%S", tz = "GMT")
x_pxct
```

```
[1] "1992-02-27 23:03:20 GMT" "1992-02-27 22:29:56 GMT"
[3] "1992-01-14 01:03:30 GMT" "1992-02-28 18:21:03 GMT"
[5] "1992-02-01 16:56:26 GMT"
```

```r
str(x_pxct)
```

```
 POSIXct[1:5], format: "1992-02-27 23:03:20" "1992-02-27 22:29:56" ...
```

```r
## extrair horas minutos e segundos
require(chron) # se não tiver instalado: install.packages("chron")
minutes(x_pxct)
```

```
[1]  3 29  3 21 56
```

```r
hours(x_pxct)
```

```
[1] 23 22  1 18 16
```

```r
seconds(x_pxct)
```

```
[1] 20 56 30  3 26
```

```r
months(x_pxct)
```

```
[1] "fevereiro" "fevereiro" "janeiro"   "fevereiro" "fevereiro"
```

```r
days(x_pxct)
```

```
[1] 27 27 14 28 1 
31 Levels: 1 < 2 < 3 < 4 < 5 < 6 < 7 < 8 < 9 < 10 < 11 < 12 < ... < 31
```

```r
years(x_pxct)
```

```
[1] 1992 1992 1992 1992 1992
Levels: 1992
```

```r
## convertendo datas e horas de caracteres para POSIXct
eg <- expand.grid(minutos = c(0,30),
                  horas = 0:23, 
                  dias = 1:10, 
                  mes = 7 ,
                  anos = 2000)
head(eg, 20)
```

```
   minutos horas dias mes anos
1        0     0    1   7 2000
2       30     0    1   7 2000
3        0     1    1   7 2000
4       30     1    1   7 2000
5        0     2    1   7 2000
6       30     2    1   7 2000
7        0     3    1   7 2000
8       30     3    1   7 2000
9        0     4    1   7 2000
10      30     4    1   7 2000
11       0     5    1   7 2000
12      30     5    1   7 2000
13       0     6    1   7 2000
14      30     6    1   7 2000
15       0     7    1   7 2000
16      30     7    1   7 2000
17       0     8    1   7 2000
18      30     8    1   7 2000
19       0     9    1   7 2000
20      30     9    1   7 2000
```

```r
dth <- do.call("paste", c(eg, sep = " ")) 
head(dth, 20)
```

```
 [1] "0 0 1 7 2000"  "30 0 1 7 2000" "0 1 1 7 2000"  "30 1 1 7 2000"
 [5] "0 2 1 7 2000"  "30 2 1 7 2000" "0 3 1 7 2000"  "30 3 1 7 2000"
 [9] "0 4 1 7 2000"  "30 4 1 7 2000" "0 5 1 7 2000"  "30 5 1 7 2000"
[13] "0 6 1 7 2000"  "30 6 1 7 2000" "0 7 1 7 2000"  "30 7 1 7 2000"
[17] "0 8 1 7 2000"  "30 8 1 7 2000" "0 9 1 7 2000"  "30 9 1 7 2000"
```

```r
dth_psxct <- as.POSIXct(dth, format = "%M %H %d %m %Y", tz = "GMT")
head(dth_psxct, 20)
```

```
 [1] "2000-07-01 00:00:00 GMT" "2000-07-01 00:30:00 GMT"
 [3] "2000-07-01 01:00:00 GMT" "2000-07-01 01:30:00 GMT"
 [5] "2000-07-01 02:00:00 GMT" "2000-07-01 02:30:00 GMT"
 [7] "2000-07-01 03:00:00 GMT" "2000-07-01 03:30:00 GMT"
 [9] "2000-07-01 04:00:00 GMT" "2000-07-01 04:30:00 GMT"
[11] "2000-07-01 05:00:00 GMT" "2000-07-01 05:30:00 GMT"
[13] "2000-07-01 06:00:00 GMT" "2000-07-01 06:30:00 GMT"
[15] "2000-07-01 07:00:00 GMT" "2000-07-01 07:30:00 GMT"
[17] "2000-07-01 08:00:00 GMT" "2000-07-01 08:30:00 GMT"
[19] "2000-07-01 09:00:00 GMT" "2000-07-01 09:30:00 GMT"
```

```r
## intervalo de variação
range(dth_psxct)
```

```
[1] "2000-07-01 00:00:00 GMT" "2000-07-10 23:30:00 GMT"
```

```r
## convertendo de POSIXct para Date
dth_psxct_date <- as.Date(dth_psxct)
head(dth_psxct_date, 20)
```

```
 [1] "2000-07-01" "2000-07-01" "2000-07-01" "2000-07-01" "2000-07-01"
 [6] "2000-07-01" "2000-07-01" "2000-07-01" "2000-07-01" "2000-07-01"
[11] "2000-07-01" "2000-07-01" "2000-07-01" "2000-07-01" "2000-07-01"
[16] "2000-07-01" "2000-07-01" "2000-07-01" "2000-07-01" "2000-07-01"
```

## Sequência de datas e horas


```r
## sequencia de datas de meia-hora
dhh <- seq(from = as.POSIXct("2000-01-01 01:30:00", tz = "GMT"),
             to = as.POSIXct("2001-12-31 02:30:00", tz = "GMT"), 
             by = "30 min")
head(dhh, 100)
```

```
  [1] "2000-01-01 01:30:00 GMT" "2000-01-01 02:00:00 GMT"
  [3] "2000-01-01 02:30:00 GMT" "2000-01-01 03:00:00 GMT"
  [5] "2000-01-01 03:30:00 GMT" "2000-01-01 04:00:00 GMT"
  [7] "2000-01-01 04:30:00 GMT" "2000-01-01 05:00:00 GMT"
  [9] "2000-01-01 05:30:00 GMT" "2000-01-01 06:00:00 GMT"
 [11] "2000-01-01 06:30:00 GMT" "2000-01-01 07:00:00 GMT"
 [13] "2000-01-01 07:30:00 GMT" "2000-01-01 08:00:00 GMT"
 [15] "2000-01-01 08:30:00 GMT" "2000-01-01 09:00:00 GMT"
 [17] "2000-01-01 09:30:00 GMT" "2000-01-01 10:00:00 GMT"
 [19] "2000-01-01 10:30:00 GMT" "2000-01-01 11:00:00 GMT"
 [21] "2000-01-01 11:30:00 GMT" "2000-01-01 12:00:00 GMT"
 [23] "2000-01-01 12:30:00 GMT" "2000-01-01 13:00:00 GMT"
 [25] "2000-01-01 13:30:00 GMT" "2000-01-01 14:00:00 GMT"
 [27] "2000-01-01 14:30:00 GMT" "2000-01-01 15:00:00 GMT"
 [29] "2000-01-01 15:30:00 GMT" "2000-01-01 16:00:00 GMT"
 [31] "2000-01-01 16:30:00 GMT" "2000-01-01 17:00:00 GMT"
 [33] "2000-01-01 17:30:00 GMT" "2000-01-01 18:00:00 GMT"
 [35] "2000-01-01 18:30:00 GMT" "2000-01-01 19:00:00 GMT"
 [37] "2000-01-01 19:30:00 GMT" "2000-01-01 20:00:00 GMT"
 [39] "2000-01-01 20:30:00 GMT" "2000-01-01 21:00:00 GMT"
 [41] "2000-01-01 21:30:00 GMT" "2000-01-01 22:00:00 GMT"
 [43] "2000-01-01 22:30:00 GMT" "2000-01-01 23:00:00 GMT"
 [45] "2000-01-01 23:30:00 GMT" "2000-01-02 00:00:00 GMT"
 [47] "2000-01-02 00:30:00 GMT" "2000-01-02 01:00:00 GMT"
 [49] "2000-01-02 01:30:00 GMT" "2000-01-02 02:00:00 GMT"
 [51] "2000-01-02 02:30:00 GMT" "2000-01-02 03:00:00 GMT"
 [53] "2000-01-02 03:30:00 GMT" "2000-01-02 04:00:00 GMT"
 [55] "2000-01-02 04:30:00 GMT" "2000-01-02 05:00:00 GMT"
 [57] "2000-01-02 05:30:00 GMT" "2000-01-02 06:00:00 GMT"
 [59] "2000-01-02 06:30:00 GMT" "2000-01-02 07:00:00 GMT"
 [61] "2000-01-02 07:30:00 GMT" "2000-01-02 08:00:00 GMT"
 [63] "2000-01-02 08:30:00 GMT" "2000-01-02 09:00:00 GMT"
 [65] "2000-01-02 09:30:00 GMT" "2000-01-02 10:00:00 GMT"
 [67] "2000-01-02 10:30:00 GMT" "2000-01-02 11:00:00 GMT"
 [69] "2000-01-02 11:30:00 GMT" "2000-01-02 12:00:00 GMT"
 [71] "2000-01-02 12:30:00 GMT" "2000-01-02 13:00:00 GMT"
 [73] "2000-01-02 13:30:00 GMT" "2000-01-02 14:00:00 GMT"
 [75] "2000-01-02 14:30:00 GMT" "2000-01-02 15:00:00 GMT"
 [77] "2000-01-02 15:30:00 GMT" "2000-01-02 16:00:00 GMT"
 [79] "2000-01-02 16:30:00 GMT" "2000-01-02 17:00:00 GMT"
 [81] "2000-01-02 17:30:00 GMT" "2000-01-02 18:00:00 GMT"
 [83] "2000-01-02 18:30:00 GMT" "2000-01-02 19:00:00 GMT"
 [85] "2000-01-02 19:30:00 GMT" "2000-01-02 20:00:00 GMT"
 [87] "2000-01-02 20:30:00 GMT" "2000-01-02 21:00:00 GMT"
 [89] "2000-01-02 21:30:00 GMT" "2000-01-02 22:00:00 GMT"
 [91] "2000-01-02 22:30:00 GMT" "2000-01-02 23:00:00 GMT"
 [93] "2000-01-02 23:30:00 GMT" "2000-01-03 00:00:00 GMT"
 [95] "2000-01-03 00:30:00 GMT" "2000-01-03 01:00:00 GMT"
 [97] "2000-01-03 01:30:00 GMT" "2000-01-03 02:00:00 GMT"
 [99] "2000-01-03 02:30:00 GMT" "2000-01-03 03:00:00 GMT"
```

```r
## diferen?a entre cada hor?rio da sequ?ncia
head(diff(dhh))
```

```
Time differences in mins
[1] 30 30 30 30 30 30
```

```r
## sequ?ncia de 6 horas
d6h <- seq(from = as.POSIXct("2000-01-01 01:30:00", tz = "GMT"),
             to = as.POSIXct("2001-12-31 02:30:00", tz = "GMT"), 
             by = "6 hours")
head(d6h, 20)
```

```
 [1] "2000-01-01 01:30:00 GMT" "2000-01-01 07:30:00 GMT"
 [3] "2000-01-01 13:30:00 GMT" "2000-01-01 19:30:00 GMT"
 [5] "2000-01-02 01:30:00 GMT" "2000-01-02 07:30:00 GMT"
 [7] "2000-01-02 13:30:00 GMT" "2000-01-02 19:30:00 GMT"
 [9] "2000-01-03 01:30:00 GMT" "2000-01-03 07:30:00 GMT"
[11] "2000-01-03 13:30:00 GMT" "2000-01-03 19:30:00 GMT"
[13] "2000-01-04 01:30:00 GMT" "2000-01-04 07:30:00 GMT"
[15] "2000-01-04 13:30:00 GMT" "2000-01-04 19:30:00 GMT"
[17] "2000-01-05 01:30:00 GMT" "2000-01-05 07:30:00 GMT"
[19] "2000-01-05 13:30:00 GMT" "2000-01-05 19:30:00 GMT"
```

```r
## quantas pentadas por ano
table(format(d6h, "%H"))
```

```

 01  07  13  19 
731 730 730 730 
```

## Seleção de intervalos por datas

Uma função muito útil na preparação de dados meteorológicos é a seleção partes do período de dados a partir de datas, anos, meses, dias ou horas. Vamos então explorar a função `selectByDate` do pacote [openair](http://www.openair-project.org/).


```r
library(openair)
?selectByDate
# dados disponíveis com o openair
str(mydata)
```

```
'data.frame':	65533 obs. of  10 variables:
 $ date: POSIXct, format: "1998-01-01 00:00:00" "1998-01-01 01:00:00" ...
 $ ws  : num  0.6 2.16 2.76 2.16 2.4 3 3 3 3.36 3.96 ...
 $ wd  : int  280 230 190 170 180 190 140 170 170 170 ...
 $ nox : int  285 NA NA 493 468 264 171 195 137 113 ...
 $ no2 : int  39 NA NA 52 78 42 38 51 42 39 ...
 $ o3  : int  1 NA 3 3 2 0 0 0 1 2 ...
 $ pm10: int  29 37 34 35 34 16 11 12 12 12 ...
 $ so2 : num  4.72 NA 6.83 7.66 8.07 ...
 $ co  : num  3.37 NA 9.6 10.22 8.91 ...
 $ pm25: int  NA NA NA NA NA NA NA NA NA NA ...
```

```r
# período de dados
range(mydata$date)
```

```
[1] "1998-01-01 00:00:00 GMT" "2005-06-23 12:00:00 GMT"
```

```r
# visualização dos dados
timePlot(mydata, names(mydata)[-1])
```

<img src="figs/Chunk63-1.png" style="display: block; margin: auto;" />

```r
# selecionando dados para um interval de datas
mydata_00 <- selectByDate(mydata, start = "2000-01-01", end = "2001-01-01")
head(mydata_00)
```

```
                     date   ws  wd nox no2 o3 pm10      so2       co pm25
17521 2000-01-01 00:00:00 1.68 200 203  41  1   41  6.55000 2.157500   NA
17522 2000-01-01 01:00:00 1.32 190 464  44  2   74 12.71667 7.196667   62
17523 2000-01-01 02:00:00 3.60 190 427  61  2   70 11.67333 6.406667   62
17524 2000-01-01 03:00:00 5.76 240 333  51  0   56  9.18250 3.880000   47
17525 2000-01-01 04:00:00 2.64 240 253  39  0   42  7.26000 2.852500   36
17526 2000-01-01 05:00:00 2.64 280 121  34  0   24  4.30750 1.617500   NA
```

```r
tail(mydata_00)
```

```
                     date   ws  wd nox no2 o3 pm10    so2     co pm25
26323 2001-01-01 18:00:00 7.92 170 126  38  2   29 2.4500 1.6875   21
26324 2001-01-01 19:00:00 8.40 170 132  38  3   25 2.4500 2.0450   18
26325 2001-01-01 20:00:00 8.52 170 155  44  5   24 3.0375 1.9975   17
26326 2001-01-01 21:00:00 9.12 170 120  35  8   27 2.4750 1.8300   18
26327 2001-01-01 22:00:00 9.60 170  96  33 11   24 2.1200 1.3800   16
26328 2001-01-01 23:00:00 9.72 170  77  24 12   21 2.0275 1.2600   19
```

```r
str(mydata_00)
```

```
'data.frame':	8808 obs. of  10 variables:
 $ date: POSIXct, format: "2000-01-01 00:00:00" "2000-01-01 01:00:00" ...
 $ ws  : num  1.68 1.32 3.6 5.76 2.64 2.64 1.32 2.64 3.84 2.88 ...
 $ wd  : num  200 190 190 240 240 280 260 260 240 360 ...
 $ nox : int  203 464 427 333 253 121 199 150 98 58 ...
 $ no2 : int  41 44 61 51 39 34 35 36 35 30 ...
 $ o3  : int  1 2 2 0 0 0 0 0 0 4 ...
 $ pm10: int  41 74 70 56 42 24 26 24 19 14 ...
 $ so2 : num  6.55 12.72 11.67 9.18 7.26 ...
 $ co  : num  2.16 7.2 6.41 3.88 2.85 ...
 $ pm25: int  NA 62 62 47 36 NA 22 19 16 11 ...
```

```r
# selecionando todos janeiros
mydata_jan <- selectByDate(mydata, month = 1)
str(mydata_jan)
```

```
'data.frame':	5952 obs. of  10 variables:
 $ date: POSIXct, format: "1998-01-01 00:00:00" "1998-01-01 01:00:00" ...
 $ ws  : num  0.6 2.16 2.76 2.16 2.4 3 3 3 3.36 3.96 ...
 $ wd  : num  280 230 190 170 180 190 140 170 170 170 ...
 $ nox : int  285 NA NA 493 468 264 171 195 137 113 ...
 $ no2 : int  39 NA NA 52 78 42 38 51 42 39 ...
 $ o3  : int  1 NA 3 3 2 0 0 0 1 2 ...
 $ pm10: int  29 37 34 35 34 16 11 12 12 12 ...
 $ so2 : num  4.72 NA 6.83 7.66 8.07 ...
 $ co  : num  3.37 NA 9.6 10.22 8.91 ...
 $ pm25: int  NA NA NA NA NA NA NA NA NA NA ...
```

```r
range(mydata_jan$date)
```

```
[1] "1998-01-01 00:00:00 GMT" "2005-01-31 23:00:00 GMT"
```

```r
# selecionando de julho a agosto de 2000
mydata_jja <- selectByDate(mydata, month = 6:8, year = 2000)
head(mydata_jja)
```

```
                     date   ws  wd nox no2 o3 pm10      so2        co pm25
21169 2000-06-01 00:00:00 5.16 180 150  54  8   28 2.897500 1.0675000   23
21170 2000-06-01 01:00:00 4.92 180 102  38 13   22 1.556667 0.5566667   15
21171 2000-06-01 02:00:00 5.76 190  90  34 15   21 1.170000 0.3833333   12
21172 2000-06-01 03:00:00 6.36 220  93  29 10   20 0.875000 0.4700000   16
21173 2000-06-01 04:00:00 6.96 220 116  34  7   21 1.315000 0.3125000   13
21174 2000-06-01 05:00:00 7.32 210 190  35  4   31 2.920000 0.7300000   NA
```

```r
tail(mydata_jja)
```

```
                     date   ws  wd nox no2 o3 pm10     so2     co pm25
23371 2000-08-31 18:00:00 6.12 180 371  87  5   61 11.6400 3.9550   46
23372 2000-08-31 19:00:00 5.52 180 401  98  5   65 11.4275 5.4575   49
23373 2000-08-31 20:00:00 6.00 170 345  64  5   60 10.3400 4.2675   46
23374 2000-08-31 21:00:00 6.72 180 226  64  6   47  5.5200 2.4275   38
23375 2000-08-31 22:00:00 6.36 180 215  55  4   33  4.9150 2.2575   23
23376 2000-08-31 23:00:00 5.64 190 180  50  6   28  4.0400 1.9850   NA
```

```r
str(mydata_jja)
```

```
'data.frame':	2208 obs. of  10 variables:
 $ date: POSIXct, format: "2000-06-01 00:00:00" "2000-06-01 01:00:00" ...
 $ ws  : num  5.16 4.92 5.76 6.36 6.96 7.32 6.96 8.04 8.04 8.16 ...
 $ wd  : num  180 180 190 220 220 210 200 210 210 200 ...
 $ nox : int  150 102 90 93 116 190 376 430 429 273 ...
 $ no2 : int  54 38 34 29 34 35 55 71 49 52 ...
 $ o3  : int  8 13 15 10 7 4 3 2 2 1 ...
 $ pm10: int  28 22 21 20 21 31 52 56 54 48 ...
 $ so2 : num  2.897 1.557 1.17 0.875 1.315 ...
 $ co  : num  1.067 0.557 0.383 0.47 0.312 ...
 $ pm25: int  23 15 12 16 13 NA 37 39 39 33 ...
```

```r
timePlot(mydata_jja, names(mydata_jja)[-1])
```

<img src="figs/Chunk63-2.png" style="display: block; margin: auto;" />

> Selecione dados dos meses maio e setembro somente às 0 6, 12, 18 horas.


# lubridate


```r
library(lubridate)
ymd("20110604")
```

```
[1] "2011-06-04"
```

```r
mdy("06-04-2011")
```

```
[1] "2011-06-04"
```

```r
dmy("04/06/2011")
```

```
[1] "2011-06-04"
```

```r
# Fuso horário
(hora_belem <- ymd_hms("2011-06-04 00:00:00", tz = "America/Belem"))
```

```
[1] "2011-06-04 BRT"
```

```r
(hora_sp <- with_tz(hora_belem, "America/SaoPaulo"))
```

```
[1] "2011-06-04 03:00:00 America"
```

```r
# extraindo informações
second(hora_sp)
```

```
[1] 0
```

```r
hour(hora_sp)
```

```
[1] 3
```

```r
day(hora_sp)
```

```
[1] 4
```

```r
wday(hora_sp)
```

```
[1] 7
```

```r
wday(hora_sp, label = TRUE)
```

```
[1] Sat
Levels: Sun < Mon < Tues < Wed < Thurs < Fri < Sat
```

```r
yday(hora_sp)
```

```
[1] 155
```

```r
month(hora_sp)
```

```
[1] 6
```

```r
year(hora_sp)
```

```
[1] 2011
```

```r
leap_year(2011)
```

```
[1] FALSE
```

```r
# último dia do mês
last_day <- function(date) {
  ceiling_date(date, "month") - days(1)
}
last_day(hora_sp)
```

```
[1] "2011-06-30 America"
```

> Selecione dados dos de sábados no conjunto de dados `mydata`.
