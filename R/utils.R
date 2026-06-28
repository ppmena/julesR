#' Warn about alpha API
#'
#' @keywords internal
warn_alpha <- function() {
  cli::cli_warn(
    "The Jules API is currently in {.strong alpha} (v1alpha) and is subject to change.",
    .frequency = "once",
    .frequency_id = "jules_alpha_warning"
  )
}

#' Convert list to tibble row
#'
#' @param x A list
#' @return A tibble with 1 row
#' @keywords internal
as_tibble_row <- function(x) {
  # Handle nested lists by keeping them as list-columns
  x <- lapply(x, function(val) {
    if (is.list(val)) list(val) else val
  })
  # Ensure all elements are length 1 (some might be lists of length 1 now)
  tibble::as_tibble_row(x)
}

#' Validation helpers
#'
#' @param x Value to check.
#' @param arg_name Name of the argument for error messages.
#' @keywords internal
check_string <- function(x, arg_name = deparse(substitute(x))) {
  if (!is.character(x) || length(x) != 1 || is.na(x) || nchar(x) == 0) {
    cli::cli_abort("{.arg {arg_name}} must be a non-empty string.")
  }
}
