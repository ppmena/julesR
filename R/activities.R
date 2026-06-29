#' List Activities
#'
#' @param parent Parent session name (e.g., "sessions/123").
#' @return A tibble of activities.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_activities("sessions/my-session")
#' }
jules_activities <- function(parent) {
  check_string(parent)
  warn_alpha()

  activities <- jules_perform_all(
    path = glue::glue("{parent}/activities"),
    key = "activities"
  )

  items_to_tibble(activities)
}

#' Get Activity
#'
#' @param name Activity name (e.g., "sessions/123/activities/456").
#' @return A list representing the activity.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_activity_get("sessions/my-session/activities/my-activity")
#' }
jules_activity_get <- function(name) {
  check_string(name)
  warn_alpha()

  jules_request(name) |>
    jules_perform()
}
