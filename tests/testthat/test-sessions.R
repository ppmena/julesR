test_that("list_sessions returns a tibble", {
  mock_resp <- list(sessions = list(list(name = "sessions/1")))

  testthat::with_mocked_bindings({
    suppressMessages(suppressWarnings(res <- list_sessions()))
    expect_s3_class(res, "tbl_df")
    expect_equal(res$name, "sessions/1")
  }, jules_perform_all = function(...) mock_resp$sessions)
})

test_that("create_session returns a session list", {
  mock_resp <- list(name = "sessions/new")

  testthat::with_mocked_bindings({
    suppressMessages(suppressWarnings(res <- create_session()))
    expect_equal(res$name, "sessions/new")
  }, jules_perform = function(...) mock_resp)
})

test_that("send_message works", {
  mock_resp <- list(done = TRUE)

  testthat::with_mocked_bindings({
    suppressMessages(suppressWarnings(res <- send_message("sessions/1", "hi")))
    expect_true(res$done)
  }, jules_perform = function(...) mock_resp)
})
