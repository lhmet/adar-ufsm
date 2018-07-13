
# dados para lista 4 do livro (capítulo 9)

pcks <- c("inmetr", "tidyverse", "lubridate")
easypackages::libraries(pcks)


#------------------------------------------------------------------
# Exercício 1

soi <- structure(list(
  YEAR = 1951:1953, 
  JAN = c(1.5, -0.9, 0.3), 
  FEB = c(0.9, -0.6, -0.5), 
  MAR = c(-0.1, 0.5, -0.2), 
  APR = c(-0.3, -0.2, 0.2), 
  MAY = c(-0.7, 0.8, -1.7), 
  JUN = c(0.2, 0.7, 0.1), 
  JUL = c(-1, 0.5, 0), 
  AUG = c(-0.2, 0.1, -1.2), 
  SEP = c(-1.1, -0.2, -1.2),
  OCT = c(-1, 0.4, 0.1), 
  NOV = c(-0.8, 0, -0.3), 
  DEC = c(-0.7, -1.2, -0.5)
), .Names = c(
  "YEAR", "1", "2", "3", "4",
  "5", "6", "7", "8", "9", 
  "10", "11", "12"
), row.names = c(
  NA,
  3L
), class = "data.frame")
soi


#------------------------------------------------------------------
# Exercício 2
precd_ncdf <- structure(
  list(
    x = c(
      -60.625, -60.375, -60.125, -60.625, -60.375
    ),
    y = c(
      5.125, 5.125, 5.125, 4.875, 4.875
    ),
    X2010.01.01.13.00.00 = c(
      0, 0, 0, 0, 0
    ),
    X2010.01.02.13.00.00 = c(
      0, 0, 0, 0, 0
    ),
    X2010.01.03.13.00.00 = c(
      0, 0, 0, 0, 0
    ),
    X2010.01.04.13.00.00 = c(
      0.448486328125, 0.44091796875, 0.5791015625, 0.441162109375, 0.3916015625
    ),
    X2010.01.05.13.00.00 = c(
      2.3515625, 1.189453125, 2.013671875, 1.939453125, 0.42822265625
    ),
    X2010.01.06.13.00.00 = c(
      4.49609375, 1.7568359375, 4.58984375, 3.919921875, 0.9443359375
    ),
    X2010.01.07.13.00.00 = c(
      0.1661376953125, 0.51904296875, 0.1339111328125, 0.1488037109375, 0.46240234375
    ),
    X2010.01.08.13.00.00 = c(0, 0, 0, 0, 0)
  ),
  .Names = c(
    "x",
    "y",
    "X2010.01.01",
    "X2010.01.02",
    "X2010.01.03",
    "X2010.01.04",
    "X2010.01.05",
    "X2010.01.06",
    "X2010.01.07",
    "X2010.01.08"
  ),
  row.names = c(NA, -5L),
  class = c("tbl_df", "tbl", "data.frame")
)
precd_ncdf


#------------------------------------------------------------------
# Exercício 3

poluentes <- read.table(
  text='
  poluente   duracao    estacao                 
      ozone         1h            1
        so2         1h            1
      ozone         8h            2
        no2         1h            4
                         ',
  header = TRUE, 
  stringsAsFactors = FALSE
) %>% 
  as_tibble(.) 
poluentes


#------------------------------------------------------------------
# Exercício 4

bdmep_meta <- as_tibble(bdmep_meta)

id_sm <- bdmep_meta %>%
  filter(name == "Santa Maria") %>%
  pull(id) 

data_sm <- bdmep_import(id_sm)

time_offset <- bdmep_meta %>%
  filter(id == id_sm) %>%
  select(offset_utc) %>% 
  pull()

data_sm_wide <- data_sm %>%
  mutate(date = date + time_offset * 3600) %>% #select(date, date2)
   group_by(day = as.Date(date), id) %>%
  summarise_at(., vars(tmax, tmin), .funs = mean, na.rm = TRUE) %>%
  ungroup(.) %>%
  gather(., element, valor, tmax:tmin) %>%
  rename(., date = "day") %>%
  mutate(.,
         day = paste0("d", day(date)),
         month = month(date),
         year = year(date),
         date = NULL) %>%
  spread(., day, valor) %>%
  filter(year == 2010, month %in% c(1:6)) %>%
  arrange(id, year, month) 

dcols <- names(data_sm_wide) %>% grep("d[0-9]", ., value = TRUE) 
cols_sel <- dcols[order(readr::parse_number(dcols))]
cols_sel

data_sm_wide <- data_sm_wide %>%
  select(., id:year, one_of(cols_sel))

dados_sm <- data_sm_wide
#saveRDS(data_sm_wide, "data/data_sm_wide.RDS")


#------------------------------------------------------------------
# Exercício 6

hdata <- read.table(
  text = '
date          tmax    tmax    tmax     tmax    tmin    tmin    tmin    tmin 
hour          0000    0600    1200    1800    0000    0600    1200    1800
01-01-2010    22.1    21.0    26.4    27.0    16.0    13.5    18.2    24.1
02-01-2010    26.0    25.0    29.4    29.5    19.0    13.7    16.3    22.3
03-01-2010    25.7    26.3    28.4    29.0    21.0    14.1    17.2    26.0
04-01-2010    23.5    24.5    27.4    28.0    23.0   16.2    16.9    23.0',
  header = TRUE, 
  stringsAsFactors = FALSE
) %>% 
 # as_tibble(.) %>%
  setNames(
    .,
    str_replace_all(
      names(.), 
      pattern = ".[0-9]{1}", 
      replacement = ""
    )
  )
hdata 

dados_zorra <- hdata
dados_zorra 
slice(dados_zorra, -1)
dados_zorra <- dados_zorra[-1, ]
names(dados_zorra)[-1] <- paste(
  names(dados_zorra)[-1],
  hdata[1, -1] %>% t() %>% c(),
  sep = "."
  )
dados_zorra
ls()

#------------------------------------------------------------------
# Exercício 7
estacoes <- read.table(header = TRUE, 
                       text = '
id        lat       lon 
1  42.467573  -87.810047
2  42.049148  -88.273029
3  39.110539  -90.324080'
)

#------------------------------------------------------------------
# Exercício 8
set.seed(2)
datas_comp <- tibble(date = today() + 0:6)
datas_obs <- tibble(date = today() + c(-1, 0, 1, 4),
                    theta = runif(length(c(-2, 0, 1, 4)),
                                min = 0.3,
                                max = 0.46)
                    )
datas_obs

#------------------------------------------------------------------
# Exercício 9 - 
# dados EMA de santa maria
# 

#------------------------------------------------------------------
# Salvando todos em um unico arquivo RData

save(soi, precd_ncdf, poluentes, estacoes,
     dados_sm, dados_zorra, datas_comp, datas_obs,
     file = "data/dados-lista-exerc4-cap9.RData")

