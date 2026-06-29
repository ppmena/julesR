#' List Sources
#'
#' @return A tibble of sources
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   list_sources()
#' }
list_sources <- function() {
  warn_alpha()
  sources <- jules_perform_all("sources", "sources")
  items_to_tibble(sources)
}

#' Get Source
#'
#' @param name Source name (e.g., "sources/123")
#' @return A list representing the source
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   get_source("sources/my-repo")
#' }
get_source <- function(name) {
  check_string(name)
  warn_alpha()
  jules_request(name) |>
    jules_perform()
}
