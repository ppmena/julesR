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
#' @param x A list.
#' @return A tibble with 1 row.
#' @keywords internal
as_tibble_row <- function(x) {
  # Handle nested lists by keeping them as list-columns
  x <- lapply(x, function(val) {
    if (is.list(val)) {
      list(val)
    } else {
      val
    }
  })
  # Ensure all elements are length 1 (some might be lists of length 1 now)
  tibble::as_tibble_row(x)
}

#' Convert list of items to tibble
#'
#' @param items List of lists.
#' @return A tibble.
#' @keywords internal
items_to_tibble <- function(items) {
  if (length(items) == 0) {
    return(tibble::tibble())
  }
  rows <- lapply(items, as_tibble_row)
  do.call(rbind, rows)
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

#' Add session prefix
#'
#' @param name Session name.
#' @return Name with "sessions/" prefix.
#' @keywords internal
ensure_session_prefix <- function(name) {
  if (!grepl("^sessions/", name)) {
    return(paste0("sessions/", name))
  }
  name
}

#' Add source prefix
#'
#' @param name Source name.
#' @return Name with "sources/" prefix.
#' @keywords internal
ensure_source_prefix <- function(name) {
  if (!grepl("^sources/", name)) {
    return(paste0("sources/", name))
  }
  name
}
