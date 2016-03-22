## ----Chunk0, comment="",prompt=FALSE, echo=FALSE, eval=TRUE, error=TRUE,highlight=TRUE,message=FALSE,warning=FALSE, results='hide'----
rm(list=ls())
# definindo globalmente tz = "GMT"
#Sys.setenv(TZ = 'GMT')
# data manipulation packages
pcks <- c("knitr", "knitcitations", "pander", "htmlTable")
invisible(sapply(pcks, require, character.only = TRUE, quietly = TRUE))
# configuraçoes knitr
opts_chunk$set(cache = FALSE, fig.path = "figs/")

## ----chunk7, message=FALSE, comment="",prompt=FALSE----------------------
# vetor numérico
vetor_num <- c(5, 2.5, 4.5)
# Note o sufixo L que distingue variaveis "double" de "integers"
vetor_int <- c(1L, 6L, 10L)
# Vetor logico
vetor_log <- c(T, FALSE, TRUE, FALSE)
# Vetor de caracteres
vetor_char <- c("Analise de dados", "ambientais com o R")

## ----chunk71, message=FALSE, comment="",prompt=FALSE, tidy=FALSE---------
v1 <- 1           # vetor com 1 elemento
v2 <- c(2)        # vetor com 1 elemento
v3 <- c(4, 6)     # vetor com 2 elemento

## ---- message=FALSE, comment="",prompt=FALSE, tidy=FALSE-----------------
(v_123 <- c(v1, v2, v3))
(v_123a <- c(1, c(v2, v3)))
(v_123b <- c(vetor_num, c(v1, v2), v3))
v <- c(1, 2, 4, 6)
v

## ----chunk72, message=FALSE, comment="",prompt=FALSE---------------------
c("a", 1)
as.numeric(c(F, F, T))

## ----chunk73, message=FALSE, comment="",prompt=FALSE---------------------
# vetor com nomes criados com 1 comando
meses <- c(jan = 1, fev = 2, mar = 3 , abr = 4, mai = 5, jun = 6,
           jul = 7, ago = 8, set = 9, out = 10, nov = 11, dez = 12)
meses
## vetor definido e depois adiciona-se o nome das variáveis
months <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
names(months) <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
months
# o atibuto mais comum de um vetor
attributes(meses)
length(meses)
# Vetor com dados de prec
chuva <- c(100, 0, 20, 140, 110, 50, 90, 0, 0 , 10, 0, 6)
length(chuva)
# quando nao choveu?
seco <- chuva == 0
seco
# coerção de lógico para numérico
seco01 <- as.numeric(seco)
#seco01 <- as.integer(seco)
seco01
# total de meses secos no ano
sum(seco01)
# também funciona com vetores lógicos
sum(seco)

## ----chunk74, message=FALSE, comment="",prompt=FALSE---------------------
# Durante a criação:
x <- c(a = 1, b = 2, c = 3)
x
# Modificando um vetor: 
x <- 1:3; names(x) <- c("a", "b", "c")
x
# Criando um vetor modificado
x <- setNames(1:3, c("a", "b", "c"))
x

## ----chunk75, message=FALSE, comment="",prompt=FALSE---------------------
y <- c(a = 1, 2, 3)
names(y)
z <- c(1, 2, 3)
names(z)

## ----chunk76, message=FALSE, comment="",prompt=FALSE---------------------
a <- c(dia1 = 12, dia2 = 20, dia3 = 10)
a
names(a)
a_sn <- unname(a)
a_sn
names(a_sn)

## ----chunk77, message=FALSE, comment="",prompt=FALSE---------------------
x <- 1:10
x * 3
x + 2
x - 3
x/4
2^(x/4)
x^2
sqrt(x)

## ----chunk78, message=FALSE, comment="",prompt=FALSE---------------------
# criando 2 vetores de mesmo tamanho
x <- 1:10
y <- -5:4
# somando-os
x + y
x - y
x * y
x/y
x^y
2^x
x %% y
# tamanho dos vetores
length(x)
length(y)
length(x + y)

## ----chunk79, message=FALSE, comment="",prompt=FALSE, tidy=TRUE----------
v1 <- c(3, 5, 88, 90)
v2 <- c(2, 1)  
v1 + v2

## ----chunk710, message=FALSE, comment="",prompt=FALSE, tidy=TRUE---------
v1 <- c(3, 5, 88, 90)
v2 <- c(2, 1, 3)  
v1 + v2

## ----chunk711, message=FALSE, comment="",prompt=FALSE, tidy=TRUE---------
v1
cte <- 4
v1 * cte

## ----chunk712, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, eval=TRUE, echo=TRUE, error=TRUE----
v1 <- c(3, 5, 88, 90)
srt(v1)
sqrt(-v1)

## ----chunk713, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, eval=TRUE, echo=TRUE, error=TRUE----
x <= 5
x > y
x < y

## ----comment="",prompt=FALSE---------------------------------------------
# operador está contido em 
2:4 %in% x
# 2:4 são elementos de x?
is.element(2:4, x)

## ----chunk714, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, eval=TRUE, echo=TRUE, error=TRUE----
nchar(month.name)
nchar(y)

## ----chunk715, message=FALSE, comment="",prompt=FALSE, tidy=TRUE---------
vetor <- c(0, 1,-1,-2, 3, 5, -5)
all(vetor < 0)               # todas as posições são maiores que 0 ?
any(vetor > 0)               # alguma posição é maior que 0?

## ----chunk716, message=FALSE, comment="",prompt=FALSE, tidy=FALSE--------
# dias do ano
dda <- 1:365
dda
# sequencia de anos
anos <- 1961:1990
anos
# sequencia de inteiros decrescente
si_dec <- 10:-10
si_dec
# sequencia de numeros não inteiros
seqn <- 1.5:10
seqn
c(seqn, 10)

## ----chunk717, message=FALSE, comment="",prompt=FALSE, tidy=FALSE--------
# igual a c(snum, 10), mas usando o seq
(snum_b <- seq(from = 1.5, to = 10, by = 0.5))

