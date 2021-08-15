#' surplus
#' @description Function to calculate surplus of the insurer
#'
#' @param time_line vector of time points
#' @param sample_size sample size
#' @param Mu intensity of the claim size
#' @param lambda claim arrival rate
#' @param initial_capital initial capital of the insurer
#' @param avg_premium_rate average premium rate
#'
#' @return An R object of class \code{surplus}
#'
#' @examples
#' surplus(1.2, 4, 3, 30)
#' surplus(seq(0, 1, 0.1), 4, 3, 30)
#'
#' @export
#' @importFrom stats rexp
#' @importFrom utils head
#'
surplus <- function(time_line, Mu, lambda, initial_capital,
                    sample_size = 30, avg_premium_rate = 1) {

  # Waiting time from exponential distribution ====
  W <- cumsum(rexp(sample_size, lambda))

  # Calculate aggregated claims ====
  Xt <- rexp(sample_size, Mu)
  St <- unlist(lapply(time_line, function(t) sum(Xt[W <= t])))

  # Calculate instantaneous surplus ====
  Ut <- initial_capital + avg_premium_rate * time_line - St

  # Return necessary output
  structure(list(time_line = time_line, St = St, Ut = Ut),
            class = "surplus")
}

#' print.surplus
#' @description print function for surplus
#' @param x a surplus class object
#' @param top number of rows to be printed
#'
#' @examples
#' print(surplus(c(1.2, 3.4), 4, 3, 30))
#'
#' @export
#' @importFrom utils head
#'
print.surplus <- function(x, top = length(x$Ut)) {
  print(head(x$Ut, top))
}

#' plot.surplus
#' @description plot function for surplus
#' @param x a surplus class object
#' @export
#'
plot.surplus <- function(x) {
  plot(x$time_line, x$Ut,
       main = "surplus plot of the insurer",
       xlab = "time",
       ylab = "surplus")
}
