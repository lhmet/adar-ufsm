# Interface do Usuário
Jônatan Tatsch  
12-03-2015  




- - -

![](figs/adar.png)

- - -

# R no modo interativo

## Linha de comando do R

No Linux o R pode ser aberto simplesmente digitando em um terminal a letra `R`. A janela com a linha de comando do R apresenta o *prompt* do *R* (` > `). Após este símbolo digitamos os comandos, pressionamos a tecla `<enter>`, o R interpreta o comando e  retorna o resultado. Os comandos digitados na linha de comando são chamados de expressões. Esse é o modo iterativo do R. Portanto a linha de comando é a mais importante ferramenta do R, pois todas expressões são avaliadas através dela. 


```r
> 15 + 4
```

```
[1] 19
```

A expressão é avaliada pelo R, o resultado é mostrado, mas o seu valor é perdido.

O número entre colchetes que aparece como resultado da operação ("[1]" no caso acima) indica o conteúdo resultante da operação iniciando na posição 1 desse objeto. O significado dessa informação torna-se mais óbvio quando trabalhamos com objetos maiores, como por exemplo com vetores. Observe os valores nos colchetes para uma sequência de 1 até 100.


```r
> 1:100
```

```
  [1]   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17
 [18]  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34
 [35]  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51
 [52]  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68
 [69]  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85
 [86]  86  87  88  89  90  91  92  93  94  95  96  97  98  99 100
```

Pode ocorrer da expressão digitada na linha ser muito extensa e ir além de uma linha. Se a expressão estiver incompleta o R mostra um sinal de `+`.


```r
> 1 * 2 * 3 * 4 * 5 *
+ 6 * 7 * 8 * 9 * 10
```

```
[1] 3628800
```

Execute a expressão abaixo até o sinal de menos e digite `<enter>`. Enquanto a expressão não estiver completa o sinal de + se repetirá. Até que você digite o número que deseja subtrair de 4.


```r
> 4 -
+   
+   3
```

```
[1] 1
```

## Expressões em sequência

Podemos executar todas expressões anteriores em apenas uma linha, usando o ponto e vírgula  `;` para separar as expressões:


```r
> 15 + 4; 1:100; 1 * 2 * 3 * 4 * 5 *6 * 7 * 8 * 9 * 10; 4-3
```

```
[1] 19
```

```
  [1]   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17
 [18]  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34
 [35]  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51
 [52]  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68
 [69]  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85
 [86]  86  87  88  89  90  91  92  93  94  95  96  97  98  99 100
```

```
[1] 3628800
```

```
[1] 1
```

As expressões também podem ser separadas por uma nova linha (`<enter>`) entre cada um delas.


```r
> 15 + 4
```

```
[1] 19
```

```r
> 1:100
```

```
  [1]   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17
 [18]  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34
 [35]  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51
 [52]  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68
 [69]  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85
 [86]  86  87  88  89  90  91  92  93  94  95  96  97  98  99 100
```

```r
> 1 * 2 * 3 * 4 * 5 *6 * 7 * 8 * 9 * 10
```

```
[1] 3628800
```

```r
> 4-3
```

```
[1] 1
```

## Navegação entre as expressões já avaliadas

Você pode usar as teclas `para cima` e `para baixo` para navegar entre as expressões já avaliadas pelo R. O que é útil quando precisamos repetir um comando anterior com alguma mudança ou para corrigir um erro de digitação ou a omissão de um parentêses.

Quando a linha de comando é usada por muito tempo a sua tela pode ficar poluída com a saída das expressões anteriores. Para limpar a tela, digite `Ctrl+l`. Assim o console aparece na parte superior do terminal.


```r
> 15 + 4
> 1:100
> #digite <Ctr + l>
```

Para parar ou cancelar a execução de uma expressão utilize `Ctrl + C`.

## Comentários

No R, a cerquilha `#` (hashtag) é um caracter especial. Qualquer coisa após esse caracter será ignorado pelo R. Somente as expressões antes da `#` são avaliadas. Por meio desse símbolo de comentário podemos fazer anotações e comentários no código sem atrapalhar a interpretação das expressões pelo R.


