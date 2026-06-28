#' List sources
#'
#' @param page_size Optional. Positive integer. Maximum number of sources to return.
#' @param page_token Optional. Non-empty string. Token for the next page of results.
#' @return A list containing the sources and a next page token if available.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_sources()
#' }
jules_sources <- function(page_size = NULL, page_token = NULL) {
  query <- list()

  if (!is.null(page_size)) {
    if (!is.numeric(page_size) || page_size <= 0) {
      cli::cli_abort("{.arg page_size} must be a positive integer.")
    }
    query$pageSize <- page_size
  }

  if (!is.null(page_token)) {
    check_string(page_token)
    query$pageToken <- page_token
  }

  if (length(query) == 0) {
    query <- NULL
  }

  jules_request("sources", query = query)
}

#' Get a source
#'
#' @param name The name or ID of the source.
#' @return A list representing the source.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_source_get("abc")
#' }
jules_source_get <- function(name) {
  check_string(name)
  name <- as_source_name(name)
  jules_request(name)
}