## ----chunk718, message=FALSE, comment="",prompt=FALSE, tidy=FALSE--------
# vetor com de anos decimais (2 valores por dia)
anos_dec <- seq(2010, 2011, length.out = 365*2)
# para ver só o início do vetor ao invés de todo o vetor
head(anos_dec)
# mas não dá pra ver a parte decimal, vamos alterar as opções 
# aumentando as casas decimais
options(digits = 6)
# verifique agora
head(anos_dec)
# só os primeiros 30 elementos
head(anos_dec, 30)
# para ver só o final do vetor yrFrac
tail(anos_dec)
# para ver só os último 50 elementos do yrFrac
tail(anos_dec, 50)
# pentadas
pent <- seq(from = 1, to = 365, by = 5)
# dencendios
decd <- seq(from = 1, to = 365, by = 10)
# fracoes de dia 
frac_d30mn <- seq(0, 365, length.out = 365*48) + 1
head(frac_d30mn, 48*2)
tail(frac_d30mn, 48*2)
# diferentes funções para gerar uma sequência
an <- c(1,7,2,5,3,2)
# gerando uma sequencia a partir de um número
seq_len(length.out = 6)
# gerando uma sequência a partir de um número
seq(6)
# de acordo com o tamanho do vetor gera-se uma sequencia 
seq(along = an)
seq(along = 0) #! melhor opção para gerar sequencias do tamanho do vetor
seq(0) #! cuidado, veja ?seq para entender a razão desse resultado inusitado
# conflito entre parâmetros
# a <-seq(from = -5, to = 5, by = 0.05, length.out=200)
s5by <- seq(from = -5, to = 5, by = 0.05)
length(s5by)
tail(s5by)
s5len <- seq(from = -5, to = 5, length.out = 200)
length(s5len)
tail(s5len)

## ----chunk719, message=FALSE, comment="",prompt=FALSE--------------------
rep_t4 <- rep(1:2, times = 4)
rep_t4
rep_e31 <-rep(1:12, each = 31)
rep_e31
rep_t13 <- rep(c("chuva","sol"), times = c(1,3))
rep_t13
rep_t13_t4 <- rep(rep(c("chuva","sol"), times = c(1,3)), times = 4)
rep_t13_t4

## ----chunk720, message=FALSE, comment="",prompt=FALSE, tidy=FALSE--------
# vetor de chuva mensal para um dado ano 
prec <- c(300, 150, 210, 12, 0, 0, 12, 22, 80, 100, 0, 280)
meses <- c("Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul","Ago", "Set", "Out", "Nov", "Dez")
names(prec) <- meses
prec
# gráfico de barras
barplot(prec)
box()
# temperatura do ar média mensal para um dado ano
temp <- c(25, 23.2, 22.5, 21, 19, 17.6, 18, 19.7, 21.3, 22, 24, 26.8)
names(temp) <- meses
temp
plot(temp, type = "o")

## ----chunk721, message=FALSE, comment="",prompt=FALSE, tidy=FALSE--------
prec_jan <- prec[1]
prec_jan
temp_jan <- temp[1]
temp_jan

## ----Chun722, message=FALSE, comment="",prompt=FALSE, tidy=FALSE---------
# vetor de temperatura do ar média mensal de um ano qualquer
temp_dez <- temp[length(temp)]
temp_dez
prec_dez <- prec[length(prec)]
prec_dez

## ----chunk723, message=FALSE, comment="",prompt=FALSE, tidy=FALSE--------
sel_prec <- c(6,7,8)
# vetor de chuva JJA
prec_jja <- prec[sel_prec]
prec_jja
# total de chuva trimestral nesse ano
prect_jja_tot <- sum(prec_jja)
prect_jja_tot
# vetor de temperatura DJF
sel_temp <- c(12,1,2)
temp_djf <- temp[sel_temp]
temp_djf
# temp média trimestral nesse ano
temp_djf_med <- mean(temp_djf)
temp_djf_med

## ----chunk724, message=FALSE, comment="",prompt=FALSE, tidy=FALSE--------
# exceto o primeiro e ultimo
prec[-c(1, length(prec))]
# exceto os 3 primeiros meses
temp[-c(1:3)]
# exceto os 3 últimos meses
temp[-c(length(temp):(length(temp)-2))]

## ----chunk727c, message=FALSE, comment="",prompt=FALSE, tidy=TRUE--------
prec["Jan"]
prec[c("Dez", "Fev", "Jun")]

## ----chunk725, message=FALSE, comment="",prompt=FALSE, tidy=TRUE---------
vetor_l <- c(TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, FALSE, TRUE)
meses[vetor_l]

## ----chunk726, message=FALSE, comment="",prompt=FALSE, tidy=TRUE---------
sum(vetor_l)

## ----chunk727, message=FALSE, comment="",prompt=FALSE--------------------
# vetor lógico
vetor_l <- c(T, F)
meses[vetor_l]
vetor_l <- c(T, F, F)
meses[vetor_l]
prec[c(T,F)]
temp[c(rep(F,3),T)]

## ----chunk728, message=FALSE, comment="",prompt=FALSE--------------------
# vetor prec
prec
# teste para chuva > 80 mm/mês
prec > 80
# salvando resultado do teste
above80 <- prec > 80
# extraindo valores atendidos ao teste
prec[above80]
# teste para meses com chuva abaixo da média mensal
(prec_med <- mean(prec))
# salvando resultado do teste
(below_avg <- prec < prec_med)
# extraindo valores que atendem a condição
prec[below_avg]
# extraindo os 3 primeiros meses com prec abaixo da média
prec[below_avg][1:3]
# forma equivalente em uma linha só
prec[prec < mean(prec)][1:3]
# teste para meses com prec diferente de zero
prec[prec != 0]

