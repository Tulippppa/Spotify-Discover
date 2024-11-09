
testthat::test_that("maximum metric summary works", {
  max_values <- max_metrics_summary(test = TRUE)
  testthat::expect_s3_class(max_values, "data.frame")
})
