#' Authenticate with Jules API
#'
#' @param api_key A Jules API key. If NULL, looks for JULES_API_KEY environment variable.
#' @return Sets the api_key in options and returns it invisibly.
#' @export
jules_auth <- function(api_key = NULL) {
  if (!is.null(api_key)) {
    options(julesr.api_key = api_key)
    return(invisible(api_key))
  }

  api_key <- Sys.getenv("JULES_API_KEY")

  if (identical(api_key, "")) {
    cli::cli_abort(c(
      "No API key found.",
      "i" = "Please provide an API key using {.fn jules_auth} or set the {.env JULES_API_KEY} environment variable."
    ))
  }

  options(julesr.api_key = api_key)
  invisible(api_key)
}

#' Get the active Jules API key
#'
#' @return The Jules API key.
#' @keywords internal
jules_api_key <- function() {
  api_key <- getOption("julesr.api_key")

  if (is.null(api_key)) {
    api_key <- Sys.getenv("JULES_API_KEY")
  }

  if (is.null(api_key) || identical(api_key, "")) {
    cli::cli_abort(c(
      "No API key found.",
      "i" = "Please provide an API key using {.fn jules_auth} or set the {.env JULES_API_KEY} environment variable."
    ))
  }

  api_key
}
