#' Create Session
#'
#' @param prompt The initial prompt for the session.
#' @param source The source name (e.g., "sources/123" or just "123").
#' @param automation_mode Optional automation mode.
#' @param branch Optional branch name.
#' @return A list representing the created session.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_session_create(
#'     prompt = "Analyze the project structure",
#'     source = "my-repo"
#'   )
#' }
jules_session_create <- function(prompt,
                                 source,
                                 automation_mode = NULL,
                                 branch = NULL) {
  check_string(prompt)
  check_string(source)
  warn_alpha()

  source <- ensure_source_prefix(source)

  session_data <- list(
    prompt = prompt,
    sourceContext = list(
      source = source
    )
  )

  if (!is.null(automation_mode)) {
    session_data$automationMode <- automation_mode
  }

  if (!is.null(branch)) {
    session_data$githubRepoContext <- list(
      startingBranch = branch
    )
  }

  jules_request("sessions") |>
    httr2::req_method("POST") |>
    httr2::req_body_json(session_data) |>
    jules_perform()
}

#' List Sessions
#'
#' @return A tibble of sessions.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_sessions()
#' }
jules_sessions <- function() {
  warn_alpha()

  sessions <- jules_perform_all(
    path = "sessions",
    key = "sessions"
  )

  items_to_tibble(sessions)
}

#' Get Session
#'
#' @param name Session name (e.g., "sessions/123" or just "123").
#' @return A list representing the session.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_session_get("my-session")
#' }
jules_session_get <- function(name) {
  check_string(name)
  warn_alpha()

  name <- ensure_session_prefix(name)

  jules_request(name) |>
    jules_perform()
}

#' Approve Plan
#'
#' @param name Session name (e.g., "sessions/123" or just "123").
#' @return Response from the API.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_plan_approve("my-session")
#' }
jules_plan_approve <- function(name) {
  check_string(name)
  warn_alpha()

  name <- ensure_session_prefix(name)

  jules_request(glue::glue("{name}:approvePlan")) |>
    httr2::req_method("POST") |>
    jules_perform()
}

#' Send Message
#'
#' @param name Session name (e.g., "sessions/123" or just "123").
#' @param text Message text.
#' @return Response from the API.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_message_send("my-session", "What are the main entry points?")
#' }
jules_message_send <- function(name, text) {
  check_string(name)
  check_string(text)
  warn_alpha()

  name <- ensure_session_prefix(name)

  jules_request(glue::glue("{name}:sendMessage")) |>
    httr2::req_method("POST") |>
    httr2::req_body_json(list(message = list(text = text))) |>
    jules_perform()
}
