test_that("jules_request constructs correct request", {
  withr::local_options(list(julesr.api_key = "test-key"))

  my_mock <- function(req) {
    expect_equal(req$url, "https://jules.googleapis.com/v1alpha/test-path")
    expect_equal(req$method, "GET")
    expect_equal(req$headers[["X-Goog-Api-Key"]], "test-key")

    httr2::response(
      status_code = 200,
      headers = list("Content-Type" = "application/json"),
      body = charToRaw(jsonlite::toJSON(list(foo = "bar"), auto_unbox = TRUE))
    )
  }

  httr2::with_mocked_responses(my_mock, {
    res <- jules_request("test-path")
    expect_equal(res, list(foo = "bar"))
  })
})

test_that("jules_request handles body and POST", {
  withr::local_options(list(julesr.api_key = "test-key"))

  my_mock <- function(req) {
    expect_equal(req$method, "POST")
    expect_equal(req$body$content_type, "application/json")

    httr2::response(
      status_code = 201,
      headers = list("Content-Type" = "application/json"),
      body = charToRaw(jsonlite::toJSON(list(status = "created"), auto_unbox = TRUE))
    )
  }

  httr2::with_mocked_responses(my_mock, {
    res <- jules_request("test-path", method = "POST", body = list(x = 1))
    expect_equal(res, list(status = "created"))
  })
})

test_that("jules_request handles empty response", {
  withr::local_options(list(julesr.api_key = "test-key"))

  my_mock <- function(req) {
    httr2::response(
      status_code = 204,
      body = raw(0)
    )
  }

  httr2::with_mocked_responses(my_mock, {
    res <- jules_request("test-path", method = "DELETE")
    expect_null(res)
  })
})

test_that("jules_request handles errors", {
  withr::local_options(list(julesr.api_key = "test-key"))

  my_mock <- function(req) {
    httr2::response(
      status_code = 403
    )
  }

  httr2::with_mocked_responses(my_mock, {
    expect_error(jules_request("test-path"), "Permission denied", class = "rlang_error")
  })
})
