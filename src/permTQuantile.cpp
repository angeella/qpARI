#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::depends(RcppArmadillo)]]
// [[Rcpp::plugins(cpp11)]] 
// [[Rcpp::export]] 
arma::mat permTQuantile(arma::mat X, double B, arma::vec label) {
  
  int m = X.n_rows;
  arma::vec probs(B);
  std::iota(probs.begin(), probs.end(), 1);
  probs = probs/B;
  double n1, n2;
  arma::vec permLabel, M1, M2, Tb01, Tb02, Tb1, Tb2, Tb21, Tb22, pV, I1, I2, Test;
  std::vector<int>::iterator id;
  
  n1 = std::count(label.begin(), label.end(), 2);
  n2 = std::count(label.begin(), label.end(), 1);
  arma::mat T(B, B-1, arma::fill::zeros);
  arma::mat X1(m, n1, arma::fill::zeros);
  arma::mat X2(m, n2, arma::fill::zeros);
  I1 = Rcpp::rbinom(n1, 1, 1)*2 - 1;
  I2 = Rcpp::rbinom(n2, 1, 1)*2 - 1;
  
  int bb;
  for (bb=0; bb<B-1; bb++) {
    
    //std::random_device rd;
    //std::mt19937 g(rd());
    std::random_shuffle(label.begin(), label.end());
    
    //std::shuffle(label.begin(), label.end(), g);
    
    X1 = X.cols(find(label == 2));
    X2 = X.cols(find(label == 1)); 
    M1 = (X1 * I1);
    M2 = (X2 * I2);
    Tb01 = pow(X1, 2) * I1; 
    Tb21 = pow(M1,2); 
    Tb1 =  (Tb01 - Tb21/n1)/(n1-1); 
    Tb02 = pow(X2, 2) * I2;
    Tb22 = pow(M2,2);
    Tb2 =  (Tb02 - Tb22/n2)/(n2-1); 
    pV = (Tb1/n1) + (Tb2/n2);
    Test = (M1/n1 - M2/n2)/sqrt(pV);
    int i;
    for (i = 0; i < m; i++){
      if( pV[i] == 0 ) {
        Test[i] = 0;
      } 
    }
    
    T.col(bb) = quantile(abs(Test), probs);
  }
  return (T);
}


/*** R
#data(golub)
#X = golub
#B = 100
#label = factor(golub.cl)
#Test<- permTQuantile(X , B, label)
*/

