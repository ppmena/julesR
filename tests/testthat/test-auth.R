test_that("jules_auth sets the api key", {
  withr::with_options(list(julesr.api_key = NULL), {
    jules_auth("test-key")
    expect_equal(getOption("julesr.api_key"), "test-key")
  })
})

test_that("get_api_key retrieves the key", {
  withr::with_options(list(julesr.api_key = "test-key"), {
    expect_equal(get_api_key(), "test-key")
  })
})

test_that("get_api_key aborts if no key", {
  withr::with_envvar(list(JULES_API_KEY = ""), {
    withr::with_options(list(julesr.api_key = NULL), {
      expect_error(get_api_key(), "Jules API key not found")
    })
  })
})