## ----chunk729, message=FALSE, comment="",prompt=FALSE, tidy=TRUE---------
# prec
prec
# combinação de operador lógico e relacional
below100 <- prec > 0 & prec <= 100
prec_cond1 <- prec[below100]
prec_cond1

## ----chunk7290, message=FALSE, comment="",prompt=FALSE, tidy=TRUE--------
a <- c(1, 1, 0, 1)
b <- c(2, 1, 0, 1)
# forma normal verifica cada elemento de a e cada elemento de b
a == 1 & b == 1
# forma dupla verifica somente o primeiro elemento de a e o primeiro elemento de b
# retornando somente um resultado
a == 1 && b == 1

## ----chunk729011, message=FALSE, comment="",prompt=FALSE, echo=FALSE, eval=FALSE----
(prec[1:3] > 200) & (prec[10:length(prec)] > 200)
(prec[1:3] > 200) | (prec[10:length(prec)] > 200)
(prec[1:3] > 200) && (prec[10:length(prec)] > 200)
(prec[1:3] > 200) && (prec[10:length(prec)] > 200)
all(prec[1:3] > 100) & all(prec[10:length(prec)] > 200)

## ----chunk72901, message=FALSE, comment="",prompt=FALSE, echo=FALSE, out.width=200----
oper <- c("a", "b", "a==1", "b==1", "a == 1 & b == 1", "a == 1 && b == 1") 
desc <- data.frame(
                   a,
                   b,
                   a == 1, 
                   b == 1,
                   a == 1 & b == 1,
                   a == 1 && b == 1)
names(desc) <- oper
desc[2:nrow(desc),6] <- ""
pander(desc, caption = "Demostração da diferença entre & e &&.")

## ----chunk7292, message=FALSE, comment="",prompt=FALSE-------------------
# vetor de horas
horas <- 0:23
# vetor de temperaturas horárias
tar_hor <- c(19.9, 19.8, 19.5, 19.4, 19.4, 19.3, 
             19.2, 19, 19.2, 19.5, 20.1, 20.6, 20.9, 
             21.8, 22.5, 22.6, 22.5, 22, 21.4, 20.1, 
             20, 19.8, 19.6, 19.4)
# gráfico do varição horária da temperatura do ar
plot(horas, tar_hor, type = "o", pch = 20)
# temperaturas noturnas abaixo de 20ºC
(night_below20 <- (horas < 6 | horas > 18) & tar_hor < 20)
tar_hor[night_below20]
# destacando no gráfico
points(x = horas[night_below20], 
       y = tar_hor[night_below20], 
       pch = 20,      # tipo de símbolo para os ponts
       col = "blue",  # cor do símbolo
       cex = 2)       # tamanho do ponto
# temperaturas abaixo de 20ºC que não ocorreram a noite
day_below20 <- tar_hor < 20 & !night_below20
points(horas[day_below20], tar_hor[day_below20], pch = 20, col = "red", cex = 2)
# adicionando linha horizontal ao longo da temperatura = 20ºC
abline(h = 20, col = "gray")

## ----chunk730, message=FALSE, comment="",prompt=FALSE, tidy=TRUE---------
# prec sem nomes
names(prec) <- NULL
# combinação de operador lógico e relacional
below100
which(below100)
# qual os meses em que a chuva foi acima da media
which(prec > prec_med)
prec[which(prec > prec_med)]
# Qual a temp quando a chuva ou a temp foi acima da media?
sel <- which(prec > prec_med | !temp < mean(temp))
sel
prec[sel]
# quais posições do vetor prec não choveu
which(prec == 0)
# quando ocorreu a prec max
which(prec == max(prec))
# equivalente a ...
which.max(prec)
# seleciona só a primeira ocorrência!
which.min(prec)
prec

## ----chunk731, message=FALSE, comment="",prompt=FALSE, tidy=TRUE---------
# compare o tamanho dos vetores resultantes
which(meses %in% c("JAN", "Feb", "Mar"))
# note a diferença 
which(c("JAN", "Feb", "Mar") %in% meses)
cond <- names(temp) %in% c( "Jun","Jul","Ago")
quais <- which(cond)
quais
prec[cond]
prec[quais]

## ----chunk732, message=FALSE, comment="",prompt=FALSE, tidy=FALSE--------
# posição a ser alterada
pos <- 10
# valor da temperatura naquela posição
old_temp <- temp[pos]   
old_temp
# vetor de temperatura
temp
# substituição do valor original por um novo valor
new_temp <- 30
# alterando temperatura do mês de outubro
temp[pos] <- new_temp
temp

## ----chunk733, message=FALSE, comment="",prompt=FALSE, tidy=FALSE--------
prec
prec["Mai"] <- 5
temp
temp[c("Mai", "Jul")] <- temp[c("Mai", "Jul")] + 2
temp

## ----chunk734, message=FALSE, comment="",prompt=FALSE, tidy=TRUE---------
# criação de vetor v
v <- 3
v
# adicionando elementos
v[2] <- 100
v
v[5] <- 6
v
# adicionando elementos de vetores
x <- c(88,5,12,13)
x <- c(x[1:3], 168, x[4]) # insere 168 antes do 13
x
# outra opção 
k <- vector()
class(k)
# vetor k existe?
ls()
# alocando o valor 45 no 3º elemento de k
k[3] <- 45
k
class(k)
# diminuindo o tamanho de k
length(k) 
length(k) <- 2
k
length(k) <- 0
k
class(k)
is.null(k)
# exemplo
temp <- c(25, 23.2, 22.5, 21, 19, 17.6, 18, 19.7, 21.3, 22, 24, 26.8)
temp_orig  <- temp
# mostrando o vetor temp
temp
temp[] 
# substituir todos elementos do vetor temp por um vetor com apenas um valor
temp <- 0 
temp
# vamos redefinir temp e comparar o anterior com o obtido com o próximo comando
temp <- temp_orig;
temp[1:length(temp)] <- 0
temp
# qual diferença de x <- 0 e x[] <-0 ?
temp <- temp_orig
temp[] <- 0  
temp
# Um vetor com tamanho pre-definido e do tipo numeric
umvetor <- vector(mode = "numeric", length=100)
umvetor
# populando o vetor
umvetor[1] <- 10
umvetor[10] <- 100
umvetor

