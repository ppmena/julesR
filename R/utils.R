#' Normalize resource names
#'
#' @param name The resource name or ID.
#' @param prefix The prefix to ensure (e.g., "sessions/").
#' @return The normalized resource name.
#' @keywords internal
as_resource_name <- function(name, prefix) {
  check_string(name)
  if (grepl(paste0("^", prefix), name)) {
    name
  } else {
    paste0(prefix, name)
  }
}

#' @rdname as_resource_name
#' @keywords internal
as_session_name <- function(name) {
  as_resource_name(name, "sessions/")
}

#' @rdname as_resource_name
#' @keywords internal
as_source_name <- function(name) {
  as_resource_name(name, "sources/")
}

#' @rdname as_resource_name
#' @keywords internal
as_activity_name <- function(name) {
  as_resource_name(name, "activities/")
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

#' @rdname check_string
#' @keywords internal
check_not_null <- function(x, arg_name = deparse(substitute(x))) {
  if (is.null(x)) {
    cli::cli_abort("{.arg {arg_name}} cannot be NULL.")
  }
}
