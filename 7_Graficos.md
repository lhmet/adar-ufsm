# Gráficos
Jônatan Tatsch  
28-05-2015  



- - -

![](figs/adar.png)

- - -


```r
> ## fecha janela gráfica
> graphics.off()
> # pacotes para R markdown
> require(printr)
> require(pander)
```

# Pré-requisitos

## Pacotes

Para reproduzir os gráficos da aula de hoje precisamos instalar os seguintes pacotes gráficos:


```r
# instalação de pacotes install.packages('lattice', dependencies = TRUE)
# install.packages('latticeExtra', dependencies = TRUE)
# install.packages('ggplot2', dependencies = TRUE)
# install.packages('gcookbook', dependencies = TRUE)
# install.packages('psych', dependencies = TRUE)
```

Vamos carregá-los, para ter acesso as funções dos pacotes.


```r
# carregando pacotes
pacotes <- c("lattice", "latticeExtra", "ggplot2", "gcookbook", "psych")
sapply(pacotes, require, character.only = TRUE, quietly = TRUE)
```

```
     lattice latticeExtra      ggplot2    gcookbook        psych 
        TRUE         TRUE         TRUE         TRUE         TRUE 
```


```r
# informações da seção, pacotes carregados
sessionInfo()
```

```
R version 3.2.1 (2015-06-18)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 14.04.3 LTS

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
 [3] LC_TIME=pt_BR.UTF-8        LC_COLLATE=en_US.UTF-8    
 [5] LC_MONETARY=pt_BR.UTF-8    LC_MESSAGES=en_US.UTF-8   
 [7] LC_PAPER=pt_BR.UTF-8       LC_NAME=C                 
 [9] LC_ADDRESS=C               LC_TELEPHONE=C            
[11] LC_MEASUREMENT=pt_BR.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] psych_1.5.6         gcookbook_1.0       ggplot2_1.0.1      
 [4] pander_0.5.2        printr_0.0.4        rasterVis_0.35     
 [7] latticeExtra_0.6-26 RColorBrewer_1.1-2  lattice_0.20-33    
[10] raster_2.4-15       sp_1.1-1            dplyr_0.4.2        
[13] plyr_1.8.3          stringr_1.0.0       lubridate_1.3.3    
[16] magrittr_1.5        R.utils_2.1.0       R.oo_1.19.0        
[19] R.methodsS3_1.7.0   knitcitations_1.0.6 knitr_1.10.5       

loaded via a namespace (and not attached):
 [1] Rcpp_0.12.0       formatR_1.2       bitops_1.0-6     
 [4] tools_3.2.1       digest_0.6.8      gtable_0.1.2     
 [7] evaluate_0.7      memoise_0.2.1     bibtex_0.4.0     
[10] DBI_0.3.1         yaml_2.1.13       parallel_3.2.1   
[13] hexbin_1.27.0     proto_0.3-10      RefManageR_0.8.63
[16] httr_1.0.0        grid_3.2.1        R6_2.1.0         
[19] XML_3.98-1.3      rmarkdown_0.7     RJSONIO_1.3-0    
[22] reshape2_1.4.1    MASS_7.3-43       scales_0.2.5     
[25] htmltools_0.2.6   mnormt_1.5-3      assertthat_0.1   
[28] colorspace_1.2-6  stringi_0.5-5     munsell_0.4.2    
[31] RCurl_1.95-4.7    zoo_1.7-12       
```

## Dados

Para gerar gráficos precisamos de alguns dados. Vamos criar e carregar os dados que serão utilizados para mostrar as funções gráficas disponíveis no R.

  + simulando dados de uma oscilação com amplitude variável
  

```r
x1 <- seq(from = -100, to = 100, by = 0.05)
A <- sin(seq(from = -1, to = 1, length.out = length(x1)))
 y1 <- (exp(-0.07*A*x1)*cos(x1+pi/2))
  dados <- data.frame(x1, y1)
  head(dados)
```

      x1           y1
--------  -----------
 -100.00   -0.0014007
  -99.95   -0.0015255
  -99.90   -0.0016477
  -99.85   -0.0017669
  -99.80   -0.0018827
  -99.75   -0.0019949

  + Dados de qualidade do ar em NY


```r
#help(airquality)
head(airquality)
```



 Ozone   Solar.R   Wind   Temp   Month   Day
------  --------  -----  -----  ------  ----
    41       190    7.4     67       5     1
    36       118    8.0     72       5     2
    12       149   12.6     74       5     3
    18       313   11.5     62       5     4
    NA        NA   14.3     56       5     5
    28        NA   14.9     66       5     6

```r
# conversão da Temp de Farenheith para Celsius
airquality$Temp <- (airquality$Temp - 32)/5
# dataframe sem as colunas Month e Day
aq <- subset(airquality, select = -c(Month, Day))
# adicionando coluna date criada das colunas Day e Month
# o ano das medidas é 1973, conforme help
aq$date <- as.Date(paste(airquality$Day, 
                         airquality$Month, 
                         "1973"), 
                   format = "%d %m %Y")
# date como 1a coluna
aq <- data.frame(date = aq[,"date"], aq[, -ncol(aq)])
head(aq)
```



date          Ozone   Solar.R   Wind   Temp
-----------  ------  --------  -----  -----
1973-05-01       41       190    7.4    7.0
1973-05-02       36       118    8.0    8.0
1973-05-03       12       149   12.6    8.4
1973-05-04       18       313   11.5    6.0
1973-05-05       NA        NA   14.3    4.8
1973-05-06       28        NA   14.9    6.8

  + Séries de dados aleatórios acumulados (**random walk**)


```r
# matriz de dados para 5 plots
# semente para reprodutibilidade
set.seed(12)
# laço para gerar uma matriz de 5 colunas
# com números aleatórios acumulados 
mat <- sapply(1:5, function(i) cumsum(rnorm(100)))
head(as.data.frame(mat))
```

         V1         V2          V3          V4           V5
