#' Get new artist recommendations
#'
#' @param URI An artist's URI
#' @param access_token Your API token and secret melded using our api_token function
#' @param test Allows user to use example data in order to see the intended output. Defaulted to test = FALSE
#'
#' @return Data frame that contains 20 artists for every genre that the inputted artist is categorized as from Spotify
#' @export
#'
#' @examples
#' # Here is an example dataframe for when you input the URI of Beyonce.
#' # When you want to run your own artists, you will remove 'test = TRUE'.
#' # This is because the test parameter uses the saved data.
#' # Then replace the URI with an artist of your choice
#' # and use your access token as a parameter.
#'
#' result <- genre_recommendations(c('6vWDO969PvNqNYHIOW5v0m'), test = TRUE)

genre_recommendations = function(URI, access_token, test = FALSE){

  if(test){return(genre_rec_saved)} else {

    # creates list of the given artist's attributes
    artist_info <- tryCatch({
      spotifyr::get_artist(URI, access_token)},
      error = function(e){
        message("Your username, URI, and / or access_token input was invalid. Please try again. Try reloading your access token.")},
      warning = function(w){
        message("Your username, URI, and / or access_token input was invalid. Please try again. Try reloading your access token.")}

    )

  }

  # keeps only the genre(s) of the artist's attributes
  artist_genre <- artist_info[["genres"]]

  # makes a vector containing the numbers 1 through the number of genres of an artist
  num_position = (1:length(artist_genre))

  # creates empty list for apply()
  genre_rec = list()

  # creates empty data frame for apply()
  recommend = data.frame()

  # since sometimes get_artist() adds spaces in the genre, replace all accurances of a space in the genre vector with an underscore
  artist_genre <- gsub(pattern = " ", artist_genre, replacement = "_")


  # for every genre in the vector, return the top 20 artists of that genre
  recommendation_full <- sapply(artist_genre, FUN = function(num_position){

    # get the top 20 artists of a genre from the genre vector
    genre_rec[[num_position]] <- spotifyr::get_genre_artists(num_position)

    # put the artist names into a vector and add it to the object "full_genre"
    full_genre <- as.vector(genre_rec[[num_position]][["name"]])

  })

  # turn result of the future_sapply() into a readable data frame, where the column names are the genres and rows are the artists
  recommend <- as.data.frame(recommendation_full)

  # return the data frame
  return(recommend)
}
