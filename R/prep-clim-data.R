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


#-------------------------------------------------------
# metadata para os dados clima_rs
excel_file_url <- "http://www.inmet.gov.br/webcdp/climatologia/normais2/imagens/normais/planilhas/1961-1990/Relac_Est_Meteo_NC.xls"
dest_file_excel <- file.path(tempdir(), "Estacoes-Normal-Climatologica-1961-1990.xls")
download.file(excel_file_url, dest_file_excel)

source("~/Dropbox/github/my_reps/lhmet/inmetr/data-raw/bdmep_meta_funs.R")

inmet_nc_meta <- read_meteo_stn_xls(dest_file_excel) %>%
  as_tibble() %>%
  filter(uf == "RS") %>%
  select(-state) %>%
  rename("codigo" = id) %>%
  mutate(name = NULL, uf = NULL)
inmet_nc_meta

saveRDS(inmet_nc_meta, "../data/clima_rs_metadata_61_90.RDS")

