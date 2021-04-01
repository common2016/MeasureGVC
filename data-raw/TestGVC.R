## code to prepare `reg` dataset goes here
rm(list = ls())
library(decompr)
library(matlab)
data(leather)
decompr_object <- load_tables_vectors(inter,
                                      final,
                                      countries,
                                      industries,
                                      out)

# test A
hatx <- matrix(0,9,9)
diag(hatx) <- out
A <- inter %*% solve(hatx)

# test L
solve(eye(3)- A[1:3,1:3])

# test Vc
va <- out - colSums(inter)
va %*% solve(hatx)

# test ESR
Eint <- decompr_object$Am %*% out
Efd <- rowSums(decompr_object$Ym)
E <- Eint + Efd

# usethis::use_data(reg, overwrite = TRUE)
