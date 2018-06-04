library(tidyverse)
source('~/Dropbox/github/my_reps/lhmet/inmetwrangler/R/import_txt_files_inmet.R', echo=TRUE)



files <- list.files("~/Dropbox/inmet-data/dados_inmet/RS/Santa Maria", pattern = "txt$", full.names = TRUE)
x <- import_txt_files_inmet(files[1])