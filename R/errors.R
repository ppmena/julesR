#' Handle HTTP errors
#'
#' Centralized logic for mapping HTTP status codes to user-friendly messages.
#'
#' @param resp The httr2 response object.
#' @keywords internal
stop_http_error <- function(resp) {
  status <- httr2::resp_status(resp)

  msg <- switch(
    as.character(status),
    "400" = "Bad request. Please check your arguments.",
    "401" = "Authentication failed. Verify your JULES_API_KEY.",
    "403" = "Permission denied. You do not have access to this resource.",
    "404" = "Resource not found.",
    "409" = "Conflict. The resource might already exist.",
    "429" = "Rate limit exceeded. Please slow down.",
    "500" = "Internal server error at Jules API.",
    "503" = "Service unavailable. Jules API is temporarily down.",
    paste("HTTP error", status)
  )

  cli::cli_abort(c(
    "x" = "Jules API error: {msg}",
    "i" = "Status code: {status}"
  ), call = rlang::caller_env())
}
