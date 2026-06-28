test_that("list_activities returns a tibble", {
  mock_resp <- list(activities = list(list(name = "sessions/1/activities/1")))

  with_mocked_bindings({
    res <- list_activities("sessions/1")
    expect_s3_class(res, "tbl_df")
    expect_equal(res$name, "sessions/1/activities/1")
  }, jules_perform_all = function(...) mock_resp$activities)
})
