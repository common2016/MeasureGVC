#' Compute Participation Index for Forward and Backward Linkage
#'
#'
#' @param wwz a decompr class object from the \code{decompr} package.
#' @param linkage calculating method, \code{forward} or \code{backward}. Wang et al. (2017) puts forward
#'  algorithms of GVC participation index for forward and backward linkage. I
#'  generate another method named \code{inner}.
#' @details A higher degree of forward participation than backward
#'  participation implies that the country/sector is more actively engaged
#'  in upstream production activities in GVCs.
#' @return a data.frame including countries, industires, GVC participation index
#' \enumerate{
#' \item cnts: contries
#' \item industry
#' \item up: GVC participation index for forward linkage
#' \item dw: GVC participation index for backward linkage
#' \item up_inner: inner circle measure for forward linkage
#' \item dw_inner: inner circle measure for backward linkage
#' }
#'
#' @references Wang, Z., et al., MEASURES OF PARTICIPATION IN GLOBAL VALUE CHAINS AND GLOBAL BUSINESS CYCLES. 2017, NBER.
#'
#'
#' @examples
#' # load example data
#' data(leather, package = 'decompr')
#' # create intermediate object (class decompr)
#' decompr_object <- decompr::load_tables_vectors(inter,
#'                                      final,
#'                                      countries,
#'                                      industries,
#'                                      out)
#' partici_idx(decompr_object, 'forward')
#' @export


partici_idx <- function(wwz, linkage = 'forward'){
  # construct haty and hatyd
  y <- rowSums(wwz$Y)
  yd <- rowSums(wwz$Yd)
  hatyd <- haty <- matlab::zeros(wwz$G*wwz$N,wwz$G*wwz$N)
  diag(haty) <- y
  diag(hatyd) <- yd
  y <- matrix(y,ncol = 1)
  yd <- matrix(yd,ncol = 1)

  # construct hatv
  hatv <- matrix(0,length(wwz$Vc),length(wwz$Vc))
  diag(hatv) <- wwz$Vc

  # up stream and down stream
  ans <- dplyr::bind_rows(lapply(1:wwz$G, function(i) data.frame(cnts = wwz$k[i],industry = wwz$i)))
  if (linkage == 'forward'){
    up <- rowSums(hatv %*% wwz$L %*% wwz$Am %*% wwz$B %*% haty)/(hatv %*% wwz$B %*% y)
    ans$up <- as.numeric(up)
  }else if (linkage == 'backward'){
    dw <- colSums(hatv %*% wwz$L %*% wwz$Am %*% wwz$B %*% haty)/(wwz$Vc %*% wwz$B %*% haty)
    ans$dw <- as.numeric(dw)
  }else if (linkage == 'inner'){
    up_inner <- rowSums(hatv %*% wwz$L %*% hatyd)/(hatv %*% wwz$B %*% y)
    dw_inner <- colSums(hatv %*% wwz$L %*% hatyd)/(wwz$Vc %*% wwz$B %*% haty)
    ans$up_inner <- as.numeric(up_inner)
    ans$dw_inner <- as.numeric(dw_inner)
  }
  return(ans)
}