## ----chunk735, message=FALSE, comment="",prompt=FALSE, error = TRUE------
v1 <- c(1:8,NA)
v1 > 5    # NA sai na resposta
# teste lógico com o operador idêntico "=="
v1 == NA  
# não funcionou, porque há funções específicas para vetores com NA
onde_falta <- is.na(v1)
# função apropriada p/ checar se tem NAs
faltante <- which(is.na(v1));
v1[-faltante]
# ou 
v1[!onde_falta]
# vamos calcular a média de v1
sum(v1)/length(v1)
# vamos remover valores NA
sum(v1[-faltante])/length(v1[-faltante])
sum(v1[!onde_falta])/length(v1[!onde_falta])
# mas o R possui a função mean 
mean(v1) 
# não retornou o que desejamos, removendo as posicoes dos dados faltantes
mean(v1[-faltante])
# ok, mas olhando o help ...
#?mean
mean(v1, na.rm=TRUE)
# definir como faltante todos elementos de v1
v1[] <- NA
v1
length(v1)
# vetor com dados faltantes indicados por -999
# substituir onde é -999 por NA
x <- c(-999, 10, 15, -999, 50)
x == -999
x[x == -999] <- NA 
# total de dados faltantes
sum(!is.na(x))

## ----chunk738, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, error=TRUE----
# v1 existe ?
ls()
exists("v1")
# vamos anular todo v1
v1 <- NULL
ls()
v1
# NULL
vetor1 <- c()
vetor2 <- NULL;
is.null(c(vetor1,vetor2))
# vetor1 e vetor2 são equivalentes?
identical(vetor1, vetor2)
# remoção de elementos de um vetor com NULL
a <- c(10, 2, NA, 20)
a
typeof(a)
# remover de a o dado faltante
a <- a[!is.na(a)]
a
# é possível remover um elemento com o NULL?
a[length(a)] <- NULL
a
a <- a[-length(a)]
a
typeof(a)
# anulando a
a <- NULL
# qual modo de um objeto nulo?
typeof(a)
# qual modo de NA?
b <- NA
b
typeof(b)
length(a)
length(b)

## ----Chunk111, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
v <- 1:12
length(v)
attributes(v)
class(v)
## cópia de v
vetor <- v
## conversão de vetor para matriz
dim(v) <- c(3, 4)  # 1a dimensão: linhas , 2a dimensão: colunas 
## vetor é vector?
is.vector(v)
## vetor é matrix?
is.matrix(v)
## classe de vetor
class(v)
attributes(v)
v
## invertendo as dimensões
dim(v) <- c(4, 3)
v
class(v)
typeof(v)

## ----Chunk1121, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
## atribuindo novas dimensões ao vetor
m <- matrix(vetor) # matriz de uma coluna
m

## ----Chunk1122, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
## criando a matriz gerada com dim
mat <- matrix(vetor, nrow = 3, ncol = 4) 
mat
## não há necessidade de especificar ambos ncol e nrow
mat <- matrix(vetor, nrow = 3) 
mat

## ----Chunk1123, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
## criando a matriz gerada com dim
mat <- matrix(nrow = 3, ncol = 4)
mat
mat[1,1] <- 1
mat[2,1] <- 2
mat[3,1] <- 3
mat[1,2] <- 4
mat[2,2] <- 5
mat[3,2] <- 6
mat[1,3] <- 7
mat[2,3] <- 8
mat[3,3] <- 9
mat[1,4] <- 10
mat[2,4] <- 11
mat[3,4] <- 12
mat

## ----Chunk1124, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
## byrow = T
mat <- matrix(vetor, ncol = 4, byrow = T) 
mat

## ----Chunk121, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
## temperatura do ar média mensal do ano de 1990
temp90 <- c(25.00, 23.20, 22.50, 21.00, 19.00, 17.60,
            18.00, 19.70, 21.30, 22.00, 24.00, 26.80)
## temperatura do ar média mensal do ano de 1991
temp91 <- c(24.89, 24.07, 23.56, 23.11, 18.29, 18.22,
            16.72, 19.37, 20.08, 21.45, 26.61, 25.99)
## temperatura do ar média mensal do ano de 1992
temp92 <- c(23.2, 26.61, 18, 23.11, 26.8, 21.3, 18.22,
            21.45, 19.7, 22.5, 24.07, 20.08)
## vetor com as temperaturas dos 3 anos
vtemp <- c(temp90, temp91, temp92)
vtemp
## arranjar matrix com meses ao longo das colunas e anos ao longo das linhas
temp_mat <- matrix(vtemp, ncol = 12, byrow = T)
temp_mat
## cópia da matriz temp_mat (sem nomes)
temp_matO <- temp_mat

## ----Chunk122, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
## atribuindo nomes as colunas e linhas da temp_mat
rownames(temp_mat) <- c("ano1990", "ano1991", "ano1992")
colnames(temp_mat) <- c("Jan", "Fev", "Mar", "Abr", "Mai",
                        "Jun", "Jul","Ago", "Set", "Out", 
                        "Nov", "Dez")
temp_mat

## ----Chunk131, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
temp_mat   # matriz de temperaturas com nomes
temp_matO  # matriz de temperaturas sem nomes
## qual a linha do ano de 1991
linha <- 2
## qual a coluna do mês de maio
coluna <- 5
## extraindo
temp_mat[linha, coluna]
## ou usando os nomes
temp_mat["ano1991", "Mai"]

