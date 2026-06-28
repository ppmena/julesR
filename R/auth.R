#' Set Jules API Key
#'
#' @param key Jules API key
#' @export
jules_auth <- function(key = Sys.getenv("JULES_API_KEY")) {
  if (is.null(key) || key == "") {
    cli::cli_abort(c(
      "No API key found.",
      "i" = "Please set {.envvar JULES_API_KEY} or provide it directly to {.fn jules_auth}."
    ))
  }
  options(julesr.api_key = key)
  invisible(key)
}

#' Get Jules API Key
#'
#' @return The API key
#' @keywords internal
get_api_key <- function() {
  key <- getOption("julesr.api_key") %||% Sys.getenv("JULES_API_KEY")
  if (is.null(key) || key == "") {
    cli::cli_abort(c(
      "Jules API key not found.",
      "i" = "Use {.fn jules_auth} or set {.envvar JULES_API_KEY}."
    ))
  }
  key
}

`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}
