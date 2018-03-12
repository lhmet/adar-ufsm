## original idea & report by Henrik Bengtsson at
## https://stat.ethz.ch/pipermail/r-devel/2016-February/072388.html

## This script downloads the list of currently published R packages
## from CRAN and also looks at all the archived package versions to
## combine these into a list of all R packages ever published on
## CRAN with the date of first release.

## CRAN mirror to use
CRAN_page <- function(...) {
  file.path('https://cran.rstudio.com/src/contrib', ...)
}

## get list of currently available packages on CRAN
library(XML)
pkgs <- readHTMLTable(readLines(CRAN_page()),
                      which = 1, stringsAsFactors = FALSE)

## we love data.table
library(data.table)
setDT(pkgs)

## drop directories
pkgs <- pkgs[Size != '-']
## drop files that does not seem to be R packages
pkgs <- pkgs[grep('tar.gz$', Name)]

## package name should contain only (ASCII) letters, numbers and dot
pkgs[, name := sub('^([a-zA-Z0-9\\.]*).*', '\\1', Name)]

## grab date from last modified timestamp
pkgs[, date := as.POSIXct(`Last modified`, format = '%d-%b-%Y %H:%M')]
pkgs[, date := as.character(date)]

## keep date and name
pkgs <- pkgs[, .(name, date)]

## list of packages with at least one archived version
archives <- readHTMLTable(readLines(CRAN_page('Archive')),
                          which = 1, stringsAsFactors = FALSE)
setDT(archives)

## keep directories
archives <- archives[grep('/$', Name)]

## add packages not found in current list of R packages
archives[, Name := sub('/$', '', Name)]
pkgs <- rbind(pkgs,
              archives[!Name %in% pkgs$name, .(name = Name)],
              fill = TRUE)

## reorder pkg in alphabet order
setorder(pkgs, name)

## number of versions released is 1 for published packages
pkgs[, versions := 0]
pkgs[!is.na(date), versions := 1]

## mark archived pacakges
pkgs[, archived := FALSE]
pkgs[name %in% archives$Name, archived := TRUE]

## NA date of packages with archived versions
pkgs[archived == TRUE, date := NA]

## lookup release date of first version & number of releases
pkgs[is.na(date), c('date', 'versions') := {
  
  cat(name, '\n')
  
  ## download archive page
  page <- readLines(CRAN_page('Archive', name))
  
  ## extract date with regexp as HTML parsing can be slow :)
  date <- sub('.*([0-9]{2}-[A-Za-z]{3}-[0-9]{4} [0-9]{2}:[0-9]{2}).*', '\\1', page[10])
  
  ## convert to YYYY-mm-dd format
  date <- as.POSIXct(date, format = '%d-%b-%Y %H:%M')
  
  ## number of previous releases
  archived_versions <- length(page) - 9 - 4
  
  ## return
  list(as.character(date), versions + archived_versions)
  
}, by = name]

## rename cols
setnames(pkgs, 'date', 'first_release')

## order by date & alphabet
setorder(pkgs, first_release, name)
pkgs[, index := .I]
pkgs[c(250, 500, (1:13)*1000)]

##              name       first_release versions archived index
##  1:           gbm 2003-02-21 17:07:00       27     TRUE   250
##  2:         AMORE 2005-02-14 16:14:00       12     TRUE   500
##  3:        sbgcop 2007-03-09 21:17:00        2     TRUE  1000
##  4:    tikzDevice 2009-09-12 12:18:00       15     TRUE  2000
##  5:         pycno 2011-04-24 06:58:00        3     TRUE  3000
##  6:    ExPosition 2012-06-20 17:42:00        4     TRUE  4000
##  7:    inflection 2013-03-20 12:16:00        4     TRUE  5000
##  8:         dawai 2014-02-06 00:34:00        5     TRUE  6000
##  9:        sigloc 2014-10-22 21:14:00        1    FALSE  7000
## 10:        GenCAT 2015-07-01 14:06:00        3     TRUE  8000
## 11:         SALES 2016-01-12 21:07:00        1    FALSE  9000
## 12:     europepmc 2016-07-13 08:19:00        6     TRUE 10000
## 13:   bayesloglin 2016-12-19 07:33:00        2     TRUE 11000
## 14: issueReporter 2017-05-15 15:16:00        1    FALSE 12000
## 15:           IIS 2017-10-06 17:22:00        1    FALSE 13000

## plot trend
library(ggplot2)
ggplot(pkgs, aes(as.Date(first_release), index)) +
  geom_line(size = 2) +
  scale_x_date(date_breaks = '2 year', date_labels = '%Y') +
  scale_y_continuous(breaks = seq(0, 14000, 1000)) +
  xlab('') + ylab('') + theme_bw() +
  ggtitle('Number of R packages ever published on CRAN')

## store report
write.csv(pkgs, 'results.csv', row.names = FALSE)