## ----Chunk132, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
## temperaturas de todos janeiros
temp_mat[ , 1]
temp_mat[ , "Jan"]
## só as temperaturas de 1990 e 1993
temp_mat[-2 , ]
## só as temperaturas dos verões
temp_mat[, c(12, 1, 2)]
## invertendo ordem das colunas
temp_mat[, ncol(temp_mat):1]
## invertendo ordem das colunas e das linhas
temp_mat[3:1, 12:1]
## invertendo ordem das colunas e das linhas
temp_mat[c(2,1,3), c(6:1,12,10:8)]
## só as temperaturas dos invernos
temp_mat[, colnames(temp_mat) %in% c("Jun", "Jul", "Ago") ]
## exceto as temperaturas dos invernos
temp_mat[, -which(colnames(temp_mat) %in% c("Jun", "Jul", "Ago")) ]
## seleção de colunas intercaladas da matriz: mês sim, mês nao
temp_mat[,c(T,F)]
## 2 meses sim, 1 mes não
temp_mat[,c(T,T,F)]

## ----Chunk133, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
temp_mat[, 1:6]
temp_mat[, 1:6]["ano1991",]
temp_mat[, 1:6]["ano1991",][2:4]

## ----Chunk134, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
M <- temp_mat
M
## 1990 e 1992 os meses de jan e dez 
M[c(1,3), c(1,12)]
## matriz com novos valores
matrix(c(21, 22, 23, 24), ncol = 2)
## substituindo
M[c(1,3), c(1,12)] <- matrix(c(21, 22, 23, 24), ncol = 2)
M

## ----Chunk135, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
 mx <- matrix(nrow = 3, ncol = 3)
 my <- matrix(c(4,5,2,3), nrow = 2)
 my
 mx[2:3, 2:3] <- my
 mx

## ----Chunk141, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
M
ncol(temp_mat)
nrow(temp_mat)
dim(temp_mat)

## ----Chunk142, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
## colunas de cada elemento da matriz
col(temp_mat)
## linhas de cada elemento da matriz
row(temp_mat)
## elementos de matriz
m <- matrix(1:16, nrow = 4, byrow = T)
m
## nós veremos mais sobre a função paste futuramente
elementos <- paste("m", row(m), col(m), sep = "")
mel <- matrix(elementos, ncol = 4)
mel
## qual colunas de M são idênticas a 1
col(m)==1
## seleciona na M colunas idênticas a 1
mel[col(m)==1]
## qual colunas de M são idênticas a 1 ou 3?
col(m)==1 | col(m)==3
## Usando operadores relacionais
row(m)==1
col(m)==3
row(m)==1 | col(m)==3
## seleciona valores de M posicionados na linha 1 OU na coluna 6
mel[row(m)==1 | col(m)==4]
m[row(m)==1 | col(m)==4]
## seleciona valores de M posicionados na linha 1 E na coluna 6
mel[row(m)==4 & col(m)==4]
m[row(m)==4 & col(m)==4]

## ----Chunk151, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
(temp_mat_lin <- rbind(temp90, temp91, temp92))
(temp_mat_col <- cbind(temp90, temp91, temp92))
## recursão
rbind(1:10, 11, 21:25)
cbind(10:6, 5:4, 0)

## ----Chunk161, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
temp_mat
t(temp_mat)
mel
t(mel)
## diagonal de mel
diag(mel)

## ----Chunk1611, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE, error=TRUE----
## multiplicação de duas matrizes
A <- matrix(c(2,1,4,3,0,5),ncol=2)
A
B <- matrix(c(3,2,1,4), ncol = 2)
B
A * B
prodMat <- A %*% B
prodMat
## multiplicação de uma matriz por um escalar
m
m * 2

## ----Chunk1621, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
m
m + m

## ----Chunk1631, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
u <- 1:3
v <- c(5, 12, 13) 
u * v
## produto escalar = u.v = 1*5 + 2*12 + 3*13
crossprod(u, v)

## ----Chunk1641, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
## matriz exemplo
mat_ex <- matrix(c(1, -7, 3, 5, -9, 2, 6, 6, 1), ncol = 3)
det(mat_ex)

## ----Chunk1651, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
## matrizes do sistema linear
coefs <- matrix(c(1, -1, 1, 1), ncol = 2)
y <- c(2, 4)
x <- solve(coefs, y)
x

## ----Chunk171, message=FALSE, comment="",prompt=FALSE, echo=TRUE, eval=TRUE----
## desmanchando matrizes
mel
## note as diferenças
mel[1,1]
mel[1]
## resulta em uma submatriz
mel[1:4, 1:4]
## resulta em um vetor
mel[1:4]
## submatriz da temp_mat
temp_mat[1:3,1:3]
## vetor gerado de 3 elementos de mat
temp_mat[1:3]
## numero de elementos na matriz
nel <- nrow(temp_mat)*ncol(temp_mat)
nel
temp_mat[1: nrow(temp_mat)*ncol(temp_mat) ]
## vetor de temperaturas
vtemp <- temp_mat[1:(ncol(temp_mat)*nrow(temp_mat))]
vtemp
## outra forma de converte temp_mat para vetor
c(temp_mat)
## função formal para converter 
as.vector(temp_mat)
## mais uma forma de converte temp_mat para vetor
array(temp_mat)
## para desmanchar a matriz com os elementos seguindo a ordem das linhas 
c(t(temp_mat))
as.vector(t(temp_mat))
## serie temporal de temp_mat
stemp <- c(t(temp_mat))
plot(stemp, type = "o")
## criar matriz com colunas temp e meses 1:12
cbind(rep(1:12, nrow(temp_mat)),stemp)
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
## para entender a variação nas cores e símbolos usadas no gráfico
cbind(meses = 1:12, temp = stemp, 
      cores = rep(1:3, each = ncol(temp_mat)), ## cores
      simb_tam = rep(seq(1, 2 , by = 0.5), each = ncol(temp_mat))
      ) ## tamanho dos símbolos 

## ----Chunk211, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
v <- 1:12
## atribuindo novas dimensões ao vetor
dim(v) <- c(2, 2, 3)  # 1a dim: 3 linhas , 2a dim: 2 colunas, 3a dim: 2
v
## ou
a <- array(data = v, dim = c(3, 2, 2))
dim(a)
length(a)
class(a)
mode(a)
## exemplo de inicialização de uma array
array(data = 0, dim = c(3,4,2))

