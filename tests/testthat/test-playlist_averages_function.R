testthat::test_that("logistic averages works", {
  averages_df <- playlist_averages(test = TRUE)
  testthat::expect_s3_class(averages_df, "data.frame")
})
