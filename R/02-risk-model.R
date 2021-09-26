#' Surplus function for individual risk model
#' @description Function to calculate surplus of the insurer under
#' individual risk model
#' @param time_points vector of time points, expecting to be increamental
#' @param n_policies number of independent policies
#' @param claim_size_rate rate of exponential claim size
#' @param initial_capital initial capital of the surplus
#' @param avg_premium_rate average premium rate
#' @examples
#' surplus_irm(seq(0, 1, 0.05))
#' @importFrom stats rbinom runif
#' @export
#'
surplus_irm <- function(time_points, n_policies = 5, claim_size_rate = 2,
                        initial_capital = 10, avg_premium_rate = 1) {

  # quick checks
  stopifnot(length(time_points) >= 1)

  n_claim_amounts <- rexp(n_policies, claim_size_rate)
  total_claim_amount <- sum(n_claim_amounts)
  claim_amounts <- list()

  # updating claim status chronologically
  i <- 0
  np <- n_policies
  policy_index <- 1:np
  claim_amount <- n_claim_amounts
  claim_amount_settled <- 0
  aggr_claim_amount <- list()
  settled_policies <- list()

  while(length(time_points) - i > 0 && claim_amount_settled < total_claim_amount) {

    claim_status <- unlist(lapply(runif(np), function(x) rbinom(1, 1, x)))
    claim_amount_settled <- claim_amount_settled + sum(claim_amount[claim_status == 1])

    claim_amount <- claim_amount[claim_status == 0]
    revoked_policies <- policy_index[claim_status == 1]

    np <- length(claim_amount)
    policy_index <- setdiff(policy_index, revoked_policies)
    aggr_claim_amount[[i + 1]] <- claim_amount_settled
    settled_policies[[i + 1]] <- revoked_policies
    i <- i + 1
  }

  # names(settled_policies) <- 1:length(settled_policies)
  time_points_input <- time_points
  time_points <- time_points_input[1:length(unlist(aggr_claim_amount))]

  structure(list(
    time_points_input = time_points_input,
    time_points = time_points,
    settled_policies = settled_policies,
    surplus = initial_capital + avg_premium_rate * time_points -
      unlist(aggr_claim_amount),
    aggr_claim_amount = unlist(aggr_claim_amount)),
    NoOfPolicies = n_policies,
    SumAssured = n_claim_amounts,
    class = "surplusirm")
}