## ----Chun221, message=FALSE, comment="",prompt=FALSE, echo=TRUE, eval=TRUE----
tempVals <- c(22.34, 19.8, 22.22, 19.27, 19.53, 19.81, 21.18, 24.44, 23.91, 
21.97, 21.14, 24.54, 23.46, 16.2, 19.93, 20.54, 19.71, 24.94, 
18.71, 21.8, 19.52, 23.44, 19.64, 15.88, 21.83, 19.16, 18.66, 
18.82, 22.73, 19.34, 18.89, 16.7, 21.41, 21.88, 14.95, 18.54, 
23.17, 17.67, 21.91, 19.93, 19.76, 24.32, 21.97, 19.65, 21.29, 
23.24, 22.59, 24.51, 22.47, 20.34, 19.82, 20.87, 18.46, 19.87, 
21.79, 21.94, 18.72, 20.17, 17.82, 16.17, 23.26, 19.83, 16.78, 
16.02, 19.61, 14.89, 19.17, 18.55, 17.01, 18.64, 18.35, 21.26, 
21.95, 18.05, 21.57, 17.86, 21.25, 21.62, 22.22, 23.26, 19.67, 
18.45, 20.38, 19.37, 19.74, 20.91, 16.01, 25.97, 21.9, 24.11, 
24.06, 17.95, 18.06, 20.06, 20.04, 21.24, 17.12, 21.29, 19.93, 
20.12, 20.3, 23.04, 19.16, 20.71, 22.74, 19.9, 20.89, 23.46, 
14.76, 19.71, 16.71, 19.72, 16.94, 23.89, 12.42, 17.01, 20.9, 
19.45, 14.89, 23.27, 20.22, 18.67, 24.12, 21.92, 26.68, 20.73, 
18.42, 19.51, 15.56, 20.6, 23.65, 19.54, 20.92, 17.52, 21.15, 
21.76, 23.05, 18.22, 20.3, 21.62, 19.75, 17.2, 22.08, 19.12, 
23.12, 19.25, 21.2, 15.85, 17.1, 18.59, 22.24, 15.2, 20.12, 18.19, 
20.14, 17.98, 17.11, 17.47, 20.25, 18.27, 22.37, 20.42, 19.87, 
20.94, 19.39, 17.53, 15.99, 21.01, 20.22, 15.18, 25.06, 19.89, 
15.15, 22.52, 20.95, 22.72, 23.39, 25.14, 18.41, 14.28, 19.46, 
20.77, 18.81, 19.74, 20.73, 15.97, 16.88, 21.55, 18.8, 19.53, 
20.31, 20.34, 17.27, 19.33, 22.75, 24.29, 15.87, 16.4, 22.8, 
22.84, 17.79, 18.97, 19.2, 20.59, 19.79, 17.8, 19.36, 22.8, 17.28, 
18.15, 16.48, 19.09, 21.19, 21.23, 22.4, 17.89, 21.42, 16.67, 
17.89, 17.18, 22.05, 19.62, 22.73, 20.12, 23.35, 19.07, 20.34, 
17.1, 15.33, 16.97, 22.93, 19.59, 17.13, 25.41, 18.74, 20.56, 
14.46, 19.47, 23.96, 17.15)
## array de temperaturas
atemp <- array(tempVals, dim=c(4,5,12))
atemp
colnames(atemp) <- -45:-41
rownames(atemp) <- -19:-22
atemp
## serie temporal do 1o ponto
atemp[1,1,]
atemp["-19","-45", ]
## para 1a faixa de latitude (-19), selecionamos
## os valores de temp de todas longitudes e todos tempos 
## longitudes ao longo das linhas e tempo ao longo das colunas
atemp[1,,]
## plot de cada ponto
matplot(t(atemp[1, , ]), type = "l")
## media zonal 
boxplot(atemp[1, , ])
# para 2a faixa de longitude (-44), todas longitudes e tempos 
atemp[ , 2, ]
## média meridional
colMeans(atemp[ , 2, ])
## subdominio
atemp[3:4, 2:3, ]
## sem a primeira linha
## sem a última coluna
## sem o primeiro e ultimo mes
atemp[ -1, -5, -c(1,12)]
## compare
mean(atemp[ , , 1])
mean(atemp[, , 2])
## demanchando uma array (conversão para vetor)
c(atemp)
c(atemp[ , , 1])
## para entender a forma como a matriz é convertida para vetor
matref <- cbind(mes = rep(1:12, each = 20), 
                elemat = rep(1:20, times = 12),  
                valores = c(atemp), 
                elearr = 1:(cumprod(dim(atemp))[3]))
matref
## seleção lógica e substituição
atemp > 18
which(atemp > 18)
atemp[atemp > 18]
## verificando na matref
matref[which(atemp > 18), "valores"]
## substituindo temperaturas acima de 18 por 18
atemp[atemp > 18] <- 18
atemp

## ----Chunk410, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
## lista de dados heterogêneos
lst <- list(1:4, c(1.1, 2.3, 5.9), c(TRUE, FALSE), "R", list(0,1))
lst
## estrutura da lista
str(lst)
## tamanho da lista (num. de componentes ou elementos)
length(lst)
## atribuindo nomes a lista
names(lst) 
names(lst) <- c("vetor_int", "vetor_num", "logico", "char", "lista")

## ----Chunk411, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
## lista é recursiva?
is.recursive(lst)

## ----Chunk412, message=FALSE, comment="",prompt=FALSE, tidy=FALSE, echo=TRUE, eval=TRUE----
## matriz de dados meteorológicos da estação de Santa Maria
dados_sm <- cbind(tar = c(31, 35, 21, 23, 33, 17, 18, 16, 20, 25, 27, 30), 
                  prec = c(300, 200, 150, 120, 210, 110, 180, 140, 80, 160, 150, 100))
