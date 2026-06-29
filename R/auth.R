#' Authenticate with Jules
#'
#' @param api_key Jules API key. If `NULL`, it looks for the `JULES_API_KEY`
#'   environment variable.
#' @return Invisibly returns the API key.
#' @export
#' @examples
#' \dontrun{
#' jules_auth("your_api_key")
#' }
jules_auth <- function(api_key = NULL) {
  if (is.null(api_key)) {
    api_key <- Sys.getenv("JULES_API_KEY")
  }

  if (identical(api_key, "")) {
    cli::cli_abort(
      c(
        "No API key found.",
        "i" = "Please set the {.envvar JULES_API_KEY} environment variable or provide it directly to {.fn jules_auth}."
      )
    )
  }

  options(julesr.api_key = api_key)
  invisible(api_key)
}

#' Get the current Jules API key
#'
#' @return The current API key.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_api_key()
#' }
jules_api_key <- function() {
  key <- getOption("julesr.api_key")

  if (is.null(key)) {
    key <- Sys.getenv("JULES_API_KEY")
  }

  if (identical(key, "")) {
    cli::cli_abort(
      c(
        "Jules API key not found.",
        "i" = "Use {.fn jules_auth} or set the {.envvar JULES_API_KEY} environment variable."
      )
    )
  }

  key
}
