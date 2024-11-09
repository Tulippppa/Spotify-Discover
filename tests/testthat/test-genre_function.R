testthat::test_that("artist genre works?", {
  recommend <- genre_recommendations(test=TRUE)
  testthat::expect_s3_class(recommend, "data.frame")
})