dados_sm
## lista com informações da estação de santa maria
sm_l <- list(c(-45, -23), 113, "Santa Maria", dados_sm)
sm_l
## adicionar nomes aos elementos
names(sm_l) <- c("coords", "alt", "cidade", "dados")
sm_l
## matriz de dados meteorológicos da estação de Júlio de Castilhos
dados_jc <- cbind(tar  = c(22.5, 20, 18.75, 18, 20.25, 17.75, 19.5, 18.5, 17, 19, 18.75, 17.5),
                  prec = c(360, 310, 285, 270, 315, 265, 300, 280, 250, 290, 285, 260))
jc_l <- list(coords = c(-45.1, -23.2),
             alt = 900,
             cidade = "Júlio de Castilhos",
             dados = dados_jc)
## adicionar nomes aos elementos
names(jc_l) <- names(sm_l)
jc_l

## ----Chunk413, message=FALSE, comment="",prompt=FALSE, tidy=FALSE, echo=TRUE, eval=TRUE----
## combinando listas mantendo os elementos separadamente
dados_l <- list(sm_l, jc_l)
dados_l
names(dados_l)
names(dados_l) <- c("sm", "jc")
dados_l
## como a lista é um tipo vetor, a função length() 
## fornece o número de elementos da lista
length(dados_l)

## ----Chunk414, message=FALSE, comment="",prompt=FALSE, tidy=FALSE, echo=TRUE, eval=TRUE----
str(dados_l)

## ----Chunk415, message=FALSE, comment="",prompt=FALSE, tidy=FALSE, echo=TRUE, eval=TRUE----
dados_l2 <- c(sm_l, jc_l)
dados_l2
str(dados_l2)

## ----chunck 420, message=FALSE, comment="",prompt=FALSE, tidy=FALSE, echo=TRUE, eval=TRUE----
sm_l[1:2]
sm_l[-(3:length(sm_l))]
sm_l[c(TRUE, TRUE, FALSE, FALSE, FALSE)]
sm_l[c("coords", "alt", "cidade")]

## ----chunck 421, message=FALSE, comment="",prompt=FALSE, tidy=FALSE, echo=TRUE, eval=TRUE, error=TRUE----
## seleção do 1º elemento da lst
lst[1]
## o resultado da seleção é uma lista
mode(lst[1])
## a função sum() espera como entrada um vetor
sum(lst[1])
## acessando elemento inexistente
lst[6]

## ----Chunk4220, message=FALSE, comment="",prompt=FALSE, tidy=FALSE, echo=TRUE, eval=TRUE----
## 1º elemento de sm_l
sm_l[[1]]
sm_l[["coords"]]
## modo de sm_l
mode(sm_l)
## ultimo elemento de sm_l
sm_l[[length(sm_l)]]
sm_l[["dados"]]
## subelementos
dados_l[["sm"]][["cidade"]]

## ----Chunk4221, message=FALSE, comment="",prompt=FALSE, tidy=FALSE, echo=TRUE, eval=TRUE----
## seleção de dados por nomes usando o símbolo $
dados_l$s
dados_l$j
dados_l$sm$dados
dados_l$sm$dados[5:8,1:2]
dados_l$sm$dados[, "tar"]
dados_l$sm$dados[, "tar", drop = FALSE]

## ----Chunk44, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
z <- vector(mode = "list")
## usando "[[" para criar os elementos que serão chamados a e b
z[[1]] <- 1:10
z[["b"]] <- "teste"
z
## usando "$" para criar o elemento chamado c
z$c <- c(F,T)

## ----Chunk45, message=FALSE, comment="",prompt=FALSE, tidy=FALSE, echo=TRUE, eval=TRUE----
vet <- 1:10
vet
vet.list <- as.list(vet)
vet.list
## desmanchando a lista
unlist(vet.list)
## deletando um elemento de uma lista
length(vet.list)
vet.list[8] <- NULL
vet.list
length(vet.list)

## ----Chunk46, message=FALSE, comment="",prompt=FALSE, tidy=FALSE, echo=TRUE, eval=TRUE----
sm_l
## ao inves da componente coords, criamos uma lon e lat
sm_l$lon <- sm_l$coords[1]
sm_l$lat <- sm_l$coords[2]
sm_l$coords <- NULL
sm_l
## convertendo para data.frame
sm_df <- data.frame(sm_l)
sm_df

## ----Chunk510, message=FALSE, comment="",prompt=FALSE, tidy=FALSE, echo=TRUE, eval=TRUE----
## criando um dataframe
dados.df <- data.frame(dates = c("2013-01-01", "2013-01-02", "2013-01-03", "2013-01-04", "2013-01-05", 
                                 "2013-01-06", "2013-01-07", "2013-01-08", "2013-01-09", "2013-01-10", 
                                 "2013-01-11", "2013-01-12", "2013-01-13", "2013-01-14", "2013-01-15"), 
                       cidade = rep("Santa Maria", 15),    
                       tar = c(31, 35, 21, 23, 33, 17, 18, 16, 34, 27, 15, 28, 22, 29, 32))  
dados.df
class(dados.df)
is.data.frame(dados.df)

## ----Chunk511, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
## Obtendo informações sobre o conjunto de dados
str(dados.df)

## ----Chunk512, message=FALSE, comment="",prompt=FALSE, tidy=FALSE, echo=TRUE, eval=TRUE----
## criando um dataframe
dados.df <- data.frame(dates = c("2013-01-01", "2013-01-02", "2013-01-03", "2013-01-04", "2013-01-05", 
                                 "2013-01-06", "2013-01-07", "2013-01-08", "2013-01-09", "2013-01-10", 
                                 "2013-01-11", "2013-01-12", "2013-01-13", "2013-01-14", "2013-01-15"), 
                       cidade = rep("Santa Maria", 15),    
                       tar = c(31, 35, 21, 23, 33, 17, 18, 16, 34, 27, 15, 28, 22, 29, 32),
                       stringsAsFactors = FALSE)  
