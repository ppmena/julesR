test_that("jules_session_create generates correct body", {
  withr::local_options(list(julesr.api_key = "test-key"))

  mock_req <- function(req) {
    body <- httr2::resp_body_json(httr2::response(200, body = req$body$data))
    expect_equal(body$prompt, "test prompt")
    expect_equal(body$sourceContext$source, "sources/test-source")
    expect_equal(body$requirePlanApproval, FALSE)
    expect_null(body$githubRepoContext)
    expect_null(body$title)

    httr2::response(201, body = charToRaw('{"name": "sessions/123"}'), headers = list("Content-Type" = "application/json"))
  }

  httr2::with_mocked_responses(mock_req, {
    jules_session_create(prompt = "test prompt", source = "test-source")
  })
})

test_that("jules_session_create adds optional fields", {
  withr::local_options(list(julesr.api_key = "test-key"))

  mock_req <- function(req) {
    body <- httr2::resp_body_json(httr2::response(200, body = req$body$data))
    expect_equal(body$githubRepoContext$startingBranch, "main")
    expect_equal(body$title, "my title")
    expect_equal(body$automationMode, "AUTO")

    httr2::response(201, body = charToRaw('{"name": "sessions/123"}'), headers = list("Content-Type" = "application/json"))
  }

  httr2::with_mocked_responses(mock_req, {
    jules_session_create(
      prompt = "p", source = "s",
      branch = "main", title = "my title", automation_mode = "AUTO"
    )
  })
})

test_that("jules_sessions calls correct endpoint", {
  withr::local_options(list(julesr.api_key = "test-key"))

  mock_req <- function(req) {
    expect_equal(req$url, "https://jules.googleapis.com/v1alpha/sessions")
    httr2::response(200, body = charToRaw('{"sessions": []}'), headers = list("Content-Type" = "application/json"))
  }

  httr2::with_mocked_responses(mock_req, {
    jules_sessions()
  })
})

test_that("jules_session_get normalizes name", {
  withr::local_options(list(julesr.api_key = "test-key"))

  mock_req <- function(req) {
    expect_equal(req$url, "https://jules.googleapis.com/v1alpha/sessions/abc")
    httr2::response(200, body = charToRaw('{"name": "sessions/abc"}'), headers = list("Content-Type" = "application/json"))
  }

  httr2::with_mocked_responses(mock_req, {
    jules_session_get("abc")
  })
})

test_that("jules_plan_approve calls correct endpoint", {
  withr::local_options(list(julesr.api_key = "test-key"))

  mock_req <- function(req) {
    expect_equal(req$method, "POST")
    expect_equal(req$url, "https://jules.googleapis.com/v1alpha/sessions/abc:approvePlan")
    httr2::response(200, body = charToRaw('{}'), headers = list("Content-Type" = "application/json"))
  }

  httr2::with_mocked_responses(mock_req, {
    jules_plan_approve("abc")
  })
})

test_that("jules_message_send calls correct endpoint", {
  withr::local_options(list(julesr.api_key = "test-key"))

  mock_req <- function(req) {
    expect_equal(req$method, "POST")
    expect_equal(req$url, "https://jules.googleapis.com/v1alpha/sessions/abc:sendMessage")
    body <- httr2::resp_body_json(httr2::response(200, body = req$body$data))
    expect_equal(body$message, "hello")
    httr2::response(200, body = charToRaw('{}'), headers = list("Content-Type" = "application/json"))
  }

  httr2::with_mocked_responses(mock_req, {
    jules_message_send("abc", "hello")
  })
})

test_that("sessions validation works", {
  expect_error(jules_session_create(prompt = "", source = "s"), "must be a non-empty string")
  expect_error(jules_session_create(prompt = "p", source = ""), "must be a non-empty string")
  expect_error(jules_message_send("abc", ""), "must be a non-empty string")
})
