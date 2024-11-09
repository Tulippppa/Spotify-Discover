testthat::test_that("ranking function works", {
  ranked = ranking_function(test=TRUE)
  testthat::expect_s3_class(ranked, "data.frame")
})
