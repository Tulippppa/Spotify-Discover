testthat::test_that("shuffle function works", {
  songs_info <- shuffled_playlist(test=TRUE)
  testthat::expect_s3_class(songs_info, "data.frame")
})
