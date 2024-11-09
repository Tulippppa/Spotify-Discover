
testthat::test_that("minimum metric summary works", {
  min_values <- min_metrics_summary(test = TRUE)
  testthat::expect_s3_class(min_values, "data.frame")
})
