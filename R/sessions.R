#' List Sessions
#'
#' @return A tibble of sessions
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   list_sessions()
#' }
list_sessions <- function() {
  warn_alpha()
  sessions <- jules_perform_all("sessions", "sessions")
  items_to_tibble(sessions)
}

#' Get Session
#'
#' @param name Session name (e.g., "sessions/123")
#' @return A list representing the session
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   get_session("sessions/my-session")
#' }
get_session <- function(name) {
  check_string(name)
  warn_alpha()
  jules_request(name) |>
    jules_perform()
}

#' Create Session
#'
#' @param session_data List containing session configuration
#' @return The created session
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   create_session(list(
#'     prompt = "Analyze the project structure",
#'     sourceContext = list(source = "sources/my-repo")
#'   ))
#' }
create_session <- function(session_data = list()) {
  warn_alpha()
  jules_request("sessions") |>
    httr2::req_method("POST") |>
    httr2::req_body_json(session_data) |>
    jules_perform()
}

#' Approve Plan
#'
#' @param name Session name
#' @return Response from the API
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   approve_plan("sessions/my-session")
#' }
approve_plan <- function(name) {
  check_string(name)
  warn_alpha()
  jules_request(glue::glue("{name}:approvePlan")) |>
    httr2::req_method("POST") |>
    jules_perform()
}

#' Send Message
#'
#' @param name Session name
#' @param text Message text
#' @return Response from the API
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   send_message("sessions/my-session", "What are the main entry points?")
#' }
send_message <- function(name, text) {
  check_string(name)
  check_string(text)
  warn_alpha()
  jules_request(glue::glue("{name}:sendMessage")) |>
    httr2::req_method("POST") |>
    httr2::req_body_json(list(message = list(text = text))) |>
    jules_perform()
}
