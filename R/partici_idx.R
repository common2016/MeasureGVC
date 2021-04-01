#' Compute Participation Index for Forward and Backward Linkage
#'
#'
#' @param wwz a decompr class object from the \code{decompr} package.
#' @param linkage calculating selecting, \code{forward} or \code{backward}. Wang et al. (2017) puts forward
#'  algorithms of GVC participation index for forward and backward linkage.
#'
#' @references Wang, Z., et al., MEASURES OF PARTICIPATION IN GLOBAL VALUE CHAINS AND GLOBAL BUSINESS CYCLES. 2017, NBER.
#'
#'
#' @examples
#' # load example data
#' library(decompr)
#' data(leather)
#' # create intermediate object (class decompr)
#' decompr_object <- load_tables_vectors(inter,
#'                                      final,
#'                                      countries,
#'                                      industries,
#'                                      out)
#' partici_idx(decompr_object, 'forward')
#' @export


partici_idx <- function(wwz, linkage = 'forward'){
  # construct haty
  y <- rowSums(wwz$Y)
  haty <- matlab::zeros(wwz$G*wwz$N,wwz$G*wwz$N)
  diag(haty) <- y
  y <- matrix(y,ncol = 1)

  # construct hatv
  hatv <- matrix(0,length(wwz$Vc),length(wwz$Vc))
  diag(hatv) <- wwz$Vc

  # down stream and up stream
  ans <- dplyr::bind_rows(lapply(1:wwz$G, function(i) data.frame(cnts = wwz$k[i],industry = wwz$i)))
  if (linkage == 'forward'){
    dw <- rowSums(hatv %*% wwz$L %*% wwz$Am %*% wwz$B %*% haty)/(hatv %*% wwz$B %*% y)
    ans$down <- as.numeric(dw)
  }else if (linkage == 'backward'){
    up <- colSums(hatv %*% wwz$L %*% wwz$Am %*% wwz$B %*% haty)/(wwz$Vc %*% wwz$B %*% haty)
    ans$up <- as.numeric(up)
  }
  return(ans)
}
