#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::depends(RcppArmadillo)]]
// [[Rcpp::plugins(cpp11)]] 
// [[Rcpp::export]] 
arma::mat signFlipQuantile(arma::mat X, double B) {
  
  int m = X.n_rows;
  int n = X.n_cols;
  arma::vec probs(B);
  std::iota(probs.begin(), probs.end(), 1);
  probs = probs/B;
  
  arma::mat T(B, B-1, arma::fill::zeros);
  arma::vec eps, Tb, Tb0, Tb1, Tb2, eps1, Var, Test;
  
  //X = X / sqrt(n);    // scaling
  
  int bb;
  for (bb=0; bb<B-1; bb++) {
    eps = Rcpp::rbinom(n, 1, 0.5)*2 - 1;  // signs 
    eps1 = Rcpp::rbinom(n, 1, 1)*2 - 1;  // identity    
    Tb = X * eps;
    Tb1 = Tb / n; //mean
    Tb0 = (pow(X, 2) * eps1)/n; //E(x^2)
    Tb2 = pow(Tb1,2)/pow(n,2); //E(X)^2
    Tb =  (Tb0-Tb2)*(n/(n-1)); //sample var
    Var = sqrt(Tb/n);
    Test = Tb1/Var;
    int i;
    for (i = 0; i < m; i++){
      if( Var[i] == 0 ) {
        Test[i] = 0;
      } 
    }
    
    T.col(bb) = quantile(Test, probs);
    
  }
  return (T);
}


/*** R
m <- 100
n <- 10
B <- 200
X <- matrix(rnorm(m*n), ncol=n)
set.seed(123)
Test <- signFlipQuantile(X, B)
*/

