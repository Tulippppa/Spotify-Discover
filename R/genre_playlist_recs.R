
#' This function will allow users to input a playlist to get artist recommendations based on the genres of the artist in their playlist
#' @param playlist The playlist URI the user wants to input
#' @param access_token The API key the user generates from their secret ID and Password so they can access the Spotify API
#' @param test If set to TRUE, will return test data of Spotify Top 50 with all default parameters. If FALSE, users can input their own playlist URI
#'
#' @return A dataframe with the columns being the genres of the artists in the playlist you, and each row being a recommended artist from the genre column
#' @export
#'
#'
#'
#' @examples genre_playlist_recommendations('37i9dQZEVXbLRQDuF5jeBp', test=TRUE)
#' # An example using a playlist to get artist recommendations
#' # based on the genre of the artists in the playlist
#'
#' # When you want to run your own artists, you will replace 'test = TRUE'
#' # with your access token.
#'
#' # If you would like to return test data, please set test = TRUE


genre_playlist_recommendations = function(playlist, access_token, test = FALSE){
  # browser()
  if (test) {
    return(genre_playlist_rec_save)
  }
  else {
    track_playlist <-tryCatch({
        # create a playlist dataframe
        # have to use get_playlist_tracks() since it was the only one with artists
        spotifyr::get_playlist_tracks(c(playlist), access_token)
      },

      error = function(e){
        message("error. please look at the parameters and try again. visit link for more info https://developer.spotify.com/documentation/web-api/concepts/apps")
      },

      warning = function(w){
        message("warning. please look at the parameters and try again. visit link for more info https://developer.spotify.com/documentation/web-api/concepts/apps")
      }
    )
  }
      # indexing through track.album.artists dataframe in track_playlist dataframe to get artist id
      # used track.album.name since that only had one artist and though the main artist was the most important to get a prefered genres
      artist_ids = lapply(track_playlist$track.album.artists, FUN = function(track_artist_list){
        artist_ids = track_artist_list$id
        return(artist_ids)
      })

      # with every id, make an artist dataframe to get the artist's genre(s)
      # nested lapply() for if there is more than one artists in the trackalbum listed
      artists_genre = lapply(artist_ids, function(artists){
        lapply(artists, function(individual_artist){
          artist_info = spotifyr::get_artist(individual_artist, access_token)
          genre = artist_info[["genres"]]
          return(genre)
        })
      })

      # steps to get the unique genres
      # first you have to unnest/unlist the lit of artist genres
      # since if you don't it won't give the individual unique elements and will look for a group of unique genres which leads to repetition in genres
      genre_list = unlist(artists_genre)

      # getting the unique genres
      unique_genre_list = unique(genre_list)

      # makes a vector containing the numbers 1 through the number of genres of an artist
      num_position <- (1:length(unique_genre_list))

      # creates empty list for apply()
      genre_rec <- list()

      # creates empty data frame for apply()
      recommend <- data.frame()

      # since sometimes get_artist() adds spaces in the genre, replace all accurances of a space in the genre vector with an underscore
      unique_genre_list <- gsub(pattern = " ", unique_genre_list, replacement = "_")


      # for every genre in the vector, return the top 20 artists of that genre
      recommendation_full <-  sapply(unique_genre_list, FUN = function(num_position){
        # get the top 20 artists of a genre from the genre vector
        genre_rec[[num_position]] <- spotifyr::get_genre_artists(num_position)
        # put the artist names into a vector and add it to the object "full_genre"
        full_genre <-  as.vector(genre_rec[[num_position]][["name"]])
      })

      # turn result of the sapply() which is stored in recommendation_full into a readable data frame, where the column names are the genres and rows are the reccommended artists
      recommend <- as.data.frame(recommendation_full)

      # return the data frame
      return(recommend)
    }



