testthat::test_that("genre_playlist_recommendations function works", {
  ranked = genre_playlist_recommendations(test=TRUE)
  testthat::expect_s3_class(ranked, "data.frame")
})
