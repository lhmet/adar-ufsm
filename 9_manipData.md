# Processamento de dados
Jônatan Tatsch  
`r format(Sys.Date(), format = '%d-%m-%Y')`  




- - -

![](figs/adar.png)

- - -



# Introdução

A etapa seguinte após a leitura e a preparação dos dados é o processamento de dados. Esta etapa inclui ações como a criação de novas variáveis, a seleção dos dados para o período de interesse, o levantamento de dados faltantes, controle de qualidade e a análise de dados. Nesta seção você vai conhecer o pacote [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html) que oferece um grupo de funções que resolverá os problemas mais comuns de manipulação de dados. 

# Pré-requisitos

Pacotes necessários:


```r
library(lubridate)
library(dplyr)
library(openair)
library(devtools)
library(EDAWR) # install_github("rstudio/EDAWR")
library(tibble)
```

Dados



# Funcionalidade do `dplyr`

* 5 verbos básicos: 
  - `filter`
  - `select`
  - `arrange`
  - `mutate`
  - `group_by` e `summarise` 
  
* Can work with data stored in databases and [data tables](http://datatable.r-forge.r-project.org/)
* Joins: inner join, left join, semi-join, anti-join (not covered below)
* Window functions for calculating ranking, offsets, and more
* [Better than plyr](http://blog.rstudio.org/2014/01/17/introducing-dplyr/) if you're only working with data frames (though it doesn't yet duplicate all of the plyr functionality)
* Examples below are based upon the [latest release](https://github.com/hadley/dplyr/releases), version 0.2 (released May 2014)



