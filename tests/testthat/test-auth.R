test_that("jules_auth stores API key in options", {
  withr::local_options(list(julesr.api_key = NULL))

  jules_auth("test-key")
  expect_equal(getOption("julesr.api_key"), "test-key")
})

test_that("jules_auth reads from environment variable if NULL", {
  withr::local_options(list(julesr.api_key = NULL))
  withr::local_envvar(list(JULES_API_KEY = "env-key"))

  jules_auth(NULL)
  expect_equal(getOption("julesr.api_key"), "env-key")
})

test_that("jules_auth aborts if no key provided or found", {
  withr::local_options(list(julesr.api_key = NULL))
  withr::local_envvar(list(JULES_API_KEY = ""))

  expect_error(jules_auth(NULL), class = "rlang_error")
})

test_that("jules_api_key retrieves key from options", {
  withr::local_options(list(julesr.api_key = "opt-key"))
  expect_equal(jules_api_key(), "opt-key")
})

test_that("jules_api_key retrieves key from env if options NULL", {
  withr::local_options(list(julesr.api_key = NULL))
  withr::local_envvar(list(JULES_API_KEY = "env-key"))
  expect_equal(jules_api_key(), "env-key")
})
