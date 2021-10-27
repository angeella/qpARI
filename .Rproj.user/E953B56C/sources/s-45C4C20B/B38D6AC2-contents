#include <RcppArmadillo.h>
#include <cmath> /* pow */
#include <algorithm> /* random_shuffle*/
using namespace Rcpp;

// [[Rcpp::depends(RcppArmadillo)]]
// [[Rcpp::plugins(cpp11)]] 
// [[Rcpp::export]] 

NumericVector pvQuantile(NumericMatrix QT, NumericVector Test, long double B) {
  
  int m = Test.size();
  int bb;
  long double count;
  NumericVector pv(m);
  NumericVector QTT = QT;
  QTT = Rcpp::abs(QTT);
  Test = Rcpp::abs(Test);
  for (bb=0; bb<m; bb++) {
   // count = fabs(Test[1]);
   // Test[bb] = fabs(Test[bb]);
    count = sum(Test[bb] <= QTT)/(B*B);
    pv[bb] = count;
    
  }
  return (pv);
}


/*** R
#m = 100
#n = 20
#B = 100
#alpha = 0.05
#data <- simulateData(pi0 = 0.9,m = m,n = n,rho = 0,alpha = 0.05,power = 0.8)
#data <- t(data)
#Observed Test
#Test <- oneSample(X = data)$Test
#Quantile matrix
#qT <- signFlipQuantile(t(data), B = B) #each columns represent the quantile distribution
#observed
#Obs_Quantile <- stats::quantile(Test, probs = seq(from=1/(B),to=1,by = 1/(B)))
#QT <- cbind(Obs_Quantile, qT) # first column is the observed one
#pv <-pvQuantile(QT = QT, Test = Test, B = B)
#pv1 <-sapply(c(1:m), function(x) sum(abs(Test[x]) <= abs(QT)))/(B*B)
*/