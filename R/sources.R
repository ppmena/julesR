#' List Sources
#'
#' @return A tibble of sources.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_sources()
#' }
jules_sources <- function() {
  warn_alpha()

  sources <- jules_perform_all(
    path = "sources",
    key = "sources"
  )

  items_to_tibble(sources)
}

#' Get Source
#'
#' @param name Source name (e.g., "sources/123").
#' @return A list representing the source.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_source_get("sources/my-repo")
#' }
jules_source_get <- function(name) {
  check_string(name)
  warn_alpha()

  jules_request(name) |>
    jules_perform()
}
