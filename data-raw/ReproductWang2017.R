rm(list = ls())
library(matlab)
library(decompr)
library(reshape2)
library(tidyverse)
# library(MeasureGVC)
devtools::load_all()

# from WIOD website: http://www.wiod.org/database/wiots16
load('data-raw/wiot_r_Nov16/WIOT2014_October16_ROW.RData')

# contries, industries, inter
cnts <- unique(wiot$Country)[-45]
indus <- wiot$IndustryDescription[1:56]
G <- length(cnts)
N <- length(indus)
z <- select(wiot[1:(G*N),],AUS1:ROW56) %>% as.matrix()

# final demand
ymed <- select(wiot[1:(G*N),],AUS57:ROW61)
ysum <- function(country){
  ans <- select(ymed, contains(country)) %>% rowSums()
}
ans <- lapply(cnts, ysum)
ans <- bind_cols(ans)
names(ans) <- cnts
y <- as.matrix(ans)

# output
out <- wiot$TOT[1:(G*N)]

# get basic data
wwz <- load_tables_vectors(z, y, cnts, indus, out)

# reproduct table 3 in Wang et al. (2017)
dw <- partici_idx(wwz,'forward')
up <- partici_idx(wwz,'backward')

filter(dw, (cnts %in% c('CHN','DEU','IND','JPN','RUS','USA')) &
         (industry %in% c("Manufacture of coke and refined petroleum products ")))
filter(dw, (cnts %in% c('CHN','DEU','IND','JPN','RUS','USA')) &
         (industry %in% c("Manufacture of machinery and equipment n.e.c.")))
filter(up, (cnts %in% c('CHN','DEU','IND','JPN','RUS','USA')) &
         (industry %in% c("Manufacture of coke and refined petroleum products ")))
filter(up, (cnts %in% c('CHN','DEU','IND','JPN','RUS','USA')) &
         (industry %in% c("Manufacture of machinery and equipment n.e.c.")))
