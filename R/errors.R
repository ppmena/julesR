#' Handle Jules API errors
#'
#' @param resp httr2 response.
#' @keywords internal
handle_error <- function(resp) {
  status <- httr2::resp_status(resp)
  status_desc <- httr2::resp_status_desc(resp)

  body <- tryCatch(
    httr2::resp_body_json(resp),
    error = function(e) NULL
  )

  error_msg <- body$error$message %||% "Unknown error"

  cli::cli_abort(
    c(
      "Jules API request failed [{status} {status_desc}]",
      "x" = "{error_msg}"
    ),
    call = NULL
  )
}

`%||%` <- function(x, y) {
  if (is.null(x)) {
    y
  } else {
    x
  }
}
