Análise de dados ambientais com R (ADAR)
========================================================
width: 1440
height: 900
transition: none
font-family: 'Helvetica'
css: my_style.css
author: Jonatan Tatsch, UFSM
date: Santa Maria, 13, março de 2018
#date: Santa Maria, 7, de março de 2016

</style>
<div class="midcenter" style="margin-left:5px; margin-top:100px;">
<img src="figs/logo_ufsm.png" height="400px" width="3000px" />
</div>


Introdução
=======================

## Análise de dados meteorológicos 

> <span style="color:black; font-size:1.25em;">Processo pelo qual adquire-se conhecimento, compreensão e percepção dos fenômenos meteorológicos a partir de observações (dados) qualitativas e quantitativas.</span>

</style>
<div class="midcenter" style="margin-left:250px; margin-top:50px;">
<img src="figs/TB1.jpg" height="600px" width="800px" />
</div>

<br/>


Ciência de dados
========================================================

</style>
<div class="midcenter" style="margin-left:250px; margin-top:50px;">
<img src="figs/datascience.png" height="800px" width="1000px" />
</div>


Etapas para abordagem de um problema 
=======================

 1. **Questão científica/problema**
<br/>
 2. **Obtenção de dados:** coleta/medida do(as) estado/condições da atmosfera
    - Instrumentos e sensores
<br/>
 3. **Processamento de dados:**
    *download* ---> limpeza ---> formatação ---> <br/>
     transformação ---> controle de qualidade
       - ferramenta/software
         - <span style="color: red">conhecimento em programação</span>
 4. **Análise de dados**
    - ferramenta/software
      - <span style="color: red">conhecimento em programação</span>
 5. **Solução para o problema** 
    - Proposta de um modelo 
      - estatístico, empírico, ou fisicamente baseado
    - <span style="color: red">conhecimento em programação</span>
<br/> 
 6. **Apresentação/divulgação/publicação**



Programação computacional
=======================

</style>
<div class="midcenter" style="margin-left:80px; margin-top:50px;">
<img src="figs/mas_escolhas.jpg" height="600px" width="1200px" />
</div>

</style>
<div class="midcenter" style="margin-left:80px; margin-top:60px;">
<img src="figs/errando_aprende.png" height="100px" width="1100px" />
</div>

   
=======================
</style>
<div class="midcenter" style="margin-left:30px; margin-top:10px;">
<img src="figs/Rlogo.svg" height="200px" width="250px" />
</div>


