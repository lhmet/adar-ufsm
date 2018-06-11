#prep-clim data
library(tidyverse)
prec_rs <- readxl::read_excel("../data/Precipitacao-Acumulada_NCB_1961-1990.xls", 
                   col_names = TRUE,
                   skip = 3, na = "-") %>%
  setNames(., tolower(names(.))) %>%
  setNames(., stringi::stri_trans_general(names(.),"Latin-ASCII")) %>%
  rename("estacao" = `nome da estacao`) %>%
  filter(uf == "RS") %>%
  select(-(janeiro:dezembro)) %>%
  rename("prec" = ano)
prec_rs


tmax_rs <- readxl::read_excel("../data/Temperatura-Maxima_NCB_1961-1990.xls", 
                              col_names = TRUE,
                              skip = 3, na = "-") %>%
  setNames(., tolower(names(.))) %>%
  setNames(., stringi::stri_trans_general(names(.),"Latin-ASCII")) %>%
  rename("estacao" = `nome da estacao`) %>%
  filter(uf == "RS") %>%
  select(-(janeiro:dezembro)) %>%
  rename("tmax" = ano) %>%
  mutate(codigo = as.character(codigo))
tmax_rs 

j <- inner_join(prec_rs, tmax_rs) %>%
  filter(complete.cases(.))
View(j)
rio::export(j, "../data/clima-rs.RDS")
