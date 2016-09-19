# Geração KML a partir de *shapefile* da [ANA](http://www.ana.gov.br/)




# Introdução 

A Agência Nacional das Águas ([ANA](http://www.ana.gov.br/)) disponibiliza um banco de informações hidrológicas para as regiões hidrográficas brasileiras através do site [hidroweb](http://hidroweb.ana.gov.br/HidroWeb.asp?TocItem=4100)[^1]. As informações são fornecidas no formato [shapefile](https://en.wikipedia.org/wiki/Shapefile) (extensão `.shp`). Na verdade, um *shapefile* está associado a um conjunto de arquivos (no mínimo 3). Os dados são divididos por [regiões hidrográficas](https://pt.wikipedia.org/wiki/Regi%C3%B5es_hidrogr%C3%A1ficas_do_Brasil). 

Nesse tutorial veremos como converter o conjunto de arquivos associados a um *shapefile* da hidrografia da região hidrográfica do Rio Uruguai (Bacia 7) para o formato [KML](https://en.wikipedia.org/wiki/Keyhole_Markup_Language) para visualização no [Google Earth](https://en.wikipedia.org/wiki/Google_Earth).

![](https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Brasil_Bacias_hidrograficas.svg/300px-Brasil_Bacias_hidrograficas.svg.png)

# Pré-requisitos

Para converter os arquivos associados ao *shapefile* utilizaremos a função `KML()` disponibilizada com o pacote [raster](https://cran.r-project.org/web/packages/raster/index.html). Para instalar um pacote no R, digite `install.packages("raster")`.


```r
# carregando pacote raster para uso
library(raster)
options(stringsAsFactors = TRUE)
```


# Baixando dados

Para baixar o arquivo compactado com as informações hidrológicas de uma região hidrográfica precisamos do código identificador. No caso da região hidrográfica do Rio Uruguai o identificador é o número 7. 


```r
# identificador da bacia hidrográfica (BH)
id_bh <- 7
# site definido conforme nº identificador da BH
website <- "http://hidroweb.ana.gov.br/baixar/mapa/BaciaX.zip"
(website <- gsub("X", id_bh, website))
```

```
[1] "http://hidroweb.ana.gov.br/baixar/mapa/Bacia7.zip"
```

```r
# nome e caminho para o arquivo que será baixado 
(zip_file <- paste0("data/", basename(website)))
```

```
[1] "data/Bacia7.zip"
```


```r
# baixand arquico compactado
download.file(website, destfile = zip_file)
```


```r
#d escompactando arquivo
(extract_dir <- gsub("\\.zip","",zip_file))
unzip(zip_file, exdir = extract_dir)
```

Lista dos arquivos shapefile da ANA baixados.


```r
shapefiles_list <- list.files("data/Bacia7",
                              pattern = "shp$", 
                              recursive = T, 
                              full.names = T)
```


```r
# nome do shapefile com a rede drenagem da bacia de interesse
dren_file <- grep(x = shapefiles_list, 
                    pattern = "Hidrografia 1000000", 
                    value = T)
dren_file
```

```
[1] "data/Bacia7/Hidrografia 1000000.shp"
```

```r
# importando shapefile
dren <- shapefile(dren_file)
# tabela de dados do shapefile
head(dren@data)
```

```
  COTRECHO COCURSODAG COBACIA     CORIO NUCOMPTREC NUDISTBACT NUDISTCDAG
0   119193    7754994 7754994 7754994_0      26.74     249.20          0
1   119205    7754992 7754992 7754992_0      22.23     236.06          0
2   119232     775496  775496  775496_0      54.82     226.03          0
3   119330    7754896 7754896 7754896_0      19.49     239.46          0
4   119334    7754898 7754898 7754898_0      22.48     240.18          0
5   119338    7756966 7756966 7756966_0       9.45     136.48          0
  NUAREACONT NUAREAMONT NUNIVOTTO DEDIREC DECORPODAG DELIGACAO NORIO
0     174.02     174.02         7       1       <NA>      <NA>  <NA>
1     134.21     134.21         7      -1       <NA>      <NA>  <NA>
2     472.32     472.32         6      -1        Rio      <NA>  Taió
3      88.65      88.65         7      -1       <NA>      <NA>  <NA>
4     117.04     117.04         7      -1       <NA>      <NA>  <NA>
5      37.89      37.89         7       1       <NA>      <NA>  <NA>
  NORIOCOMP NUCOMPRIO NUDISTBACR COCDADESAG NUCOMPCDA NUTRJUS NUTRMON
0      <NA>     26.74     249.20       7754     26.74  119197  119183
1      <NA>     22.23     236.06       7754     22.23  119200  119197
2  Rio Taió     54.82     226.03       7754     54.82  119219  119208
3      <NA>     19.49     239.46      77548     19.49  119312  119313
4      <NA>     22.48     240.18      77548     22.48  119313  119320
5      <NA>      9.45     136.48     775696      9.45  119346  119337
  NUTRAFL NUDISTBACC NUAREABACC DEMARGCONF NUORDEMCDA NUNIVOTCDA
0  119193     249.20     174.02    direita          2          7
1  119205     236.06     134.21    direita          2          7
2  119232     226.03     472.32    direita          2          6
3  119330      71.79      88.65   esquerda          3          7
4  119334      72.51     117.04   esquerda          3          7
5  119338      16.74      37.89    direita          3          7
  NULONGNOPA NULATNOPA NULONGNODE NULATNODE   DTVERSAO
0   -50.1648  -27.0127   -50.2988  -27.0100 07/12/2006
1   -50.0696  -27.0874   -50.2399  -27.0916 07/12/2006
2   -50.0043  -27.1173   -50.3296  -27.1291 07/12/2006
3   -49.3325  -27.6930   -49.3115  -27.8326 07/12/2006
4   -49.3248  -27.6928   -49.2797  -27.8578 07/12/2006
5   -49.2017  -27.8977   -49.2907  -27.8936 07/12/2006
```



```r
## selecionando somente as variáveis de interesse no slot de dados 
## do objeto dren (SpatialLinesDataFrame)  
dren@data <- subset(dren@data, sel = c("NORIO", "NORIOCOMP", "COBACIA", "CORIO")) 
## definindo o a projeção dos dados (que é mesma dos ) de acordo com a do Google Earth
dren_ll <- spTransform(dren, CRSobj = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0")
## gerando arquivo KML para visualização no google-earth
## salva no dir data_base_path
(kml_file <- gsub("X", id_bh, "data/drenX.kmz"))
```

```
[1] "data/dren7.kmz"
```

```r
KML(x = dren_ll, file = kml_file, overwrite = TRUE)
file.exists(kml_file)
```

```
[1] TRUE
```


# ploKML


[^1]: Para saber mais o conjunto de informações hidrológicas disponibilizadas pela ANA clique [aqui](http://www2.ana.gov.br/Paginas/servicos/informacoeshidrologicas/redehidro.aspx)


