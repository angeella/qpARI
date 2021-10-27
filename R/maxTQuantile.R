#' @title maxT quantile approach
#' @description Performs maxT quantile approach
#' @usage maxTQuantile(X, B, alpha, label)
#' @param X data where rows represents the variables and columns the observations, the columns's name define the categories
#' @param B number of permutations to perform, default is 1000.
#' @param alpha alpha level
#' @param label labels of the observations, if NULL the columns's name are considered, default NULL
#' @author Angela Andreella
#' @return Returns the tests rejected by maxT Westfall and Young with respective indeces.
#' @export
#' @importFrom stats quantile

maxTQuantile <- function(X, B, alpha, label){
  
  if(!is.factor(label)){label <- factor(label)}
  qT <- permTQuantile(X, B = B, label = label)
  Test <- permTest(X, B = B, rand = F, label = label)$Test
  Obs_Quantile <- quantile(abs(Test), probs = seq(from=1/(B),to=1,by = 1/(B)))
  names(Obs_Quantile) <- NULL
  QT <-  cbind(Obs_Quantile, qT)
  maxTQ <- apply(QT, 2, max)
  padj <- sapply(c(1:length(Test)), function(x) sum(abs(maxTQ)>=abs(Test[x])))/B
  Q1Q <- sort(maxTQ)[(1-alpha)*(length(maxTQ))]
  praw <- pvQuantile(QT = abs(QT), Test = abs(Test), B = B)
 # QT <- QT[!(QT[,1]> Q1Q), ] 
  
 # QT_it <- list()
 # QT_it[[1]] <- QT
 # i <- 1
  
 # while(
 #   if(i==1){TRUE}else{dim(QT_it[[i]])[1]!=dim(QT_it[[i - 1]])[1]}){
 #   maxTQ <- apply(QT_it[[i]], 2, max)
#    cvQ <- sort(maxTQ)[(alpha)*(length(maxTQ))]
#    QT_it[[i + 1]] <- QT_it[[i]][!(QT_it[[i]][,1]>= cvQ), ] 
#    i <- i + 1
#  }
  cv_idx <- which(Obs_Quantile> Q1Q)
  idx <- which(abs(Test) > Obs_Quantile[cv_idx[1]])
  #pv <- pvQuantile(QT, Test, B)
  Test <- Test[idx]
  names(Test) <- idx
  return(data.frame(Test = Test, padj = padj[idx], praw = praw[idx]))  
}