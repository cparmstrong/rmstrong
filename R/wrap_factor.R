
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

#' Ordered Factor String Wrapping
#'
#' When axis text is an ordered string and needs to be wrapped while preserving the ordering
#' @x a column of a dataframe containing the axis text to be wrapped and ordered
#' @n the number of characters in each line
#' wrap_factor()


wrap_factor() <- function(x, n) {
  levels(x) <- stringr::str_wrap(levels(x), n)
  x
}
