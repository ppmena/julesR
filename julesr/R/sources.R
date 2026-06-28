#' List Sources
#'
#' @return A tibble of sources
#' @export
list_sources <- function() {
  warn_alpha()
  sources <- jules_perform_all("sources", "sources")
  rows <- lapply(sources, as_tibble_row)
  do.call(rbind, rows)
}

#' Get Source
#'
#' @param name Source name (e.g., "sources/123")
#' @return A list representing the source
#' @export
get_source <- function(name) {
  warn_alpha()
  jules_request(name) |>
    jules_perform()
}