```r
> # isso é um comentário
> 17 + 3 # adicionando 17 e 3
```

```
[1] 20
```

```r
> # 10 + 4
```

## Auto preenchimento de funções

O R inclui o preenchimento automático de nomes de funções e arquivos por meio da tecla `<tab>`. Uma lista de possíveis funções que começam com as letras inicialmente digitadas aparecerão.


```r
> read#<tab> pressione <tab> para ver as opções de comandos que iniciam com o termo read
```

# R no modo não interativo (*Batch*)

O uso da linha de comando do R é conveniente durante a análise de dados. Mas para algumas tarefas digitar cada comando pode se tornar incoveniente. Por exemplo, você precisa visualizar graficamente os padrões de variaçao temporal de três variáveis meteorológicas antes e após a passagem sistemas meteorológicos precipitantes.

Para esse propósito você precisará ler os dados da estação meteorológica (EM) que estão armazenados em um arquivo, fazer algumas conversões de unidades, plotar o gráfico com as séries temporais das variáveis e poderá salvá-lo em um arquivo `pdf`.

Suponha que você precise repetir esse processo para outras EM. Com o R, assim como em outras linguagem de programação, há uma forma de rodar um conjunto de comandos em sequência e salvar os resultados em um arquivo. Isso é possível através do modo **Batch**, ou seja a execução dos comandos sem inciar o R e sem a intervenção manual. 

Esse modo facilita a automatização de tarefas. Nesse caso, alterando apenas a variável que define o nome do arquivo da estação meteorológica, podemos reaplicar os mesmos comandos para outra EM.

Por exemplo, para rodar o script `gera_graficos.R`, sem abrir o R, utilizaríamos o comando:

~~~~~~~
$ R CMD BATCH gera_graficos.R
~~~~~~~

Podemos criar um arquivo texto chamado script1.R e digitar todos comandos dessa aula nele. 

~~~~~~~
$ cd /home/lsi/nomealuno
$ gedit script1.R &
~~~~~~~

Copie os comandos abaixo no arquivo recém criado no gedit.


```r
15 + 4
```

```
[1] 19
```

```r
1:100
```

```
  [1]   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17
 [18]  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34
 [35]  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51
 [52]  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68
 [69]  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85
 [86]  86  87  88  89  90  91  92  93  94  95  96  97  98  99 100
```

```r
1 * 2 * 3 * 4 * 5 *6 * 7 * 8 * 9 * 10
```

```
[1] 3628800
```

```r
4-3
```

```
[1] 1
```

```r
## salvando um gráfico da sequência de 1 a 100 em um arquivo pdf
pdf("plot_script1.pdf") # cria e abre um arquivo pdf
 plot(1:100)            # faz o gráfico
dev.off()               # fecha o arquivo pdf
```

```
png 
  2 
```

Rode o R em modo **Batch** informando o nome do script.

~~~~~~~
$ R CMD BATCH script1.R
~~~~~~~

O R rodará os comando dentro do arquivo especificado `script1.R` e criará um arquivo de saída chamado `script1.Rout` com os resultados. Você também pode especificar o nome do arquivo de saída.

~~~~~~~
$ R CMD BATCH script1.R saida_script1_`date "+%y%m%d"`.log
~~~~~~~

Para mais informações sobre rodar o R na linha de comando do Linux digite no terminal `$ R --help`.

## Rodando script de dentro do R

No modo iterativo, ou seja pela linha de comando, também é possível rodar comandos no modo *Batch* através da função `source()`.


```r
source("R/script1.R")
```

# RStudio


* Editor de texto
    * Abrindo/Criando um script
    * Rodando código por partes (Ctrl + `<enter>`)
        * Preenchimento do nome de funções `<tab>`
    * Rodando código inteiro
* Histórico de comandos
* Espaço de trabalho
* Linha de comando do R

* Menus
    * Tools > global options
        * mostrar linhas, alterar realce da sintaxe
    * Session
    * Plots


![Figura 1. Rstudio](figs/Rstudio_panels.png)



Próximo: [R básico](https://rawgit.com/jdtatsch/adar-ufsm/master/3_RBasico.html)
