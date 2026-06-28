#' List Activities
#'
#' @param parent Parent session name (e.g., "sessions/123")
#' @return A tibble of activities
#' @export
list_activities <- function(parent) {
  check_string(parent)
  warn_alpha()
  activities <- jules_perform_all(glue::glue("{parent}/activities"), "activities")
  rows <- lapply(activities, as_tibble_row)
  do.call(rbind, rows)
}

#' Get Activity
#'
#' @param name Activity name (e.g., "sessions/123/activities/456")
#' @return A list representing the activity
#' @export
get_activity <- function(name) {
  check_string(name)
  warn_alpha()
  jules_request(name) |>
    jules_perform()
}
