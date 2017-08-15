// saved as sg1.stan
// https://rpubs.com/kaz_yos/stan-pois1
data {
    // Number of Observations
    int<lower=0> J;   
    
    // Number of beta params
    int<lower=0> p;

   // Covariates
    int <lower=0, upper=1> intercept[J]; 
    int <lower=0, upper=1> PostcodeAreaEC[J];

    // outcomes
    int<lower=0> y[J];        // actual response
}


parameters {
   // Define parameters to estimate
   real alpha;
   real beta[p];
}
 
transformed parameters  {
   //
   real lp[J];
   real <lower=0> mu[J];
 
   for (i in 1:J) {
     // Linear predictor
     lp[i] = alpha + 
     beta[1]*PostcodeAreaEC[i]; // +

     // Mean
     mu[i] = exp(lp[i]);
  }
}
 
 model {
   // Prior part of Bayesian inference
   mu ~ normal(0,1e6); // 
   
   // Likelihood part of Bayesian inference
   y ~ poisson(mu);
}
