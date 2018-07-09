
# dados para lista 4 do livro (capítulo 9)

pcks <- c("inmetr", "tidyverse", "lubridate")
easypackages::libraries(pcks)

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

saveRDS(data_sm_wide, "data/data_sm_wide.RDS")
  