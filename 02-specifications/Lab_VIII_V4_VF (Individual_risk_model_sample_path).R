# beginning the code ====
# remove all the variables listed in the environment ====
rm(list=ls())

#' surplus (individual risk model)
#' @description Function to calculate surplus of the insurer under
#' individual risk model
#' @param t vector of time points
#' @param n number of independent policies
#' @param l rate of exponential claim size
#' @param u initial capital of the surplus
#' @param c average premium rate
#' 
#' @examples 
#' surplus(1.2, 5, 2, 10, 1)
#' surplus(c(1.2, 3.4)5, 2, 10, 1) 
#' 

t=c(0.1,0.2)
n=5

surplus <- function(t, 
                    n, l, 
                    u, c) {
  # generating (n times t) uniform random number: p_{i}(t)  ====
  Q <- runif(length(t)*n)
  
  # generating bernoulli random numbers of size 'n' ====
  I <- unlist(lapply(Q, function(v) {rbinom(1,1,v)}))
  I
  # determining time of claim arrival under each policy
  d <- unlist(lapply(I, function(v) {ifelse(v==1, t, Inf)}))
  d 
  
  # revoking the policy if the claim is reported
  I <- unlist(lapply(t, function(v) {Itemp[v>d]==0}))
  
  # generation 5 exponential random numbers (values of claims)
  X <- rexp(n,l)
  
  # risk of the insurer at time 't'
  S <-  unlist(lapply(t, function(v) {sum(I*X)}))
  
  # surplus at an instant of time 
  U <- u+c*t-S
  
  # return necessary output ====
  structure(list(time_line = t, S = S, U = U),
            class = "surplus")
}


print.surplus <- function(x, top = length(x$U)) {
  print(head(x$U, top))
}

# assigning plot
t=seq(0,15,0.001)
plot.surplus <- function(x) {
  plot(x$t, x$U,
       main = "Individual Risk Model [Surplus plot of the insurer]",
       xlab = "time",
       ylab = "surplus")
}

# Illustration ====
xx<- surplus(t,5,2,10,1)
print(xx, 20)
plot(xx)

# end of the code ====