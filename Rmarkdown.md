# Relatórios dinâmicos com R Markdown
Roilan Hernández Valdés e Jônatan Tatsch  
`r format(Sys.time(), '%d %B %Y')`  



- - -

![](figs/adar.png)

- - -

# Introdução {#introdução}

Este documento foi escrito em [R Markdown](http://rmarkdown.rstudio.com/), um sistema que combina uma sintaxe de formatação de texto simples (o [Markdown](http://daringfireball.net/projects/markdown/)) com trechos de códigos [R](http://www.r-project.org) que são avaliados e o resultado é incorporado no documento final. O documento pode ser criado nos formatos HTML, pdf ou Word.

O R Markdown está disponível no RStudio e sua implementação é baseada nos pacotes [knitr](http://yihui.name/knitr/) e [pandoc](http://pandoc.org/). As dos arquivos R Markdown é `.Rmd`. Um texto elaborado em R Markdown pode ser é produzido clicando-se no ícone `Knit HTML` ou pelo atalho `Ctr+Shift+K` no RStudio.

Os documentos R markdown podem ser disponibilizados na internet por meio do

- [Rpubs](https://rpubs.com/)

- [Github](https://github.com)

- [Dropbox](https://www.dropbox.com/) e etc.


# A essência do *R Markdown*

Pesquisa reproduzível é o conceito de divulgar documentos científicos incluindo os dados e os códigos utilizados (além do texto e dos gráficos) para que qualquer pessoa possa reproduzir os resultados e assim aperfeiçoar ou construir novos resultados a partir deles.

O R Markdown é um meio de fazer pesquisa reproduzível pela facilidade de se escrever textos que incorporam trechos de código R e de divulgar na internet . 

  - documento dinâmico reprodutível  = texto (descrição e interpretação dos resultados) + código (linguagem computacional) 


# Como usar o *R Markdown*

A idéia básica é que o texto seja intercalado com blocos ou trechos de código que são identificados de uma forma particular.

Por exemplo, para mostrar a expressão usada no R para instalar os pacotes `rmarkdown` e `gcookbook`, digitamos o seguinte trecho no corpo do texto do arquivo `.Rmd` criado no RStudio. 



````
```{r}
install.packages('rmarkdown', dependencies = TRUE)
install.packages('gcookbook', dependencies = TRUE)
```                                              
                                                 
````

O texto acima aparecerá da seguinte forma no documento `html`:


```r
install.packages('rmarkdown', dependencies = TRUE)
install.packages('gcookbook', dependencies = TRUE)
```

Os trechos de código (*chuncks*) são avaliados pelo R na ordem em que eles aparecem. Os objetos criados criados em um *chunck* permanecem disponíveis no ambiente para uso em chuncks posteriores. O código no *chunck* é destacado de forma diferente do texto. Os resultados (tabelas, gráficos e outros objetos) gerados pelo código de um *chunck* também são incorporados no documento.

Nesse documento mostramos os principais elementos do ***Markdown*** e como construir os ***chunks***.
 

# Inserir código R no documento.

Um *chunk* tem a seguinte estrutura: 


````
```{r chunck1}
Aqui vai o código em R
```
````

## Opções do **Chunk**

 Cada *chunk* possui parâmetros que permitem definir opções de execução para aquele *chunck*, as principais são as seguintes:
 
  *  `chunk1` identificador (ID) do *chunk* que permite encontrar ele mais fácil se ocorrer algum erro (opcional) durante a geração do documento.    
  *  `eval = TRUE` opção para executar o *chunk* quando compilar o documento (*default* TRUE).     
  *  `cache=TRUE`  opção que permite ao *chunk* guardar os dados uma vez calculados (*default* FALSE).    
  *  `message = TRUE`  mostra as mensagens de erro (*default* TRUE).   
  *  `echo = TRUE`  se FALSE permite eliminar as saídas do chunk (*default* FALSE).   
  
  O resto das opções são mostradas ao pressionar a tecla `tab` com o mouse posicionado dentro dos colchetes da linha do **chunk**. Para uma lista completa os parâmetros do *chunck* consulte <http://yihui.name/knitr/options/>.


````
```{r chunk2, eval=TRUE, message = TRUE, echo = TRUE}
letters
## letras em maiúsculo
LETRAS <- toupper(letters)
LETRAS
x <- LETRAS[LETRAS %in% c('U', 'F', 'S', 'M')]
x
```
````

O *chunck2* será impresso da seguinte forma:


```r
letters
```

```
##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q"
## [18] "r" "s" "t" "u" "v" "w" "x" "y" "z"
```

```r
## letras em maiúsculo
LETRAS <- toupper(letters)
LETRAS
```

```
##  [1] "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q"
## [18] "R" "S" "T" "U" "V" "W" "X" "Y" "Z"
```

```r
x <- LETRAS[LETRAS %in% c("U", "F", "S", "M")]
x
```

```
## [1] "F" "M" "S" "U"
```
 

## Saídas dos **chunks**

Os resultados dos *chuncks* podem ser mostrados na forma de figuras, tabelas e textos.


````
```{r, warning=FALSE, message=FALSE,comment=''}
    # carregando a pacote 'ggplot2' para gráficos elegante
    library(ggplot2)
    # pacote que contém conjunto de dados de temperatura
    library(gcookbook)
    # Mostrando as primeiras linhas da tabela 'climate' que pertenece ao pacote
    head(climate)
    # Usando a função qplot() para plotar a série de temperatura global
    qplot(x = Year, y = Anomaly1y, data = climate) + geom_smooth()
    # Usando apenas a função plot()
    plot(x = climate$Year, y = climate$Anomaly1)
    # regressão linear
    reg <- lm(Anomaly1y ~ Year, data = climate)
    # extraindo o coeficiente angular (°C/ano) da reta
    # convertendo para °C/100 anos
    tendencia <- coef(reg)[2] * 100
```
````





```r
    # Carregando a pacote 'ggplot2' para gráficos elegante
    library(ggplot2)
    # pacote que contém conjunto de dados de temperatura
    library(gcookbook)
    # Mostrando as primeiras linhas da tabela 'climate' que pertenece ao pacote
    head(climate)
```

```
    Source Year Anomaly1y Anomaly5y Anomaly10y Unc10y
1 Berkeley 1800        NA        NA     -0.435  0.505
2 Berkeley 1801        NA        NA     -0.453  0.493
3 Berkeley 1802        NA        NA     -0.460  0.486
4 Berkeley 1803        NA        NA     -0.493  0.489
5 Berkeley 1804        NA        NA     -0.536  0.483
6 Berkeley 1805        NA        NA     -0.541  0.475
```

```r
    # Usando a função qplot() para plotar a série de temperatura global
    qplot(x = Year, y = Anomaly1y, data = climate) + geom_smooth()
```

![](figs/chunck4-1.png)

```r
    # Usando apenas a função plot()
    plot(x = climate$Year, y = climate$Anomaly1y) 
```

![](figs/chunck4-2.png)

```r
    # regressão linear
    reg <- lm(Anomaly1y ~ Year, data = climate)
    # extraindo o coeficiente angular (°C/ano) da reta
    # convertendo para °C/100 anos
    tendencia <- coef(reg)[2] * 100
    tendencia
```

```
     Year 
0.5929518 
```

Podemos fazer outro *chunk* para mostrar as tabelas.


````
```{r}
    # pacote com a função kable para saída de tabelas
    library(knitr)
    # Aplicando a função 'summary()' ao dataframe airquality.
    s <- summary(airquality)
    # Convertendo o formato da saída das tabelas
    kable(s, caption = 'Tabela 1: Resumo estatístico dos de qualidade do ar')
```
````



```r
# pacote com a função kable para saída de tabelas
library(knitr)
# pacote com dados de temperatura global
library(gcookbook)
# Aplicando a função 'summary()' ao dataframe airquality.
s <- summary(airquality)
# Convertendo o formato da saída das tabelas
kable(s, caption = "Tabela 1: Resumo estatístico dos dados de 'qualidade do ar' de NY")
```



Table: Tabela 1: Resumo estatístico dos dados de 'qualidade do ar' de NY

         Ozone           Solar.R           Wind             Temp           Month            Day     
---  ---------------  --------------  ---------------  --------------  --------------  -------------
     Min.   :  1.00   Min.   :  7.0   Min.   : 1.700   Min.   :56.00   Min.   :5.000   Min.   : 1.0 
     1st Qu.: 18.00   1st Qu.:115.8   1st Qu.: 7.400   1st Qu.:72.00   1st Qu.:6.000   1st Qu.: 8.0 
     Median : 31.50   Median :205.0   Median : 9.700   Median :79.00   Median :7.000   Median :16.0 
     Mean   : 42.13   Mean   :185.9   Mean   : 9.958   Mean   :77.88   Mean   :6.993   Mean   :15.8 
     3rd Qu.: 63.25   3rd Qu.:258.8   3rd Qu.:11.500   3rd Qu.:85.00   3rd Qu.:8.000   3rd Qu.:23.0 
     Max.   :168.00   Max.   :334.0   Max.   :20.700   Max.   :97.00   Max.   :9.000   Max.   :31.0 
     NA's   :37       NA's   :7       NA               NA              NA              NA           
 
 
 
## Códigos R dentro de linhas

Podemos usar o R em expressões dentro de uma linha de texto, para mostrar o valor de uma variável ou efetuar um cálculo. Por exemplo, para obtermos o valor resultante de 2 + 2 escrevemos \` r 2 + 2 \` e o R colocará o resultado naquela posição do texto.

Por exemplo, a sentença:

* A tendência da temperatura do ar média global é de \` r round(tendencia, 2) \` °C/100 anos.

ficará

* A tendência da temperatura do ar média global é de 0.59 °C/100 anos.

Assim como,

* A média de uma sequência de números inteiros 1 até 10 é \` r mean(1:10) \`.

ficará:

* A média de uma sequência de números inteiros de 1 até 10 é 5.5.
 
 
    
# Markdown

## Cabeçalhos

  **Cabeçalhos** (ou *headers* em inglês) são definidos para construção do índice de seções ou capítulos do documento (*table of content, TOC*) que são 'lincados' às seções.
  
```
 # Seção - nível 1
 ## Subseção - nível 2 
 ### Subsubseção - nível 3
 e assim por diante
 ...
```

 

## Parágrafos
 
  Um parágrafo é uma ou mais linhas de texto, seguido de uma ou mais linha em branco. 
  
  
  **Novas linhas são tratadas como espaços**, para que possa organizar seus parágrafos como você gosta. 
  
  
  Se você precisar de uma quebra de linha, insira **dois ou mais espaços no final de uma linha**.


 
- - -


## Aparência

A aparência e formato do documento final impresso é definido por parâmetros definido no cabeçalho texto escrito no arquivo `.Rmd`. Veja no exemplo abaixo, onde são definidos parâmetros para o formato de saída do arquivo (`output: html_document`), a inclusão de índice (`toc = TRUE`), opções para figuras (`fig_width: 7`, `fig_height: 6`, `fig_caption: true`), a opção para realce da sintaxe do código R (`highlight: tango`), o tema do `html` (`theme: united`). Para mais informações consulte <http://rmarkdown.rstudio.com/markdown_document_format.html>.

```python   
    ---
    title: "Meu novo projeto"
    author: Nome Sobrenome
    output:
         html_document:
            theme: united [default, cerulean, journal, flatly, readable, spacelab, united, cosmo]
            highlight: tango [default, tango, pygments, kate, monochrome, espresso, zenburn, haddock, textmate]
            number_sections: true
            toc: true
            fig_width: 7
            fig_height: 6
            fig_caption: true
    ---
```

 

## Blocos de códigos sem execução (*Verbatim*)

Para inserir um trecho de código de uma linguagem de programação é preciso inserir 4 espaços antes das linhas de código.


```
  ```fortran
          if ( a .lt. 3) then
            write(*,*) y,w
          end if  
  ```
```


O código impresso no `html` aparecerá da seguinte forma:

```fortran
    if ( a .lt. 3) then
      write(*,*) y,w
    end if  
```

 

## Listas

Para produzir uma lista são usados os símbolos: `+` , `*` , `-`.
Uma lista suporta vários níveis de subitens. Os subitens devem separados por quatro espaços ou um *tab*.

```
 * um
     - subitem
 * dois
     - subitem
         - subsubitem
 * três
```
 * um
     - subitem
 * dois
     - subitem
         - subsubitem
 * três

## Linhas horizontais
 
 
 
 Para inserir uma linha horizontal pode-se usar:

```md
 
 * * *
 
 ou
 
 - - -
 
```

que será impresso como

- - -

ou

***

É importante notar a quebra de linha entre cada linha de caracteres.


## Citações diretas

> É eRRando que se aprende R. (Jônatan Tatsch)

## Tabelas

 As tabelas devem ter uma linha para cada fila, com alinhamento definido pela posição relativa a linha pontilhada dos nomes das colunas. A descrição da tabela precisa ter o formato `Table:` ou apenas `:`, a posição definida é acima da tabela.



```
  direita     esquerda   Centro    Default
  -------     ------   ---------   -------
       12     12          12           12
      123     123         123         123
        1     1            1            1
  Table:  Tabela 1. Demonstração da sintaxe para uma tabela.
```

direita     esquerda   Centro    Default
-------     ------   ---------   -------
     12     12          12           12
    123     123         123         123
      1     1            1            1

Table: Tabela 1.  Demonstração da sintaxe para uma tabela.
 


```
  : Amostra de tabela com grades.
                                 
  +---------------+---------------+--------------------+
  | Fruit         | Price         | Advantages         |
  +===============+===============+====================+
  | Bananas       | $1.34         | - built-in wrapper |
  |               |               | - bright color     |
  +---------------+---------------+--------------------+
  | Oranges       | $2.10         | - cures scurvy     |
  |               |               | - tasty            |
  +---------------+---------------+--------------------+
```
 
: Amostra de tabela com grades.

+---------------+---------------+--------------------+
| Fruit         | Price         | Advantages         |
+===============+===============+====================+
| Bananas       | $1.34         | - built-in wrapper |
|               |               | - bright color     |
+---------------+---------------+--------------------+
| Oranges       | $2.10         | - cures scurvy     |
|               |               | - tasty            |
+---------------+---------------+--------------------+

Um recurso para construir tabelas em Markdown é o [gerador de tabelas](http://www.tablesgenerator.com/markdown_tables) que permite montar a tabela e criar o código para você colá-lo no seu documento `.Rmd`.

 

## Ênfase de texto 

Para destacar texto usa-se geralmente as palavras em _itálico_ (`_itálico_` ou `*itálico*`) ou em **negrito** (`__negrito__` ou `**negrito**`). 
 
Um texto sobrescrito 2^10^ é escrito `2^10^` e o subscrito (H~2~O) da forma `H~2~O`.

 
 
## Links

Para incluir link de um site é só colocar o endereço web entre `< >`:

```
<http://google.com>

<sam@green.eggs.ham>
```
<http://google.com>

<sam@green.eggs.ham>

 Podemos associar um link a uma sentença, da seguinte forma:
 
 "O _R Markdown_  possui ampla documentação, veja o [cartão de referência](http://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf) e o [site oficial](http://rmarkdown.rstudio.com/))". 
 
 
```
Aqui temos um [link](http://cran.r-project.org/doc/contrib/Short-refcard.pdf) que  podemos expressar também incluindo um rótulo [cartão de referência](http://cran.r-project.org/doc/contrib/Short-refcard.pdf "Manter esse Cartão de referência para consultas") que aparecerá ao passarmos o *mouse* sobre o link.
```

Podemos criar um link incluindo um rótulo [cartão de referência](http://cran.r-project.org/doc/contrib/Short-refcard.pdf "Manter esse Cartão de referência para consultas") que aparecerá ao passarmos o *mouse* sobre o link.


## Figuras

Para a inserir figuras o procedimento é quase o mesmo de um link, só que precedido pelo  símbolo `!`.

Vamos criar um link para o endereço da imagem:

```
[Cachoeira do Abade](http://upload.wikimedia.org/wikipedia/commons/c/c5/Cachoeira_do_Abade_AGO_2008.jpg)

```

[Cachoeira do Abade](http://upload.wikimedia.org/wikipedia/commons/c/c5/Cachoeira_do_Abade_AGO_2008.jpg)

Ao acrescentarmos o símbolo `!` no início, obtemos a imagem no documento.

```md
![Cachoeira do Abade](http://upload.wikimedia.org/wikipedia/commons/c/c5/Cachoeira_do_Abade_AGO_2008.jpg)
```

![Figura 1. Cachoeira do Abade](http://upload.wikimedia.org/wikipedia/commons/c/c5/Cachoeira_do_Abade_AGO_2008.jpg)

O procedimento para inserir figuras do seu computador é o mesmo, só altera-se o endereço pelo caminho até o arquivo.

 

## Expressões matemáticas

 Nossa área de estudo geralmente requer análises baseadas em equações. Para inserir expressões matemáticas no _R Markdown_ é da mesma forma usada em [Latex](http://pt.wikipedia.org/wiki/LaTeX). 
 
 Para expressões dentro de uma linha as equações são escritas entre os símbolos `$ $`, por exemplo, $y=f(x)$ foi gerada com `$y=f(x)$`. 
Mas se a equação for muito complexa é melhor colocá-la sozinha entre parágrafos de texto, duplicando o mesmo símbolo `$$ $$`, exemplo:

```tex

 $$\psi = \psi_e \left(\dfrac{\theta}{\theta_s}\right)^{-b}$$
 
```
produz:

  $$\psi = \psi_e \left(\dfrac{\theta}{\theta_s}\right)^{-b}$$

- - -

Há também um [Editor online de equações](http://www.codecogs.com/latex/eqneditor.php?lang=pt-br) que fornece uma interface para escrever a equação e o código gerado pode ser colado no seu documento.
 


# Simulação da resolução de uma Lista de exercícios.

A resolução das listas do curso deverão ser entregues no formato R Markdown. O arquivo `.Rmd` deverá ser publicado no [Rpubs](https://rpubs.com/) e o link enviado por e-mail. O documento deve conter a identificação do aluno, o enunciado de cada questão seguido da resolução que deve incluir o código utilizado, comentários, a descrição  e interpretação dos resultados quando for o caso.

Vamos fazer um documento `.Rmd` simulando a resolução da lista de exercícios abaixo.

## Exemplo de solução de lista de exercícios.

  1. Gere um vetor `x` que varia de -100 até 100, com intervalo de 0,5. 

  2. Gere uma variável `A` que resulta do seno de uma sequência numérica de -1 até 1 com mesmo tamanho do vetor `x` da questão anterior. 

  3. Calcule o vetor $y = exp(-0.07Ax)cos(x+\frac{\pi }{2}))$. 

  4. Faça um gráfico do tipo linha relacionando as duas variáveis.

# Referências para aprender mais sobre o R Markdown
 
 * [Documentos dinâmicos no R](http://rmarkdown.rstudio.com/)
 * [Tutorial mínimo sobre R Markdown](http://kbroman.org/knitr_knutshell/) 
 * [Manual do knitr](https://github.com/yihui/knitr/releases/download/doc/knitr-manual.pdf)
 * [Principal referência para Markdown](http://daringfireball.net/projects/markdown/)
 * [Guia rápido expressões matemáticas](ftp://ftp.ams.org/pub/tex/doc/amsmath/short-math-guide.pdf)
 * [Notação matemática](http://rstudio-pubs-static.s3.amazonaws.com/18858_0c289c260a574ea08c0f10b944abc883.html)
 * [Cartão de referência para expressões matemáticas-latex](http://elevatorlady.ca/doc/refcard/expressions.html)
 * [latex-mathjax](http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference) 
 * [latex em R Markdown](http://www.calvin.edu/~rpruim/courses/m343/F12/RStudio/LatexExamples.html)
 * [Citações e referências bibliográficas](https://cran.r-project.org/web/packages/knitcitations/index.html)
 
