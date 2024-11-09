#' Shuffling the order of a playlist
#'
#' @param username The user's spotify username
#' @param URI The playlist URI
#' @param access_token The API code the user made using our api_token function
#' @param ... The type of song information the user wants; the defaults are track.name, track.album.name, track.preview_url
#' @param test Allows user to see an example output of saved data
#'
#' @return a dataframe that outputs the shuffled playlist
#' @export
#'
#' @examples
#' # Here is an example of an output dataframe when you input the Spotify USA top 50 playlist
#' # When using your own playlist, remember to replace test=TRUE
#' # This argument is used for a saved data
#' # Then replace the username, URI and use your access token as a parameter
#' testing <- shuffled_playlist('spotify', c('37i9dQZEVXbLRQDuF5jeBp'),test= TRUE)
#'

shuffled_playlist <- function(username, URI, access_token, ..., test = FALSE) {
  if(test){return(shuffled_saved)} else{

  # create playlist object
  playlist <- tryCatch({
    spotifyr::get_playlist_audio_features(username, URI, access_token)},
    error = function(x) {
      message("The username, URI, or access code input does not exist, please try again")},
    warning = function(x) {
      message("The username, URI, or access code input does not exist, please try again")}
 #   return(data.frame("Song Name" = NA, "Album Name" = NA, "Preview Link"))
  )
  }

# selecting columns we want (the defaults)
  song_descriptions <- playlist |>
     dplyr::select(track.name, track.album.name, track.preview_url, ...)

 # counting number of rows
    num_rows <- sample(nrow(song_descriptions))

 # re-orders the rows
    shuffled_songs<-  song_descriptions[num_rows, ]
    return(shuffled_songs)

}




