#' List Activities
#'
#' @param parent Parent session name (e.g., "sessions/123")
#' @return A tibble of activities
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   list_activities("sessions/my-session")
#' }
list_activities <- function(parent) {
  check_string(parent)
  warn_alpha()
  activities <- jules_perform_all(glue::glue("{parent}/activities"), "activities")
  items_to_tibble(activities)
}

#' Get Activity
#'
#' @param name Activity name (e.g., "sessions/123/activities/456")
#' @return A list representing the activity
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   get_activity("sessions/my-session/activities/my-activity")
#' }
get_activity <- function(name) {
  check_string(name)
  warn_alpha()
  jules_request(name) |>
    jules_perform()
}
