test_that("jules_request creates a valid request", {
  withr::with_options(list(jules_api_key = "test-key"), {
    req <- jules_request("sources")
    expect_s3_class(req, "httr2_request")
    expect_equal(req$url, "https://jules.googleapis.com/v1alpha/sources")
    expect_equal(req$headers$`X-Goog-Api-Key`, "test-key")
  })
})

test_that("jules_perform handles errors", {
  fake_resp <- httr2::response(
    status_code = 403,
    url = "http://example.com",
    headers = "Content-Type: application/json",
    body = charToRaw('{"error": {"message": "Forbidden"}}')
  )

  with_mocked_bindings({
    expect_error(jules_perform(httr2::request("http://example.com")), "Forbidden")
  }, req_perform = function(...) fake_resp, .package = "httr2")
})