* [R](https://www.r-project.org/) é o termo usado para se referir a linguagem de programação e ao software que interpreta os scripts escritos usando esta linguagem.

 

* Comunidade fantástica

  - [Contribuidores](https://www.r-project.org/contributors.html) (R-core Team)

  - milhares de pessoas usam o R diariamente e ajudam outras pessoas


* **Software Livre** (GPL), [Código aberto](https://github.com/wch/r-source) e multiplataforma
<br/> 
* Ambiente para Análise de dados interativa

Por que o R?
=======================
<br/> 

* [R](https://www.r-project.org/) não é uma GUI (Interface gráfica do usuário) e isso é bom
<br/> 

  - há uma natural resistência e dificuldade ao uso de códigos e scripts
<br/> 

  - scripts favorecem a **automatização** e **reprodutibilidade**
<br/> 

  - força você a ter um conhecimneto mais aprofundado do que está fazendo

-----------------
<br/> 
* [Reprodutibilidade](https://pt.wikipedia.org/wiki/Reprodutibilidade)
<br/> 
  - qualquer pessoa (inclusive você mesmo no futuro) pode obter os mesmos resultados do mesmo conjunto de dados
<br/>  
  - R é integrado com [outras ferramentas](https://cran.r-project.org/web/views/ReproducibleResearch.html) de que permitem atualizar seus resultados, figuras e análises automaticamente
<br/>   

  - [Relatório dinâmicos](https://rmarkdown.rstudio.com/articles_intro.html) e [interativos](http://shiny.rstudio.com/)


Por que o R?
=======================
<br/> 
- Acesso ao estado da arte da ciência de dados (*Big Data*, *Data Mining*, *Machine Leraning*)

<br/>  

- Interface com Fortran, C, C++, Python

<br/>  

- [Visualização de dados](https://cran.r-project.org/web/views/Graphics.html)

  - R produz [gráficos de alta qualidade](https://timogrossenbacher.ch/2016/12/beautiful-thematic-maps-with-ggplot2-only/)

<br/> 

-----------------
<br/> 
- R trabalha com dados de todas formas e tamanhos 

<br/> 

- Extensões para [Manipulação de dados](http://blog.rstudio.org/2014/07/22/introducing-tidyr/)
<br/>  




Pacotes da comunidade do R
====================================
Evolução do nº de pacotes disponíveis no [CRAN](http://cran.r-project.org/mirrors.html)
</style>
<div class="midcenter" style="margin-left:250px; margin-top:50px;">
<img src="figs/number-of-submitted-packages-to-CRAN.png" height="700px" width="800px" />
</div>



Por que um meteorologista usaria o R?
=======================
<br/>  
A meteorologia é 4D: 

```r
meteorologia <- function(x, y, z, t){
  ...muita coisa para caber em um slide...
}
```
<br/>  
Logo, requer ferramentas específicas para:
<br/>  
* manipulação de dados espacias
<br/>  
* análise de séries temporais
<br/>  
* importação e ferramentas de [SIG](https://pt.wikipedia.org/wiki/Sistema_de_informa%C3%A7%C3%A3o_geogr%C3%A1fica)
<br/>  
* leitura de dados em formatos específicos ([netcdf](https://en.wikipedia.org/wiki/NetCDF), [binários](https://en.wikipedia.org/wiki/Binary_file), [grib2](https://en.wikipedia.org/wiki/GRIB), ...)




R não é perfeito!
========================================================
<br/>  
* Muitos códigos em R são escritos para resolver um problema;
  * foco nos resultados e não no processo
  * usuários não são programadores
  * códigos deselegantes, lentos e difíceis de entender
<br/>  
* Como o nosso idioma, há muitas exceções para serem lembradas
<br/>  
* R não é muito rápido e códigos mal escritos serão lentos
<br/>  
* São apenas ~20 anos de evolução
<br/>  
* Há muito o que melhorar


RStudio
=======

[RStudio](https://www.rstudio.com/) é um **ambiente de desenvolvimento integrado** livre e de código aberto. 

![RStudio IDE](figs/screenshot_rstudio.png)

-------------
- Multiplataforma (Windos, Linux e Mac)
<br/>  
- ênfase da sintaxe do R, auto-preenchimento de código, identação inteligente
<br/>  
- execução do R diretamente do editor
<br/>  
- manejo de diretórios e projetos
<br/>  
- histórico de gráficos, zoom, atalhos para exportar imagens 
<br/>  
- Integrado com [knitr](https://en.wikipedia.org/wiki/Knitr)
<br/>  
- Integrado com [GitHub](https://github.com/) para controle de versões






=======================
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<span style="color:black; font-size:1.7em;">Material do curso disponível no [GitHub](https://github.com/jdtatsch/adar-ufsm) </span>

Para saber mais sobre o R
=======================
<br/>
[**Documentação oficial**](http://cran.r-project.org/manuals.html)
<br/>
<br/>
[**Livros relacionados ao R**](http://www.r-project.org/doc/bib/R-books.html)
- [Livros gratuitos](https://github.com/vhf/free-programming-books/blob/master/free-programming-books.md#r)
<br/>
<br/>

**Fóruns:** 
- lista Brasileira de discussão do programa R: [**R-br**](https://listas.inf.ufpr.br/cgi-bin/mailman/listinfo/r-br)
- [stackoverflow](http://stackoverflow.com/questions/tagged/r)
<br/>
<br/>
<br/>
<br/>
<br/>
Próximo: [Instalando o R e Rstudio](https://rawgit.com/jdtatsch/adar-ufsm/master/1_Rinstall.html)

Bibliografia 
=======================

**Básica**

R FOR DATA SCIENCE. Garret Grolemund, Hadley Wickham. Chambers (O’Reilly). 2016.

EFFICIENT R PROGRAMMING. Colin Gillespie and Robin Lovelace.  (O’Reilly). 2016.


R IN A NUTSHELL, A Desktop Quick Reference. 2nd Edition. (O’Reilly). 2012.

DISLAYING TIME SERIES, SPATIAL AND SPACE-TIME DATA WITH R. Oscar Lamigueiro. (CRS PRESS). 2014.

-------------

**Complementar**

HANDS-ON PROGRAMMING WITH R. 1998.Garret Grolemund (O'Reilly).

TIME SERIES ANALYSIS AN WITH APPLICATIONS IN R. 2008 Cryer J.D. & Chan K.S. (Springer)

MODERN OPTIMIZATION WITH R. Paulo Cortez (Springer). 2014

ADVANCED R. Hadley Wickham. (O’Reilly). 2015.

SIMULATION OF ECOLOGICAL AND ENVIRONMENTAL MODELS. Miguel Acevedo. 2012. CRC Press.
