test_that("jules_activities calls correct endpoint", {
  withr::local_options(list(julesr.api_key = "test-key"))

  mock_req <- function(req) {
    expect_equal(req$method, "GET")
    expect_equal(req$url, "https://jules.googleapis.com/v1alpha/sessions/abc/activities")
    httr2::response(200, body = charToRaw('{"activities": []}'), headers = list("Content-Type" = "application/json"))
  }

  httr2::with_mocked_responses(mock_req, {
    jules_activities("abc")
  })
})

test_that("jules_activity_get respects full names", {
  withr::local_options(list(julesr.api_key = "test-key"))

  mock_req <- function(req) {
    expect_equal(req$url, "https://jules.googleapis.com/v1alpha/activities/xyz")
    httr2::response(200, body = charToRaw('{"name": "activities/xyz"}'), headers = list("Content-Type" = "application/json"))
  }

  httr2::with_mocked_responses(mock_req, {
    jules_activity_get("activities/xyz")
    jules_activity_get("xyz")
  })
})

test_that("activities validation works", {
  expect_error(jules_activities(session = ""), "must be a non-empty string")
  expect_error(jules_activity_get(activity = ""), "must be a non-empty string")
})
