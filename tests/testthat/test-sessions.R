test_that("jules_sessions returns a tibble", {
  mock_resp <- list(sessions = list(list(name = "sessions/1")))

  testthat::with_mocked_bindings({
    suppressMessages(suppressWarnings(res <- jules_sessions()))
    expect_s3_class(res, "tbl_df")
    expect_equal(res$name, "sessions/1")
  }, jules_perform_all = function(...) mock_resp$sessions)
})

test_that("jules_session_create returns a session list", {
  mock_resp <- list(name = "sessions/new")

  testthat::with_mocked_bindings({
    suppressMessages(
      suppressWarnings(
        res <- jules_session_create(prompt = "test", source = "sources/1")
      )
    )
    expect_equal(res$name, "sessions/new")
  }, jules_perform = function(...) mock_resp)
})

test_that("jules_message_send works", {
  mock_resp <- list(done = TRUE)

  testthat::with_mocked_bindings({
    suppressMessages(suppressWarnings(res <- jules_message_send("sessions/1", "hi")))
    expect_true(res$done)
  }, jules_perform = function(...) mock_resp)
})

test_that("jules_plan_approve works", {
  mock_resp <- list(done = TRUE)

  testthat::with_mocked_bindings({
    suppressMessages(suppressWarnings(res <- jules_plan_approve("sessions/1")))
    expect_true(res$done)
  }, jules_perform = function(...) mock_resp)
})
