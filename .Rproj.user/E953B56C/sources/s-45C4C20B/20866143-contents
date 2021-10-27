#' @title lambdaOptQuantile
#' @description lambdaOptQuantile
#' @usage lambdaOptQuantile(B, pvalues, m, alpha)
#' @param B number of permutation, default 1000
#' @param pvalues pvalues
#' @param alpha alpha level, default 0.05
#' @param family family
#' @author Angela Andreella
#' @return Returns pvalues
#' @export


lambdaOptQuantile <- function(B = 1000, pvalues, alpha = 0.05, family){
  family_set <- c("simes", "finner")
  family <- match.arg(tolower(family), family_set)
  m <- length(pvalues)
  jump <- sum(pvalues == min(pvalues))
  
  if(family == "simes"){
    lambda <- (1/B * m)/(jump * alpha) 
  }
  if(family == "finner"){
    lambda <- (m-jump)/(jump*alpha*(B-1))
  }
  
   
  
  return(lambda)
}

