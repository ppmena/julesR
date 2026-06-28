#' Base request for Jules API
#'
#' @param path API path
#' @return A httr2 request object
#' @keywords internal
jules_request <- function(path) {
  base_url <- "https://jules.googleapis.com/v1alpha"

  # User-Agent
  version <- tryCatch(
    as.character(utils::packageVersion("julesr")),
    error = function(e) "0.0.0.9000"
  )
  ua <- paste0("julesr/", version)

  httr2::request(base_url) |>
    httr2::req_url_path_append(path) |>
    httr2::req_headers(
      `X-Goog-Api-Key` = get_api_key(),
      `User-Agent` = ua
    ) |>
    httr2::req_error(is_error = function(resp) FALSE)
}

#' Perform Jules API request
#'
#' @param req httr2 request
#' @return Parsed JSON response
#' @keywords internal
jules_perform <- function(req) {
  resp <- httr2::req_perform(req)

  if (httr2::resp_is_error(resp)) {
    handle_error(resp)
  }

  if (length(resp$body) == 0) {
    return(NULL)
  }

  httr2::resp_body_json(resp)
}

#' Perform paginated Jules API request
#'
#' @param path API path
#' @param key Key for the list in the response (e.g., "sources")
#' @param query Optional query parameters
#' @return A list of all items
#' @keywords internal
jules_perform_all <- function(path, key, query = list()) {
  all_items <- list()
  next_page_token <- NULL

  repeat {
    req <- jules_request(path) |>
      httr2::req_url_query(!!!query, pageToken = next_page_token)

    resp_json <- jules_perform(req)

    items <- resp_json[[key]]
    if (!is.null(items)) {
      all_items <- c(all_items, items)
    }

    next_page_token <- resp_json$nextPageToken
    if (is.null(next_page_token) || next_page_token == "") {
      break
    }
  }

  all_items
}
