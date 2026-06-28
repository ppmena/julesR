.base_url <- "https://jules.googleapis.com/v1alpha"

#' Send a request to the Jules API
#'
#' @param path API endpoint path.
#' @param method HTTP method (GET, POST, PATCH, DELETE).
#' @param body Optional list to be converted to JSON.
#' @param query Optional query parameters.
#' @return The parsed JSON response as a list, or NULL if empty.
#' @keywords internal
jules_request <- function(path,
                          method = "GET",
                          body = NULL,
                          query = NULL) {

  api_key <- jules_api_key()

  # Construction of User-Agent
  version <- tryCatch(
    as.character(utils::packageVersion("julesr")),
    error = function(e) "0.0.0.9000"
  )
  ua <- paste0("julesr/", version)

  req <- httr2::request(.base_url) |>
    httr2::req_url_path_append(path) |>
    httr2::req_method(method) |>
    httr2::req_headers(
      "X-Goog-Api-Key" = api_key,
      "User-Agent" = ua
    )

  if (!is.null(query)) {
    req <- req |> httr2::req_url_query(!!!query)
  }

  if (!is.null(body)) {
    req <- req |>
      httr2::req_body_json(body)
  }

  resp <- req |>
    httr2::req_error(is_error = function(resp) FALSE) |>
    httr2::req_perform()

  if (httr2::resp_is_error(resp)) {
    stop_http_error(resp)
  }

  if (length(resp$body) == 0) {
    return(NULL)
  }

  httr2::resp_body_json(resp)
}
