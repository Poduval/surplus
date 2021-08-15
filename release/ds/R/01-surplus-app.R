#' @title surplus function
#' @description Interactive distribution of surplus function
#' @details Used for demonstration
#' @usage app_surplus()
#' @return Nothing
#' @import shiny
#' @export
#' @examples
#' if (interactive()) {
#'   app_surplus()
#' }
#'
app_surplus <- function() {

  app_dir = system.file("01-surplus", package = "ds")
  if (app_dir == "") stop("ERROR, try re-installing `ds`.", call. = FALSE)
  runApp(app_dir, display.mode = "normal")

}
