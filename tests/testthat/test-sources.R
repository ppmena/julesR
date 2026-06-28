test_that("jules_sources calls correct endpoint", {
  withr::local_options(list(julesr.api_key = "test-key"))

  mock_req <- function(req) {
    expect_equal(req$method, "GET")
    expect_equal(req$url, "https://jules.googleapis.com/v1alpha/sources")
    httr2::response(200, body = charToRaw('{"sources": []}'), headers = list("Content-Type" = "application/json"))
  }

  httr2::with_mocked_responses(mock_req, {
    res <- jules_sources()
    expect_equal(res$sources, list())
  })
})

test_that("jules_sources handles pagination", {
  withr::local_options(list(julesr.api_key = "test-key"))

  mock_req <- function(req) {
    expect_match(req$url, "pageSize=10")
    expect_match(req$url, "pageToken=foo")
    httr2::response(200, body = charToRaw('{"sources": []}'), headers = list("Content-Type" = "application/json"))
  }

  httr2::with_mocked_responses(mock_req, {
    jules_sources(page_size = 10, page_token = "foo")
  })
})

test_that("jules_source_get normalizes name", {
  withr::local_options(list(julesr.api_key = "test-key"))

  mock_req <- function(req) {
    expect_equal(req$url, "https://jules.googleapis.com/v1alpha/sources/abc")
    httr2::response(200, body = charToRaw('{"name": "sources/abc"}'), headers = list("Content-Type" = "application/json"))
  }

  httr2::with_mocked_responses(mock_req, {
    jules_source_get("abc")
    jules_source_get("sources/abc")
  })
})

test_that("jules_sources validates input", {
  expect_error(jules_sources(page_size = -1), "must be a positive integer")
  expect_error(jules_sources(page_token = ""), "must be a non-empty string")
})
