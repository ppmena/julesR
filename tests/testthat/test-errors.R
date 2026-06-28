test_that("stop_http_error provides useful messages", {
  # Mock httr2 response
  resp <- list(status_code = 401)
  class(resp) <- "httr2_response"

  expect_error(stop_http_error(resp), "Authentication failed", class = "rlang_error")

  resp$status_code <- 404
  expect_error(stop_http_error(resp), "Resource not found", class = "rlang_error")

  resp$status_code <- 500
  expect_error(stop_http_error(resp), "Internal server error", class = "rlang_error")
})
