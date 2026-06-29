test_that("jules_activities returns a tibble", {
  mock_activities <- list(list(name = "sessions/1/activities/1"))

  testthat::with_mocked_bindings({
    suppressMessages(suppressWarnings(res <- jules_activities("sessions/1")))
    expect_s3_class(res, "tbl_df")
    expect_equal(nrow(res), 1)
    expect_equal(res$name, "sessions/1/activities/1")
  }, jules_perform_all = function(...) mock_activities)
})

test_that("jules_activity_get returns a list", {
  mock_resp <- list(name = "sessions/1/activities/1")

  testthat::with_mocked_bindings({
    suppressMessages(suppressWarnings(res <- jules_activity_get("sessions/1/activities/1")))
    expect_type(res, "list")
    expect_equal(res$name, "sessions/1/activities/1")
  }, jules_perform = function(...) mock_resp)
})
