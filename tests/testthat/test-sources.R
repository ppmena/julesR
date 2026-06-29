test_that("jules_sources returns a tibble", {
  mock_sources <- list(list(name = "sources/1", description = "desc1"))

  testthat::with_mocked_bindings({
    suppressMessages(suppressWarnings(res <- jules_sources()))
    expect_s3_class(res, "tbl_df")
    expect_equal(nrow(res), 1)
    expect_equal(res$name, "sources/1")
  }, jules_perform_all = function(...) mock_sources)
})

test_that("jules_source_get returns a list", {
  mock_resp <- list(name = "sources/1")

  testthat::with_mocked_bindings({
    suppressMessages(suppressWarnings(res <- jules_source_get("sources/1")))
    expect_type(res, "list")
    expect_equal(res$name, "sources/1")
  }, jules_perform = function(...) mock_resp)
})
