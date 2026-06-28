#' List activities for a session
#'
#' @param session Mandatory. The name or ID of the session.
#' @param page_size Optional. Positive integer. Maximum number of activities to return.
#' @param page_token Optional. Non-empty string. Token for the next page of results.
#' @return A list containing the activities and a next page token if available.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_activities("abc")
#' }
jules_activities <- function(session, page_size = NULL, page_token = NULL) {
  check_string(session)
  session_name <- as_session_name(session)
  path <- paste0(session_name, "/activities")

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

  jules_request(path, query = query)
}

#' Get an activity
#'
#' @param activity Mandatory. The name or ID of the activity.
#' @return A list representing the activity.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_activity_get("activities/abc")
#' }
jules_activity_get <- function(activity) {
  check_string(activity)
  name <- as_activity_name(activity)
  jules_request(name)
}
