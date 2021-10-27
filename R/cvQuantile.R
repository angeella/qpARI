#' @title cvQuantile
#' @description cvQuantile
#' @usage cvQuantile(B, pv, m, alpha)
#' @param lambda lambda
#' @param pvalues pvalues
#' @param alpha alpha level, default 0.05
#' @param family family
#' @author Angela Andreella
#' @return Returns pvalues
#' @export
#' 


cvQuantile <- function(pvalues, alpha = 0.05, lambda, family){
  family_set <- c("simes", "finner")
  family <- match.arg(tolower(family), family_set)
  m <- length(pvalues)
  
  if(family == "simes"){
    cv <- sapply(c(1:m), function(x) (((x) * alpha * lambda)/(m)))
  }
  if(family == "finner"){
    cv <- sapply(c(1:m), function(x) (((x) * alpha * lambda)/(m - x*(1- alpha*lambda))))
  }
  
  
  return(cv)
}