-----------  ---------  ----------  ----------  -----------
 -1.4805676   1.926719   -2.986456   -1.481392    0.0871258
  0.0966019   1.978149   -3.037003   -2.411725   -1.2810586
 -0.8601426   3.778673   -1.737491   -3.428340   -2.6711420
 -1.7801479   3.227215   -3.088892   -3.640028   -2.3658743
 -3.7777899   3.334274   -4.038691   -1.987162   -2.2105029
 -4.0500860   4.123398   -2.352589   -1.261865   -1.9960508

  + Precipitação climatológica mensal das estações climatológicas do [INMET](http://www.inmet.gov.br/portal/index.php?r=clima/normaisClimatologicas) 


```r
# importando dados
prec <- readRDS("data/PrecAccInmet_61_90.rds")
head(prec)
```



codigo   nome              estado   mes    value
-------  ----------------  -------  ----  ------
82704    Cruzeiro do Sul   AC       jan    257.9
82915    Rio Branco        AC       jan    289.0
82807    Tarauacá          AC       jan    286.6
83098    Coruripe          AL       jan     21.6
82994    Maceió            AL       jan     78.1
82988    Mata Grande       AL       jan     62.1

```r
## dados rain
rain <- read.csv(file = "data/cityrain.csv", head = T)
head(rain)
```



Month    Tokyo   NewYork   London   Berlin
------  ------  --------  -------  -------
Jan       49.9      83.6     48.9     42.4
Feb       71.5      78.8     38.8     33.2
Mar      106.4      98.5     39.3     34.5
Apr      129.2      93.4     42.4     39.7
May      144.0     106.0     47.0     52.6
Jun      176.0      84.5     48.3     70.5

  + anomalias de temperatura do ar global Global de 1800 a 2011


```r
data(climate, package = "gcookbook")
#help(climate,package = "gcookbook")
head(climate)
```



Source      Year   Anomaly1y   Anomaly5y   Anomaly10y   Unc10y
---------  -----  ----------  ----------  -----------  -------
Berkeley    1800          NA          NA       -0.435    0.505
Berkeley    1801          NA          NA       -0.453    0.493
Berkeley    1802          NA          NA       -0.460    0.486
Berkeley    1803          NA          NA       -0.493    0.489
Berkeley    1804          NA          NA       -0.536    0.483
Berkeley    1805          NA          NA       -0.541    0.475

  
# Sistemas Gráficos 

O R possui uma poderosa [plataforma de ferramentas gráficas](http://cran.r-project.org/web/views/Graphics.html) para análise e visualização de dados. Os sistemas gráficos são: 

+ **sistema base (ou tradicional, tradução do termo em inglês [*base system*])**
    - 'modelo pintor', se errou, pega uma nova tela e começaa tudo de novo;
    - originalmente desenvolvido para o R e sua principal função é a `plot()`; 

+ **sistema de grade (tradução do termo em inglês [*grid system*](https://www.stat.auckland.ac.nz/~paul/grid/grid.html))**
    - fornece um conjunto de funções gráficas mais flexíveis para o *layout* de gráficos, como a criação de múltiplas regiões (*viewports*) em uma mesma página;
    - requer especificações detalhadas de onde plotar os pontos, linhas, retângulos e consequentemente um gráfico é elaborado a partir de várias linhas de código. 
    
## Pacotes Gráficos 

### graphics
  - contém as funções do sistema *base*
  - é carregado por *default* quando iniciamos o R; digite `sessionInfo()` para verificar nas informações de sua sessão os pacotes carregados, `demo("graphics")`para ver mais exemplos de gráficos e `library(help = "graphics")` para visualizar a lista de funções desse pacote.



```r
sessionInfo()
```

```
R version 3.2.1 (2015-06-18)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 14.04.3 LTS

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
 [3] LC_TIME=pt_BR.UTF-8        LC_COLLATE=en_US.UTF-8    
 [5] LC_MONETARY=pt_BR.UTF-8    LC_MESSAGES=en_US.UTF-8   
 [7] LC_PAPER=pt_BR.UTF-8       LC_NAME=C                 
 [9] LC_ADDRESS=C               LC_TELEPHONE=C            
[11] LC_MEASUREMENT=pt_BR.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] psych_1.5.6         gcookbook_1.0       ggplot2_1.0.1      
 [4] pander_0.5.2        printr_0.0.4        rasterVis_0.35     
 [7] latticeExtra_0.6-26 RColorBrewer_1.1-2  lattice_0.20-33    
[10] raster_2.4-15       sp_1.1-1            dplyr_0.4.2        
[13] plyr_1.8.3          stringr_1.0.0       lubridate_1.3.3    
[16] magrittr_1.5        R.utils_2.1.0       R.oo_1.19.0        
[19] R.methodsS3_1.7.0   knitcitations_1.0.6 knitr_1.10.5       

loaded via a namespace (and not attached):
 [1] Rcpp_0.12.0       highr_0.5         formatR_1.2      
 [4] bitops_1.0-6      tools_3.2.1       digest_0.6.8     
 [7] gtable_0.1.2      evaluate_0.7      memoise_0.2.1    
[10] bibtex_0.4.0      DBI_0.3.1         yaml_2.1.13      
[13] parallel_3.2.1    hexbin_1.27.0     proto_0.3-10     
[16] RefManageR_0.8.63 httr_1.0.0        grid_3.2.1       
[19] R6_2.1.0          XML_3.98-1.3      rmarkdown_0.7    
[22] RJSONIO_1.3-0     reshape2_1.4.1    MASS_7.3-43      
[25] scales_0.2.5      htmltools_0.2.6   mnormt_1.5-3     
[28] assertthat_0.1    colorspace_1.2-6  stringi_0.5-5    
[31] munsell_0.4.2     RCurl_1.95-4.7    zoo_1.7-12       
```

```r
library(help = "graphics")
```

```
		Information on package 'graphics'

Description:

Package:       graphics
Version:       3.2.1
Priority:      base
Title:         The R Graphics Package
Author:        R Core Team and contributors worldwide
Maintainer:    R Core Team <R-core@r-project.org>
Description:   R functions for base graphics.
Imports:       grDevices
License:       Part of R 3.2.1
Built:         R 3.2.1; x86_64-pc-linux-gnu; 2015-07-05 15:32:16
               UTC; unix

Index:

Axis                    Generic Function to Add an Axis to a Plot
abline                  Add Straight Lines to a Plot
arrows                  Add Arrows to a Plot
assocplot               Association Plots
axTicks                 Compute Axis Tickmark Locations
axis                    Add an Axis to a Plot
axis.POSIXct            Date and Date-time Plotting Functions
barplot                 Bar Plots
box                     Draw a Box around a Plot
boxplot                 Box Plots
boxplot.matrix          Draw a Boxplot for each Column (Row) of a
                        Matrix
bxp                     Draw Box Plots from Summaries
cdplot                  Conditional Density Plots
clip                    Set Clipping Region
contour                 Display Contours
coplot                  Conditioning Plots
curve                   Draw Function Plots
dotchart                Cleveland's Dot Plots
filled.contour          Level (Contour) Plots
fourfoldplot            Fourfold Plots
frame                   Create / Start a New Plot Frame
graphics-package        The R Graphics Package
grconvertX              Convert between Graphics Coordinate Systems
grid                    Add Grid to a Plot
hist                    Histograms
hist.POSIXt             Histogram of a Date or Date-Time Object
identify                Identify Points in a Scatter Plot
image                   Display a Color Image
layout                  Specifying Complex Plot Arrangements
legend                  Add Legends to Plots
lines                   Add Connected Line Segments to a Plot
locator                 Graphical Input
matplot                 Plot Columns of Matrices
mosaicplot              Mosaic Plots
mtext                   Write Text into the Margins of a Plot
pairs                   Scatterplot Matrices
panel.smooth            Simple Panel Plot
par                     Set or Query Graphical Parameters
persp                   Perspective Plots
pie                     Pie Charts
plot                    Generic X-Y Plotting
plot.data.frame         Plot Method for Data Frames
plot.default            The Default Scatterplot Function
plot.design             Plot Univariate Effects of a Design or Model
plot.factor             Plotting Factor Variables
plot.formula            Formula Notation for Scatterplots
plot.histogram          Plot Histograms
plot.raster             Plotting Raster Images
plot.table              Plot Methods for 'table' Objects
plot.window             Set up World Coordinates for Graphics Window
plot.xy                 Basic Internal Plot Function
points                  Add Points to a Plot
polygon                 Polygon Drawing
polypath                Path Drawing
rasterImage             Draw One or More Raster Images
rect                    Draw One or More Rectangles
rug                     Add a Rug to a Plot
screen                  Creating and Controlling Multiple Screens on a
                        Single Device
segments                Add Line Segments to a Plot
smoothScatter           Scatterplots with Smoothed Densities Color
                        Representation
spineplot               Spine Plots and Spinograms
stars                   Star (Spider/Radar) Plots and Segment Diagrams
stem                    Stem-and-Leaf Plots
stripchart              1-D Scatter Plots
strwidth                Plotting Dimensions of Character Strings and
                        Math Expressions
sunflowerplot           Produce a Sunflower Scatter Plot
symbols                 Draw Symbols (Circles, Squares, Stars,
                        Thermometers, Boxplots)
text                    Add Text to a Plot
title                   Plot Annotation
xinch                   Graphical Units
xspline                 Draw an X-spline
```

```r
demo("graphics")
```

```


	demo(graphics)
	---- ~~~~~~~~

> #  Copyright (C) 1997-2009 The R Core Team
> 
> require(datasets)

> require(grDevices); require(graphics)

> ## Here is some code which illustrates some of the differences between
> ## R and S graphics capabilities.  Note that colors are generally specified
> ## by a character string name (taken from the X11 rgb.txt file) and that line
> ## textures are given similarly.  The parameter "bg" sets the background
> ## parameter for the plot and there is also an "fg" parameter which sets
> ## the foreground color.
> 
> 
> x <- stats::rnorm(50)

> opar <- par(bg = "white")

> plot(x, ann = FALSE, type = "n")
```

<img src="7_Graficos_files/figure-html/Chunk131-1.png" title="" alt="" style="display: block; margin: auto;" />

```

> abline(h = 0, col = gray(.90))

> lines(x, col = "green4", lty = "dotted")

> points(x, bg = "limegreen", pch = 21)

> title(main = "Simple Use of Color In a Plot",
+       xlab = "Just a Whisper of a Label",
+       col.main = "blue", col.lab = gray(.8),
+       cex.main = 1.2, cex.lab = 1.0, font.main = 4, font.lab = 3)

> ## A little color wheel.	 This code just plots equally spaced hues in
> ## a pie chart.	If you have a cheap SVGA monitor (like me) you will
> ## probably find that numerically equispaced does not mean visually
> ## equispaced.  On my display at home, these colors tend to cluster at
> ## the RGB primaries.  On the other hand on the SGI Indy at work the
> ## effect is near perfect.
> 
> par(bg = "gray")

> pie(rep(1,24), col = rainbow(24), radius = 0.9)
```

<img src="7_Graficos_files/figure-html/Chunk131-2.png" title="" alt="" style="display: block; margin: auto;" />

```

> title(main = "A Sample Color Wheel", cex.main = 1.4, font.main = 3)

> title(xlab = "(Use this as a test of monitor linearity)",
+       cex.lab = 0.8, font.lab = 3)

> ## We have already confessed to having these.  This is just showing off X11
> ## color names (and the example (from the postscript manual) is pretty "cute".
> 
> pie.sales <- c(0.12, 0.3, 0.26, 0.16, 0.04, 0.12)

> names(pie.sales) <- c("Blueberry", "Cherry",
+ 		      "Apple", "Boston Cream", "Other", "Vanilla Cream")

> pie(pie.sales,
+     col = c("purple","violetred1","green3","cornsilk","cyan","white"))
```

<img src="7_Graficos_files/figure-html/Chunk131-3.png" title="" alt="" style="display: block; margin: auto;" />

```

> title(main = "January Pie Sales", cex.main = 1.8, font.main = 1)

> title(xlab = "(Don't try this at home kids)", cex.lab = 0.8, font.lab = 3)

> ## Boxplots:  I couldn't resist the capability for filling the "box".
> ## The use of color seems like a useful addition, it focuses attention
> ## on the central bulk of the data.
> 
> par(bg="cornsilk")

> n <- 10

> g <- gl(n, 100, n*100)

> x <- rnorm(n*100) + sqrt(as.numeric(g))

> boxplot(split(x,g), col="lavender", notch=TRUE)
```

<img src="7_Graficos_files/figure-html/Chunk131-4.png" title="" alt="" style="display: block; margin: auto;" />

```

> title(main="Notched Boxplots", xlab="Group", font.main=4, font.lab=1)

> ## An example showing how to fill between curves.
> 
> par(bg="white")

> n <- 100

> x <- c(0,cumsum(rnorm(n)))

> y <- c(0,cumsum(rnorm(n)))

> xx <- c(0:n, n:0)

> yy <- c(x, rev(y))

> plot(xx, yy, type="n", xlab="Time", ylab="Distance")
```

<img src="7_Graficos_files/figure-html/Chunk131-5.png" title="" alt="" style="display: block; margin: auto;" />

```

> polygon(xx, yy, col="gray")

> title("Distance Between Brownian Motions")

> ## Colored plot margins, axis labels and titles.	 You do need to be
> ## careful with these kinds of effects.	It's easy to go completely
> ## over the top and you can end up with your lunch all over the keyboard.
> ## On the other hand, my market research clients love it.
> 
> x <- c(0.00, 0.40, 0.86, 0.85, 0.69, 0.48, 0.54, 1.09, 1.11, 1.73, 2.05, 2.02)

> par(bg="lightgray")

> plot(x, type="n", axes=FALSE, ann=FALSE)
```

<img src="7_Graficos_files/figure-html/Chunk131-6.png" title="" alt="" style="display: block; margin: auto;" />

```

> usr <- par("usr")

> rect(usr[1], usr[3], usr[2], usr[4], col="cornsilk", border="black")

> lines(x, col="blue")

> points(x, pch=21, bg="lightcyan", cex=1.25)

> axis(2, col.axis="blue", las=1)

> axis(1, at=1:12, lab=month.abb, col.axis="blue")

> box()

> title(main= "The Level of Interest in R", font.main=4, col.main="red")

> title(xlab= "1996", col.lab="red")

> ## A filled histogram, showing how to change the font used for the
> ## main title without changing the other annotation.
> 
> par(bg="cornsilk")

> x <- rnorm(1000)

> hist(x, xlim=range(-4, 4, x), col="lavender", main="")
```

<img src="7_Graficos_files/figure-html/Chunk131-7.png" title="" alt="" style="display: block; margin: auto;" />

```

> title(main="1000 Normal Random Variates", font.main=3)

> ## A scatterplot matrix
> ## The good old Iris data (yet again)
> 
> pairs(iris[1:4], main="Edgar Anderson's Iris Data", font.main=4, pch=19)
```

<img src="7_Graficos_files/figure-html/Chunk131-8.png" title="" alt="" style="display: block; margin: auto;" />

```

> pairs(iris[1:4], main="Edgar Anderson's Iris Data", pch=21,
+       bg = c("red", "green3", "blue")[unclass(iris$Species)])
```

<img src="7_Graficos_files/figure-html/Chunk131-9.png" title="" alt="" style="display: block; margin: auto;" />

```

> ## Contour plotting
> ## This produces a topographic map of one of Auckland's many volcanic "peaks".
> 
> x <- 10*1:nrow(volcano)

> y <- 10*1:ncol(volcano)

> lev <- pretty(range(volcano), 10)

> par(bg = "lightcyan")

> pin <- par("pin")

> xdelta <- diff(range(x))

> ydelta <- diff(range(y))

> xscale <- pin[1]/xdelta

> yscale <- pin[2]/ydelta

> scale <- min(xscale, yscale)

> xadd <- 0.5*(pin[1]/scale - xdelta)

> yadd <- 0.5*(pin[2]/scale - ydelta)

> plot(numeric(0), numeric(0),
+      xlim = range(x)+c(-1,1)*xadd, ylim = range(y)+c(-1,1)*yadd,
+      type = "n", ann = FALSE)
```

<img src="7_Graficos_files/figure-html/Chunk131-10.png" title="" alt="" style="display: block; margin: auto;" />

```

> usr <- par("usr")

> rect(usr[1], usr[3], usr[2], usr[4], col="green3")

> contour(x, y, volcano, levels = lev, col="yellow", lty="solid", add=TRUE)

> box()

> title("A Topographic Map of Maunga Whau", font= 4)

> title(xlab = "Meters North", ylab = "Meters West", font= 3)

> mtext("10 Meter Contour Spacing", side=3, line=0.35, outer=FALSE,
+       at = mean(par("usr")[1:2]), cex=0.7, font=3)

> ## Conditioning plots
> 
> par(bg="cornsilk")

> coplot(lat ~ long | depth, data = quakes, pch = 21, bg = "green3")
```

<img src="7_Graficos_files/figure-html/Chunk131-11.png" title="" alt="" style="display: block; margin: auto;" />

```

> par(opar)
```


```r
## exemplo plot base
with(dados, plot(x = x1, y = y1))
```

<img src="7_Graficos_files/figure-html/Chunk132-1.png" title="" alt="" style="display: block; margin: auto;" />

### grid

  - contém as funções do sistema *grid*
  - também faz parte da distribuição *base* do R, mas o pacote precisa ser carregado (`require(grid)`)
    
    

```r
## exemplo grid
require(grid)
## define tamanho da região para plot (viewport)
pushViewport(plotViewport(c(5, 4, 2, 2)))
## define intervalos de variação das escalas x e y
pushViewport(dataViewport(xData = dados$x1, yData = dados$y1, name = "plotRegion"))
## retângulo em torno da região do plot
grid.rect()
## eixos x e y
grid.xaxis()
grid.yaxis()
## labels dos eixos x e y
grid.text("x1", y = unit(-3, "lines"))
grid.text("y1", x = unit(-3, "lines"), rot = 90)
## símbolos dos dados
grid.points(x = dados$x1, y = dados$y1, name = "dataSymbols")
```

<img src="7_Graficos_files/figure-html/Chunk133-1.png" title="" alt="" style="display: block; margin: auto;" />

    
### [lattice](http://lattice.r-forge.r-project.org/)

  - baseado no sistema *grid*;
  - gráficos são armazenados como variáveis (objetos que podem ser salvos)
    + possibilita plotar, fazer alterações e atualizações
  - usa a idéia de gráficos  *Trellis* (ou gráficos em facetas), desenvolvidos para análise de dados multivariados na linguagem S e S-Plus; 
    + possibilita gráficos condicionados por grupos ou categorias facilitando a comparação
  - funções gráficas no sistema *base* e **lattice** são incompatíveis entre si.
    


```r
# exemplo lattice
require(lattice)
xyplot(y1 ~ x1, data = dados)
```

<img src="7_Graficos_files/figure-html/Chunk134-1.png" title="" alt="" style="display: block; margin: auto;" />


### [ggplot2](http://ggplot2.org/)

  - assim como lattice também foi construído baseado no sistema *grid*.
  - sistema mais moderno, **gg** significa **gramática de gráficos** [Wilkinson (1999)](http://www.cs.uic.edu/~wilkinson/TheGrammarOfGraphics/GOG.html), que usa os aspectos bons de ambos sistemas **base** e **lattice**; 
  - modelo poderoso de gráficos que torna mais fácil a produção de gráficos complexos com multi-camadas.
  - ambiente gráfico altamente **customizável**
    

```r
## exemplo ggplot2
require(ggplot2)
qplot(x = x1, y = y1, data = dados)
```

<img src="7_Graficos_files/figure-html/Chunk135-1.png" title="" alt="" style="display: block; margin: auto;" />


# Terminologia: funções de alto e baixo nível

- Funções de alto nível produzem um gráfico completo.


```r
# exemplo função gráfica de alto nível
plot(x1, y1, las = 1)
```

<img src="7_Graficos_files/figure-html/Chunk31-1.png" title="" alt="" style="display: block; margin: auto;" />

- Funções de baixo nível adicionam saídas a um plot existente, logo vão sobrepor o que estiver na tela gráfica. 


```r
# exemplo função gráfica de alto nível
plot(x1, y1, las = 1)
# exemplo funções gráficas de baixo nível
points(x1, y1,                    # adiciona pontos com cor e símbolo
       col = 2,                   # cor do ponto
       pch = 20,                  # tipo (círculo preenchido)
       cex = 0.8)                 # tamanho relativo do símbolo (default =1) 
grid()                            # adiciona linhas de grade
abline(h = 0,col = "gray")        # linhade referência (y = 0)
title(main = "Grafico a partir de funçoes de baixo nível")      # adiciona título ao gráfico
box(lwd = 2)                      # adiciona retângulo em torna da região do gráfico, com linha mais larga
```

<img src="7_Graficos_files/figure-html/Chunk32-1.png" title="" alt="" style="display: block; margin: auto;" />

Ambos sistemas *base* e *grid* fornecem funções gráficas de baixo nível. O sistema *grid* também oferece funções para interação com os gráficos de saída (como a edição, extração, remoção de partes de uma imagem).
A Maioria das funções em pacotes gráficos produz gráficos completos e geralmente oferecem gráficos específicos para um tipo de análise ou campo de estudo.
  
Nesta aula será dado foco a produção de gráficos usando o **sistema *base*** do R.

# Funções gráficas básicas

## Função `plot()` 

### Gráficos de diferentes dados de entrada

A função `plot()` é o carro chefe do sistema base do R. Quando especificamos apenas uma variável de entrada é plotado a variável no eixo y em função de seu tamanho `1:length(x)` no eixo x.


```r
plot(y1)
```

<img src="7_Graficos_files/figure-html/Chunk4110-1.png" title="" alt="" style="display: block; margin: auto;" />

Gerando um gráfico especificando os parâmetros x e y. 


```r
plot(x = x1, y = y1)
```

<img src="7_Graficos_files/figure-html/Chunk4111-1.png" title="" alt="" style="display: block; margin: auto;" />

Também podemos especificar no primeiro argumento da `plot()` uma fórmula, p.ex.: `y1 ~ x1` que pode ser interpretada como y1 (variável) em função x1.


```r
plot(y1 ~ x1)
```

<img src="7_Graficos_files/figure-html/Chunk4112-1.png" title="" alt="" style="display: block; margin: auto;" />

Aplicando a `plot()` a um `data.frame` com duas variáveis resulta um gráfico equivalente ao caso anterior.


```r
plot(dados)
```

<img src="7_Graficos_files/figure-html/Chunk4113-1.png" title="" alt="" style="display: block; margin: auto;" />

### Gráficos de dispersão

Aplicando a `plot()` a um `data.frame` com mais de duas variáveis resulta um gráfico de dispersão entre todas as variáveis do *dataframe*.


```r
## plot de todas colunas de aq, exceto a 1a coluna
plot(aq[, -1])
```

<img src="7_Graficos_files/figure-html/Chunk4114-1.png" title="" alt="" style="display: block; margin: auto;" />

Cada gráfico desses é chamado de gráfico de dispersão. Através dele pode-se visualizar a relação entre duas variáveis. Nesse caso o gráfico resultante é uma matriz de gráficos de dispersão.

Existe uma função gráfica específica para produção deste tipo de gráfico: a função `pairs()`. 


```r
# plote de pares
pairs(aq[, -1])  # exclui coluna date
```

<img src="7_Graficos_files/figure-html/Chunk4115-1.png" title="" alt="" style="display: block; margin: auto;" />

A função `pairs.panels()` do pacote `psych` fornece um gráfico de pares bastante informativo e foi expandida a partir da função `pairs()`.


```r
pairs.panels(x = aq[, -1])
```

<img src="7_Graficos_files/figure-html/Chunk4116-1.png" title="" alt="" style="display: block; margin: auto;" />

Para fechar as janelas gráficas abertas:


```r
graphics.off()
```
- - - 

# Parâmetros gráficos

Podemos personalisar muitas características de um gráfico (cores, eixos, títulos) através de opções chamadas **parametros gráficos**.

As opções são especificadas através da função `par()`. Os parâmetros assim definidos terão efeito até o fim da sessão ou até que eles sejam mudados.

Digitando `par()` sem parâmetros produz uma lista das configurações gráficas atuais. Adicionando o parâmetro `no.readonly=TRUE` produz uma lista das configurações atuais que podem ser modificadas posteriormente.



```r
par()
```

```
$xlog
[1] FALSE

$ylog
[1] FALSE

$adj
[1] 0.5

$ann
[1] TRUE

$ask
[1] FALSE

$bg
[1] "white"

$bty
[1] "o"

$cex
[1] 1

$cex.axis
[1] 1

$cex.lab
[1] 1

$cex.main
[1] 1.2

$cex.sub
[1] 1

$cin
[1] 0.15 0.20

$col
[1] "black"

$col.axis
[1] "black"

$col.lab
[1] "black"

$col.main
[1] "black"

$col.sub
[1] "black"

$cra
[1] 14.4 19.2

$crt
[1] 0

$csi
[1] 0.2

$cxy
[1] 0.02218935 0.04807692

$din
[1] 8 6

$err
[1] 0

$family
[1] ""

$fg
[1] "black"

$fig
[1] 0 1 0 1

$fin
[1] 8 6

$font
[1] 1

$font.axis
[1] 1

$font.lab
[1] 1

$font.main
[1] 2

$font.sub
[1] 1

$lab
[1] 5 5 7

$las
[1] 0

$lend
[1] "round"

$lheight
[1] 1

$ljoin
[1] "round"

$lmitre
[1] 10

$lty
[1] "solid"

$lwd
[1] 1

$mai
[1] 1.02 0.82 0.82 0.42

$mar
[1] 5.1 4.1 4.1 2.1

$mex
[1] 1

$mfcol
[1] 1 1

$mfg
[1] 1 1 1 1

$mfrow
[1] 1 1

$mgp
[1] 3 1 0

$mkh
[1] 0.001

$new
[1] FALSE

$oma
[1] 0 0 0 0

$omd
[1] 0 1 0 1

$omi
[1] 0 0 0 0

$page
[1] TRUE

$pch
[1] 1

$pin
[1] 6.76 4.16

$plt
[1] 0.1025000 0.9475000 0.1700000 0.8633333

$ps
[1] 12

$pty
[1] "m"

$smo
[1] 1

$srt
[1] 0

$tck
[1] NA

$tcl
[1] -0.5

$usr
[1] 0 1 0 1

$xaxp
[1] 0 1 5

$xaxs
[1] "r"

$xaxt
[1] "s"

$xpd
[1] FALSE

$yaxp
[1] 0 1 5

$yaxs
[1] "r"

$yaxt
[1] "s"

$ylbias
[1] 0.2
```

```r
# cópia das configurações atuais
old_par <- par(no.readonly = TRUE)
# tipo de linha pontilhada, largura da linha, símbolo para plot (triângulo sólido) 
  par(lty = 3, pch = 17)
  with(aq, plot(x = date, y = Wind, type = "b"))    # linha e ponto desconectados
```

<img src="7_Graficos_files/figure-html/Chunk61-1.png" title="" alt="" style="display: block; margin: auto;" />

```r
# restabelecendo parâmetros originais
par(old_par) 
```

Podemos definir `par()` quantas vezes forem necessárias.
  
A segunda forma de especificar parâmetros é `nome_opção = valor` diretamente na função gráfica de alto nível.
  
Mas nesse caso, as opções terão efeito (local) apenas para aquele gráfico específico , portanto diferindo da primeira forma em que a definição pode ser para toda sessão (global).
  
Poderíamos gerar o mesmo gráfico anterior  da seguinte forma:


```r
with(aq, plot(x = date, y = Wind, type = "b", lty = 3, pch = 17))
```

<img src="7_Graficos_files/figure-html/Chunk62-1.png" title="" alt="" style="display: block; margin: auto;" />

Nem todas funções de alto nível permitem especificar todos parâmetros gráficos. Veja  o `help(plot)` para determinar quais parâmetros gráficos podem configurados dessa forma.


```r
?plot
```

```
Help on topic 'plot' was found in the following packages:

  * raster
  * graphics
```

A seguir veremos alguns importantes parâmetros gráficos que podemos configurar.

## Símbolos e linhas

Vimos que podemos especificar símbolos e linhas nos gráficos. Os parâmetros relevantes para essas opções são mostradas na tabela a seguir.

| Parâmetro | Descrição                                                                                                                                       |
|-----------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| **pch**       | define o símbolo a ser usado para pontos                                                                                                        |
| **cex**       | tamanho do símbolo, cex é um nº indicando a quantidade pela qual símbolos devem ser relativos, Default = 1, 1.5 é 50 % maior, 0.5 é 50 % menor. |
| **lty**       | tipo de linha                                                                                                                                   |
| **lwd**       | largura da linha, expresso em relação ao default (=1), então lwd = 2 gera uma linha com o dobro de largura da linha default.                    |


```r
# plot(c(-1, 26), 0:1, type = "n", axes = FALSE, xlab = "", ylab = "")
# text(0:25, 0.6, c(0:25), cex = 1)
# points(0:25, rep(0.4, 26), pch = 0:25, bg = "grey")
# mtext(text = "pch = ", side = 1, line = -14.5, cex = 2)
# mtext(text = "símbolo", side = 1, line = -10.5, cex = 2)
pchShow <-
  function(extras = c("*",".", "o","O","0","+","-","|","%","#"),
           cex = 3, ## good for both .Device=="postscript" and "x11"
           col = "red3", bg = "gold", coltext = "brown", cextext = 1.2,
           main = paste("Símbolos:  points(..., pch = *, cex =",
                        cex,")"))
  {
    nex <- length(extras)
    np  <- 26 + nex
    ipch <- 0:(np-1)
    k <- floor(sqrt(np))
    dd <- c(-1,1)/2
    rx <- dd + range(ix <- ipch %/% k)
    ry <- dd + range(iy <- 3 + (k-1)- ipch %% k)
    pch <- as.list(ipch) # list with integers & strings
    if(nex > 0) pch[26+ 1:nex] <- as.list(extras)
    plot(rx, ry, type = "n", axes  =  FALSE, xlab = "", ylab = "", main = main)
    abline(v = ix, h = iy, col = "lightgray", lty = "dotted")
    for(i in 1:np) {
      pc <- pch[[i]]
      ## 'col' symbols with a 'bg'-colored interior (where available) :
      points(ix[i], iy[i], pch = pc, col = col, bg = bg, cex = cex)
      if(cextext > 0)
          text(ix[i] - 0.3, iy[i], pc, col = coltext, cex = cextext)
    }
  }
pchShow()
```

<img src="7_Graficos_files/figure-html/Chunk610-1.png" title="" alt="" style="display: block; margin: auto;" />

As opções de tipo de linha são mostradas abaixo.


```r
# linhas
op <- par(lwd=3, cex = 1.5, cex.axis = 1, cex.lab =1, font=2, font.axis=2, font.lab=2)
plot(x = c(0,10), 
     y = c(1,6), 
     type='n', 
     xlab = "" , 
     ylab = "", 
     main= "Amostra de tipo de linhas", 
     axes = FALSE, 
     frame.plot = FALSE)
axis(2, lwd = 3, at = seq(1,6, by = 1), cex = 1.25, font = 2, col = "white")
mtext('Nº do tipo de linha (lty = )', side=2, line=2, cex=1.5,font=2)
abline(h=1:6, lty=1:6)
```

<img src="7_Graficos_files/figure-html/Chunk611-1.png" title="" alt="" style="display: block; margin: auto;" />

```r
par(op)
```

Exemplo com as opções.


```r
with(aq, plot(x = date, y = Temp, type = "b", lty = 3, pch = 15, cex = 2))
```

<img src="7_Graficos_files/figure-html/Chunk612-1.png" title="" alt="" style="display: block; margin: auto;" />


## Cores

Há diversos parâmetros relacionados a cores no R. A tabela abaixo mostra os mais comuns.

| Parâmetro | Descrição                                                                                                  |
|-----------|------------------------------------------------------------------------------------------------------------|
| `col`       | cor default do gráfico. Algumas funções como `lines()` e `pie()` aceitam um vetor de cores que são recicladas |
| `col.axis`  | cor do texto (título) nos eixos                                                                            |
| `col.lab`   | cor dos rótulos dos eixos                                                                                     |
| `col.main`  | cor do texto do título do gráfico                                                                          |
| `col.sub`  | cor do sub-título                                                                                          |
| `fg`        | cor do primeiro plano                                                                                      |
| `bg`       | cor do plano de fundo                                                                                      |


Podemos especificar as cores no R por índice, nome, hexadecimal, RGB ou HSV. Por exemplo `col = 0`, `col = "white"`, `col =FFFFF`, `col = rgb(1,1,1)` e `col = hsv(1,1,1)` são formas equivalentes de especificar a cor branca.

A função `colors()` retorna o nome de todas as cores disponíveis.


```r
colors()[1:20]
```

```
 [1] "white"         "aliceblue"     "antiquewhite"  "antiquewhite1"
 [5] "antiquewhite2" "antiquewhite3" "antiquewhite4" "aquamarine"   
 [9] "aquamarine1"   "aquamarine2"   "aquamarine3"   "aquamarine4"  
[13] "azure"         "azure1"        "azure2"        "azure3"       
[17] "azure4"        "beige"         "bisque"        "bisque1"      
```

```r
n <- length(colors())
op <- par(bg = "gray60")
plot(dados$x1[1:n], dados$y1[1:n], 
     type = "n",
     xlab = "x",
     ylab = "y",
     main = "Várias cores",
     sub = "Onda colorida",
     col.axis = "green",
     col.lab = "green",
     col.axis = "yellow",
     col.sub = "red"
     )
usr <- par("usr")
rect(usr[1], usr[3], usr[2], usr[4], col="snow", border="black", lwd = 2)
points(dados$x1[1:n], dados$y1[1:n],
       col = colors()[1:n], 
       pch = 20, 
       cex = (1:n)/60 * 4
       )
```

<img src="7_Graficos_files/figure-html/Chunk520-1.png" title="" alt="" style="display: block; margin: auto;" />

```r
par(op)
```

Para visualizar as cores e os nomes associados a cada uma veja [http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf).

O R também possui diversas funções para criar vetores de cores contínuas (paletas):


```r
plot(dados$x1[1:n], dados$y1[1:n], 
     type = "p",
     xlab = "x",
     ylab = "y",
     main = "Várias cores",
     sub = "Onda colorida",
     col = rainbow(n), 
     pch = 20, 
     cex = (1:n)/60 * 4)
```

<img src="7_Graficos_files/figure-html/Chunk521-1.png" title="" alt="" style="display: block; margin: auto;" />

```r
plot(dados$x1[1:n], dados$y1[1:n], 
     type = "p",
     xlab = "x",
     ylab = "y",
     main = "Várias cores",
     sub = "Onda colorida",
     col = heat.colors(n), 
     pch = 20, 
     cex = (1:n)/60 * 4)
```

<img src="7_Graficos_files/figure-html/Chunk521-2.png" title="" alt="" style="display: block; margin: auto;" />

```r
plot(dados$x1[1:n], dados$y1[1:n], 
     type = "p",
     xlab = "x",
     ylab = "y",
     main = "Várias cores",
     sub = "Onda colorida",
     col = terrain.colors(n), 
     pch = 20, 
     cex = (1:n)/60 * 4)
```

<img src="7_Graficos_files/figure-html/Chunk521-3.png" title="" alt="" style="display: block; margin: auto;" />

```r
plot(dados$x1[1:n], dados$y1[1:n], 
     type = "p",
     xlab = "x",
     ylab = "y",
     main = "Várias cores",
     sub = "Onda colorida",
     col = topo.colors(n), 
     pch = 20, 
     cex = (1:n)/60 * 4)
```

<img src="7_Graficos_files/figure-html/Chunk521-4.png" title="" alt="" style="display: block; margin: auto;" />

```r
plot(dados$x1[1:n], dados$y1[1:n], 
     type = "p",
     xlab = "x",
     ylab = "y",
     main = "Várias cores",
     sub = "Onda colorida",
     col = cm.colors(n), 
     pch = 20, 
     cex = (1:n)/60 * 4)
```

<img src="7_Graficos_files/figure-html/Chunk521-5.png" title="" alt="" style="display: block; margin: auto;" />

## Características de texto

Parâmetros especificando tamanho do texto.

| Parâmetro | Descrição                                                                                            |
|-----------|------------------------------------------------------------------------------------------------------|
| cex       | nº indicando a quantidade pela qual o texto plotado deve ser escalonado em relação ao default (=1).  |
| cex.axis  | magnificação do texto dos eixos (títulos).                                                           |
| cex.lab   | magnificação dos rótulos em relação ao cex.                                                          |
| cex.main  | magnificação dos títulos em relação ao cex.                                                          |
| cex.sub   | cor do sub-título                                                                                    |

Parâmetros especificando família, tamanho e estilo da fonte.

| Parâmetro | Descrição                                                                                                                   |
|-----------|-----------------------------------------------------------------------------------------------------------------------------|
| font      | inteiro especificando a fonte a ser usada. 1 = normal, 2 = negrito, 3 = itálico, 4 = negrito e itálico, 5 = símbolo (adobe) |
| font.axis | fonte para o texto do eixo                                                                                                  |
| font.lab  | fonte para o rótulo do eixo                                                                                                 |
| font.main | fonte para o título                                                                                                         |
| font.sub  | fonte para o sub-título                                                                                                     |
| ps        | tamanho do ponto da fonte (ps = 1/72 *cex)                                                                                  |
| family    |                                                                                                                             |



```r
op <- par(font.lab = 3, cex.lab = 2, font.main = 4, cex.main = 2)
plot(dados$x1[1:n], dados$y1[1:n], 
     type = "p",
     xlab = "x",
     ylab = "y",
     main = "Várias cores",
     sub = "Onda colorida",
     col = gray.colors(n), 
     pch = 20, 
     cex = (1:n)/60 * 4)
```

<img src="7_Graficos_files/figure-html/Chunk600-1.png" title="" alt="" style="display: block; margin: auto;" />

```r
par(op)
```

### Tipos de Gráficos 

Até aqui já vimos como criar gráficos de dispersão com a função `plot()`. Mas existe uma ampla variedade de gráficos, além daqueles: *boxplots*, histogramas, gráficos de barra, gráficos de pizza, gráficos de imagens, gráficos 3D. Alguns exemplos são mostrados a seguir.



```r
# gráfico de barras
barplot(BOD$demand, names.arg = BOD$Time, col = 1)
```

<img src="7_Graficos_files/figure-html/Chunk17-1.png" title="" alt="" style="display: block; margin: auto;" />

```r
# gráfico de uma tabela de contagem
barplot(table(mtcars$cyl))
```

<img src="7_Graficos_files/figure-html/Chunk17-2.png" title="" alt="" style="display: block; margin: auto;" />

```r
# histograma
hist(mtcars$mpg)
```

<img src="7_Graficos_files/figure-html/Chunk17-3.png" title="" alt="" style="display: block; margin: auto;" />

```r
# Especificando o número aproximado de classes com parâmetro breaks
hist(mtcars$mpg, breaks = 10)
```

<img src="7_Graficos_files/figure-html/Chunk17-4.png" title="" alt="" style="display: block; margin: auto;" />

```r
# boxplots
# boxplot de todas colunas
boxplot(aq[, -1])
```

<img src="7_Graficos_files/figure-html/Chunk17-5.png" title="" alt="" style="display: block; margin: auto;" />

```r
# usando formula
boxplot(Temp ~ Month, data = airquality)
```

<img src="7_Graficos_files/figure-html/Chunk17-6.png" title="" alt="" style="display: block; margin: auto;" />

```r
# Curvas
curve(x^3 - 5*x,from=-4,to=4)
```

<img src="7_Graficos_files/figure-html/Chunk17-7.png" title="" alt="" style="display: block; margin: auto;" />

```r
# plot de uma função criada
minhafun <- function(xvar) {
1/(1 +exp(-xvar + 10))
}
curve(minhafun(x),from=0,to=20)
# Add a line:
curve(1-minhafun(x),add = TRUE,col = "red")
```

<img src="7_Graficos_files/figure-html/Chunk17-8.png" title="" alt="" style="display: block; margin: auto;" />

```r
# Imagem
dim(volcano)
```

```
[1] 87 61
```

```r
x <- 10*(1:nrow(volcano))
y <- 10*(1:ncol(volcano))
image(x, y, volcano, col = terrain.colors(100), axes = FALSE)
contour(x, y, volcano, levels = seq(90, 200, by = 5),
        add = TRUE, col = "peru")
axis(1, at = seq(100, 800, by = 100))
axis(2, at = seq(100, 600, by = 100))
box()
title(main = "Maunga Whau Volcano", font.main = 4)
```

<img src="7_Graficos_files/figure-html/Chunk17-9.png" title="" alt="" style="display: block; margin: auto;" />


### Telas gráficas 

#### Abrir e fechar uma tela gráfica 

Para gerar gráficos vamos primeiro abrir uma tela gráfica, plotar os dados e então fechar a tela gráfica.


```r
# abre uma tela gráfica fora do ambiente do RStudio
x11()  
 # plot de uma variável
 plot(y1)
```

<img src="7_Graficos_files/figure-html/Chunk1000-1.png" title="" alt="" style="display: block; margin: auto;" />

```r
 # fechando tela gráfica
dev.off()
```

```
png 
  2 
```


```r
plot(y1)
```

<img src="7_Graficos_files/figure-html/Chunk1001-1.png" title="" alt="" style="display: block; margin: auto;" />

#### Um gráfico em cada tela

A execução do comando `plot()` abre automaticamente uma tela gráfica sem a necessidade da execução do comando `x11()` antes. Entretanto quando desejamos manter o gráfico atual numa tela e plotar outra váriavel em uma nova tela precisamos abri-la antes, do contrário o R apaga o gráfico anterior e gera o gráfico da nova variável na mesma tela.


```r
plot(y1)
```

<img src="7_Graficos_files/figure-html/Chunk1002-1.png" title="" alt="" style="display: block; margin: auto;" />

```r
x11(); plot(sqrt(y1^2))
```


```r
plot(y1)
```

<img src="7_Graficos_files/figure-html/Chunk1003-1.png" title="" alt="" style="display: block; margin: auto;" />

```r
plot(sqrt(y1^2))
```

<img src="7_Graficos_files/figure-html/Chunk1003-2.png" title="" alt="" style="display: block; margin: auto;" />

- - - 

#### Fechar todas telas gráficas

Vamos gerar 5 gráficos e apága-los de uma vez só.


```r
## plotando cada coluna da matriz mat em uma nova tela gráfica
sapply(1:ncol(mat), 
      FUN = function(i) {
                 x11() # abrindo tela gráfica para plot
                 # plot da variável de cada coluna da matriz 
                 plot(mat[, i], type = "l", col = 4, main = paste("Gráfico", i)) 
                  abline(h = 0) # linha de referência em x = 0
                  return(i)
            }
      )# fim do apply
```

```
[1] 1 2 3 4 5
```


```r
## plotando cada coluna da matriz mat em uma nova tela gráfica
sapply(1:ncol(mat), 
      FUN = function(i) {
                 # plot da variável de cada coluna da matriz 
                 plot(mat[, i], type = "l", col = 4, main = paste("Gráfico", i)) 
                  abline(h = 0) # linha de referência em x = 0
                  return(i)
            }
      )# fim do apply
```

<img src="7_Graficos_files/figure-html/Chunk1006-1.png" title="" alt="" style="display: block; margin: auto;" /><img src="7_Graficos_files/figure-html/Chunk1006-2.png" title="" alt="" style="display: block; margin: auto;" /><img src="7_Graficos_files/figure-html/Chunk1006-3.png" title="" alt="" style="display: block; margin: auto;" /><img src="7_Graficos_files/figure-html/Chunk1006-4.png" title="" alt="" style="display: block; margin: auto;" /><img src="7_Graficos_files/figure-html/Chunk1006-5.png" title="" alt="" style="display: block; margin: auto;" />

```
[1] 1 2 3 4 5
```

Para apagar todas as telas gráficas abertas de uma vez só usa-se a função `graphics.off()`.


```r
graphics.off()
```

- - - 

#### Salvando gráficos

O R pode exportar um gráfico para diferentes saídas gráficas (png, pdf, ps, jpeg e etc). Uma lista completa das opções disponíveis está disponível em `?device`.


```r
plot(y1)
```

<img src="7_Graficos_files/figure-html/Chunk1008-1.png" title="" alt="" style="display: block; margin: auto;" />

Vamos usar o exemplo da matriz `mat` para salvar os gráficos das variáveis em cada coluna em um único arquivo **pdf**.


```r
## fechando qualquer tela gráfica aberta
graphics.off()
## abrindo saída gráfica
pdf(file = "output/5plots1file.pdf",onefile = TRUE, width = 7, height = 4)
## looping em cada coluna da matriz mat
sapply(1:ncol(mat), 
      ##  Função para plot da variável na coluna i
      FUN = function(i) {
                 ## mostra tela o índice do looping em execução
                 cat(i, "\n")
                 ## plot da variável de cada coluna da matriz 
                 plot(mat[, i], type = "l", col = 4, main = paste("Gráfico", i)) 
                  abline(h = 0) ## linha de referência em x = 0
                  return(i)
            }
      )## fim do apply
```

```
1 
```

```
2 
```

```
3 
```

```
4 
```

```
5 
```

```
[1] 1 2 3 4 5
```

```r
## fechando pdf
dev.off()
```

```
null device 
          1 
```

Para salvar cada gráfico em um arquivo a chamada da função pdf deve ser feita antes de cada gráfico. 


```r
## fechando qualquer tela gráfica aberta
graphics.off()
## looping em cada coluna da matriz mat
sapply(1:ncol(mat), 
      ##  Função para plot da variável na coluna i
      FUN = function(i) {
                ## mostra tela o índice do looping em execução
                cat(i, "\n")
                ## criando nome do arquivo
                arquivo <- paste("output/","plot",i,"file",i,".pdf", sep = "")
                 ## abrindo saída gráfica
                 pdf(file = arquivo ,onefile = TRUE, width = 7, height = 4)
                  # plot da variável de cada coluna da matriz 
                  plot(mat[, i], type = "l", col = 4, main = paste("Gráfico", i)) 
                   # linha de referência em x = 0
                   abline(h = 0) 
                 ## fechando pdf
                 dev.off()
                return(i)
            }
      )# fim do looping
```

```
1 
```

```
2 
```

```
3 
```

```
4 
```

```
5 
```

```
[1] 1 2 3 4 5
```

- - - 

## Plotando vários gráficos em uma mesma página


```r
par(mfrow = c(2,3))
plot(x = aq$date, y = aq$Ozone, type = "o")   # linha e ponto conectados
plot(x = aq$date, y = aq$Temp, type = "l") # linha
plot(x = aq$date, y = aq$Wind, type = "b")    # linha e ponto desconectados
plot(x = aq$date, y = aq$Solar.R, type = "h")
plot(x = aq$date, y = (aq$Ozone)^1/3, type = "o")   # linha e ponto
plot(1:10, 1:10,  type = "n", frame = F,axes = F, xlab = "", ylab = "")
text(5,5, "Gráficos \n em uma \n página", cex = 3)
```

<img src="7_Graficos_files/figure-html/Chunk1011-1.png" title="" alt="" style="display: block; margin: auto;" />

```r
par()
```

```
$xlog
[1] FALSE

$ylog
[1] FALSE

$adj
[1] 0.5

$ann
[1] TRUE

$ask
[1] FALSE

$bg
[1] "white"

$bty
[1] "o"

$cex
[1] 0.66

$cex.axis
[1] 1

$cex.lab
[1] 1

$cex.main
[1] 1.2

$cex.sub
[1] 1

$cin
[1] 0.15 0.20

$col
[1] "black"

$col.axis
[1] "black"

$col.lab
[1] "black"

$col.main
[1] "black"

$col.sub
[1] "black"

$cra
[1] 14.4 19.2

$crt
[1] 0

$csi
[1] 0.132

$cxy
[1] 0.3486704 0.5135249

$din
[1] 15 10

$err
[1] 0

$family
[1] ""

$fg
[1] "black"

$fig
[1] 0.6666667 1.0000000 0.0000000 0.5000000

$fin
[1] 5 5

$font
[1] 1

$font.axis
[1] 1

$font.lab
[1] 1

$font.main
[1] 2

$font.sub
[1] 1

$lab
[1] 5 5 7

$las
[1] 0

$lend
[1] "round"

$lheight
[1] 1

$ljoin
[1] "round"

$lmitre
[1] 10

$lty
[1] "solid"

$lwd
[1] 1

$mai
[1] 0.6732 0.5412 0.5412 0.2772

$mar
[1] 5.1 4.1 4.1 2.1

$mex
[1] 1

$mfcol
[1] 2 3

$mfg
[1] 2 3 2 3

$mfrow
[1] 2 3

$mgp
[1] 3 1 0

$mkh
[1] 0.001

$new
[1] FALSE

$oma
[1] 0 0 0 0

$omd
[1] 0 1 0 1

$omi
[1] 0 0 0 0

$page
[1] TRUE

$pch
[1] 1

$pin
[1] 4.1816 3.7856

$plt
[1] 0.10824 0.94456 0.13464 0.89176

$ps
[1] 12

$pty
[1] "m"

$smo
[1] 1

$srt
[1] 0

$tck
[1] NA

$tcl
[1] -0.5

$usr
[1]  0.64 10.36  0.64 10.36

$xaxp
[1]  2 10  4

$xaxs
[1] "r"

$xaxt
[1] "s"

$xpd
[1] FALSE

$yaxp
[1]  2 10  4

$yaxs
[1] "r"

$yaxt
[1] "s"

$ylbias
[1] 0.2
```

## Gráfico com 2 eixos


```r
plot(x = aq$date, y = aq$Ozone, type = "l", lwd = 2, ylab = "", xlab = "Data")
par(new=T)
plot(x = aq$date, y = aq$Temp, type = "l", col = 2, lwd =2,  axes = F, ylab = "", xlab = "")
axis(4, col = 2, col.axis = 2)
mtext(text = "Ozônio", line = -2, adj = 0.2)
mtext(text = "Temp", col =2, line = -1, adj = 0.2)
```

<img src="7_Graficos_files/figure-html/Chunk1012-1.png" title="" alt="" style="display: block; margin: auto;" />

- - - 

## Adicionando legenda

```r
plot(rain$Tokyo,type="l",col="red",ylim=c(0,300),
     main="Chuva mensal em grandes cidades",
     xlab="Mês do ano",
     ylab="Chuva (mm)",
     lwd=2)
lines(rain$NewYork,type="l",col="blue",lwd=2)
lines(rain$London,type="l",col="green",lwd=2)
lines(rain$Berlin,type="l",col="orange",lwd=2)
## legenda
legend("topright",
       legend = c("Tokyo","NewYork","London","Berlin"),
       col = c("red","blue","green","orange"),
       lty = 1,
       lwd = 2)
```

<img src="7_Graficos_files/figure-html/Chunk1013-1.png" title="" alt="" style="display: block; margin: auto;" />