str(dados.df)

## ----Chunk513, message=FALSE, comment="",prompt=FALSE, tidy=FALSE, echo=TRUE, eval=TRUE----
## resumo estatístico dos dados
summary(dados.df)

## ----Chunk520, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
## atributos
length(dados.df)
## número de colunas
ncol(dados.df)
## número de linhas
nrow(dados.df)
## dimensões
dim(dados.df)
## nomes podem ser atribuídos as linhas e as colunas
rownames(dados.df)
## novos nomes para as linhas de dados.df
rownames(dados.df) <- paste0("linha", rownames(dados.df))
dados.df
## removendo nomes das linhas
rownames(dados.df) <- NULL
dados.df
## mesmo que names(dados.df)
colnames(dados.df)
dimnames(dados.df)
attributes(dados.df)
class(attributes(dados.df))

## ----Chunk530, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE, error =TRUE----
## variáveis do dataframe
names(dados.df)
## acessando os dados de temperatura
dados.df[, 3]
## ou
dados.df[, "tar"]
## ou
dados.df$tar
is.vector(dados.df$tar)
## note a diferença no resultado da extração
dados.df["tar"]
class(dados.df["tar"])
dados.df[["tar"]]
class(dados.df[["tar"]])
dados.df[, "tar"]
class(dados.df[, "tar"])

## ----Chunk5310, message=FALSE, comment="",prompt=FALSE, echo=TRUE, eval=TRUE----
## acesso a variáveis de um data frame
with(data = dados.df, expr = tar)
tar_k <- with(data = dados.df, expr = tar + 273.15)
tar_k
with(data = dados.df, expr = plot(tar + 273.15))

## ----Chunk5320, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=FALSE----
## editar dados
fix(dados.df)
## inicializando um dataframe
x <- data.frame()
## digitando so dados
fix(x)

## ----Chunk540, message=FALSE, comment="",prompt=FALSE, tidy=TRUE, echo=TRUE, eval=TRUE----
## todos dados exceto o primeiro e último registro
dados.df[-c(1, nrow(dados.df)), ]
## temperatura dos primeiros 5 dias
dados.df[1:5, 3]
## temperatura no dia 2013-01-09
dados.df[dados.df$dates == "2013-01-09", "tar"]
## acrescentar uma nova variavel
dados.df$prec <- c(rep(0,5), 10, 18, 4, 0, 0, 5, 0, 0, 2, 0)
dados.df

## ----Chunk541, message=FALSE, comment="",prompt=FALSE, tidy=FALSE, echo=TRUE, eval=TRUE----
## subconjunto baseado em condição lógica
ss1 <- subset(dados.df, dates == "2013-01-09", select = "tar")
ss1
## subconjunto baseado em condição lógica
ss2 <- subset(dados.df, tar > 26 & prec > 0)
ss2
## subconjunto baseado em condição lógica
ss3 <- subset(dados.df, tar > 26 | prec > 0)
ss3
## subconjunto baseado em condição lógica
ss4 <- subset(dados.df, 
              dates %in% c("2013-01-09", "2013-01-13", "2013-01-15"), 
              select = -cidade)
ss4
## subconjunto baseado em condição lógica
ss4 <- subset(dados.df, 
              ! dates %in% c("2013-01-09", "2013-01-13", "2013-01-15"),
              select = -cidade)
ss4

## ----Chunk542, message=FALSE, comment="",prompt=FALSE, tidy=FALSE, echo=TRUE, eval=TRUE----
## mudança do dataframe, alteração de várias variáveis
dados.df <- transform(dados.df,
                      cidade = ifelse(1:nrow(dados.df) > 8, "Sao Sepe", cidade),
                      dates = c(dates[1:8], dates[1:7]),
                      anomalias = ifelse(cidade == "Santa Maria", 
                                         tar-mean(tar[cidade == "Santa Maria"]), 
                                         tar-mean(tar[cidade == "Sao Sepe"]))
            )
## alterar so uma variavel
dados.df$anomalias.norm = ifelse(dados.df$cidade == "Santa Maria", 
                                dados.df$anomalias/sd(dados.df$anomalias[dados.df$cidade == "Santa Maria"]), 
                                dados.df$anomalias/sd(dados.df$anomalias[dados.df$cidade == "Sao Sepe"]) )
dados.df

## ----Chunk550, message=FALSE, comment="",prompt=FALSE, echo=TRUE, eval=TRUE----
coords.df <- data.frame(lon = c(rep(-45, 8), rep(-45.1, 7)),  # longitudes
                        lat = c(rep(-23, 8), rep(-23.1, 7)))  # latitudes
d <- cbind(dados.df, coords.df)
d
## usando a própria função data.frame()
d2 <- data.frame(dados.df, coords.df, stringsAsFactors = FALSE)
d2
## verificando se os dois data frames são idênticos
identical(d, d2)
## dados de Caçapava
cacapava <- data.frame(dates = "2013-01-01", 
                       cidade = "Cacapava", 
                       tar = 19,
                       prec= 0,
                       anomalias = NA, 
                       anomalias.norm = NA,
                       lon = -45.1,
                       lat = -23.2)
d <- rbind(d, cacapava)
d

## ----Chunk551, message=FALSE, comment="",prompt=FALSE, echo=TRUE, eval=TRUE----
## convertendo lista para data frame
sm_l
sm_l_df <- as.data.frame(sm_l)
## convertendo array para data frame
v
v_df <- as.data.frame(v)
## convertendo vetor para data frame
temp90_df <- as.data.frame(temp90)
## convertendo matrix para data frame
mat_ex
mat_ex_df <- as.data.frame(mat_ex)
names(mat_ex_df)
## testes
is.data.frame(mat_ex_df)
class(v_df)
mode(v_df)

## ---- message=FALSE, comment="", prompt=FALSE, echo = FALSE, eval=FALSE----
# Exercícios
Descubra outras duas formas para criação de vetores.

