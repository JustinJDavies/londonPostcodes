// saved as sg1.stan
// https://rpubs.com/kaz_yos/stan-pois1
data {
    // Number of Observations
    int<lower=0> J;   
    
    // Number of beta params
    int<lower=0> p;

   // Covariates
      //    "(Intercept)"    "PostcodeAreaEC" "PostcodeAreaN" 
      // [4] "PostcodeAreaNW" "PostcodeAreaSE" "PostcodeAreaSW"
      // [7] "PostcodeAreaW"  "PostcodeAreaWC"
    int <lower=0, upper=1> intercept[J]; 
    int <lower=0, upper=1> PostcodeAreaE[J];
    int <lower=0, upper=1> PostcodeAreaEC[J];
    int <lower=0, upper=1> PostcodeAreaN[J];
    int <lower=0, upper=1> PostcodeAreaNW[J];
    int <lower=0, upper=1> PostcodeAreaSE[J];
    int <lower=0, upper=1> PostcodeAreaSW[J];
    int <lower=0, upper=1> PostcodeAreaW[J];
    int <lower=0, upper=1> PostcodeAreaWC[J];
    
    // offset NYI
    //real offset[J]
    
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
     lp[i] = alpha + beta[1]*PostcodeAreaE[i] + beta[2]*PostcodeAreaEC[i] + beta[3]*PostcodeAreaN[i] + beta[4]*PostcodeAreaNW[i] + beta[5]*PostcodeAreaSE[i] + beta[6]*PostcodeAreaSW[i]+ beta[7]*PostcodeAreaW[i] + beta[8]*PostcodeAreaWC[i]; // NYI // + offset[i];
 
     // Mean
     mu[i] = exp(lp[i]);
  }
}
 
 model {
   // Prior part of Bayesian inference
   // Flat prior for mu (no need to specify if non-informative)
   alpha ~ normal(0,1e6); // 
   beta ~ normal(0, 10); // Weakly informative prior
 
   // Likelihood part of Bayesian inference
   y ~ poisson(mu);
}
