test_that("as_resource_name works correctly", {
  expect_equal(as_session_name("abc"), "sessions/abc")
  expect_equal(as_session_name("sessions/abc"), "sessions/abc")

  expect_equal(as_source_name("src1"), "sources/src1")
  expect_equal(as_source_name("sources/src1"), "sources/src1")

  expect_equal(as_activity_name("act1"), "activities/act1")
  expect_equal(as_activity_name("activities/act1"), "activities/act1")
})

test_that("check_string validates strings correctly", {
  expect_silent(check_string("hello"))
  expect_error(check_string(""), class = "rlang_error")
  expect_error(check_string(NULL), class = "rlang_error")
  expect_error(check_string(NA_character_), class = "rlang_error")
  expect_error(check_string(123), class = "rlang_error")
  expect_error(check_string(c("a", "b")), class = "rlang_error")
})

test_that("check_not_null validates correctly", {
  expect_silent(check_not_null(1))
  expect_error(check_not_null(NULL), class = "rlang_error")
})
