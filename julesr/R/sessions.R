#' List Sessions
#'
#' @return A tibble of sessions
#' @export
list_sessions <- function() {
  warn_alpha()
  sessions <- jules_perform_all("sessions", "sessions")
  rows <- lapply(sessions, as_tibble_row)
  do.call(rbind, rows)
}

#' Get Session
#'
#' @param name Session name (e.g., "sessions/123")
#' @return A list representing the session
#' @export
get_session <- function(name) {
  warn_alpha()
  jules_request(name) |>
    jules_perform()
}

#' Create Session
#'
#' @param session_data List containing session configuration
#' @return The created session
#' @export
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
approve_plan <- function(name) {
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
send_message <- function(name, text) {
  warn_alpha()
  jules_request(glue::glue("{name}:sendMessage")) |>
    httr2::req_method("POST") |>
    httr2::req_body_json(list(message = list(text = text))) |>
    jules_perform()
}
