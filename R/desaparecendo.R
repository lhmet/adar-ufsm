sumir <- function(palavra = "Desaparecendo") {
  cada_letra <- unlist(stringr::str_split(palavra, ""))
  cada_letra
  
  seq_decresc <- mapply(seq, from = 1, to = length(cada_letra):1)
  
  d <- plyr::ldply(seq_decresc
  #sapply(seq_decresc
              ,function(intervalo){
                # intervalo <- seq_decresc[[2]]
                s <- paste0(cada_letra[intervalo], collapse = "")
                s %>% str_pad(width = nchar(palavra),side = "right")
               },.id = NA)
  names(d) <- ""
  d
}

print(sumir(), quote = FALSE)