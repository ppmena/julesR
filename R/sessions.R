#' Create a new session
#'
#' @param prompt Mandatory. Non-empty string. The task description.
#' @param source Mandatory. Non-empty string. The source name or ID.
#' @param branch Optional. Non-empty string. The starting branch.
#' @param title Optional. Non-empty string. A title for the session.
#' @param require_plan_approval Boolean. Whether a plan must be approved before execution.
#' @param automation_mode Optional. Non-empty string. The automation mode.
#' @return A list representing the created session.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_session_create(
#'     prompt = "Fix the bug in the main function",
#'     source = "my-repo"
#'   )
#' }
jules_session_create <- function(prompt,
                                 source,
                                 branch = NULL,
                                 title = NULL,
                                 require_plan_approval = FALSE,
                                 automation_mode = NULL) {
  check_string(prompt)
  check_string(source)

  body <- list(
    prompt = prompt,
    sourceContext = list(
      source = as_source_name(source)
    ),
    requirePlanApproval = require_plan_approval
  )

  if (!is.null(branch)) {
    check_string(branch)
    body$githubRepoContext <- list(startingBranch = branch)
  }

  if (!is.null(title)) {
    check_string(title)
    body$title <- title
  }

  if (!is.null(automation_mode)) {
    check_string(automation_mode)
    body$automationMode <- automation_mode
  }

  jules_request("sessions", method = "POST", body = body)
}

#' List sessions
#'
#' @param page_size Optional. Positive integer. Maximum number of sessions to return.
#' @param page_token Optional. Non-empty string. Token for the next page of results.
#' @return A list containing the sessions and a next page token if available.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_sessions()
#' }
jules_sessions <- function(page_size = NULL, page_token = NULL) {
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

  jules_request("sessions", query = query)
}

#' Get a session
#'
#' @param session The name or ID of the session.
#' @return A list representing the session.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_session_get("abc")
#' }
jules_session_get <- function(session) {
  check_string(session)
  name <- as_session_name(session)
  jules_request(name)
}

#' Approve a plan
#'
#' @param session The name or ID of the session.
#' @param plan Optional. The plan to approve.
#' @return A list representing the updated session or result.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_plan_approve("abc")
#' }
jules_plan_approve <- function(session, plan = NULL) {
  check_string(session)
  name <- as_session_name(session)
  path <- paste0(name, ":approvePlan")

  body <- list()
  if (!is.null(plan)) {
    body$plan <- plan
  }

  if (length(body) == 0) {
    body <- NULL
  }

  jules_request(path, method = "POST", body = body)
}

#' Send a message to a session
#'
#' @param session The name or ID of the session.
#' @param message Mandatory. Non-empty string. The message to send.
#' @return A list representing the updated session or result.
#' @export
#' @examples
#' if (nzchar(Sys.getenv("JULES_API_KEY"))) {
#'   jules_message_send("abc", "Hello Jules")
#' }
jules_message_send <- function(session, message) {
  check_string(session)
  check_string(message)

  name <- as_session_name(session)
  path <- paste0(name, ":sendMessage")

  body <- list(message = message)

  jules_request(path, method = "POST", body = body)
}
