#' This function takes a playlist and sorts it by an element that the user wants
#' @param playlist The playlist URI the user wants artist recommendations from
#' @param access_token The API key the user generates from their secret ID and Password so they can access the Spotify API
#' @param sort_by The column the user would like to sort_by/organize their playlist by
#' @param order Can organize playlist in ascending or descending order
#' @param test If set to TRUE, will return test data of Spotify Top 50 with all default parameters. If FALSE, users can input their own playlist URI
#'
#' @return Returns a dataframe that will always have "track.name" and "simple_artist" (name of the artist(s) on the song), and will have an additional column if what they want to sort_by is not "track.name" or "track.artist". Sorting by "track.name" is the default
#' @export
#'
#' @examples ranking_function('37i9dQZEVXbLRQDuF5jeBp', test=TRUE)
#' # An example using a playlist with default parameters of sorting
#' # by track name in ascending order
#'
#' # When you want to run your own artists, you will replace test = TRUE'
#' # with your access token.
#'
#'
#' @examples ranking_function('37i9dQZEVXbLRQDuF5jeBp', test=TRUE, sort_by="track.popularity")
#' # An example using a playlist to sort by track popularity in ascending order
#'
#' # If you would like to return test data, please set test = TRUE

ranking_function <- function(playlist, access_token, sort_by="track.name", order="ascending", test = FALSE) {
  # browser()
  if (test) {
    return(ranking_save)
  }
  else{
    track_playlist <- tryCatch(
      expr = {
        # creating dataframe
        spotifyr::get_playlist_tracks(c(playlist), access_token)
      },

      error = function(e){ # from my understanding change the parameter depending on what the error is
        message("error. please look at the parameters and try again. visit link for more info https://developer.spotify.com/documentation/web-api/concepts/apps")
      },

      warning = function(w){
        message("warning. please look at the parameters and try again. visit link for more info https://developer.spotify.com/documentation/web-api/concepts/apps")
      }
    )
  }

  # items from get_playlist_tracks() that are dataframes within dataframes
  cannot_sort = list("track.album.artists", "track.album.images", "video_thumbnail.url")

  # if they choose to sort_by something that they cannot sort_by, it will get set back to the default
  if (sort_by %in% cannot_sort) {
    message("we cannot rank by these columns currently. please try again with a new argument. for now we organized by 'track.name' for you. ")
    sort_by = "track.name"
  }

  # lapply() that goes through track artist and then gets the name
  out = lapply(track_playlist$track.artists, FUN = function(track_artist_list){
    out = track_artist_list$name
    return(out)
  })

  # adding artists to a new column and adding a ; to separate any artist names
  track_playlist$simple_artist = sapply(out, paste0, collapse = "; ")

  if (order == "ascending") {
    # ordering playlist dataframe (ascending)
    track_playlist = track_playlist[order(track_playlist[, sort_by]), ]
  }
  else if (order == "descending") {
    # ordering playlist dataframe (descending)
    track_playlist = track_playlist |> dplyr::arrange(dplyr::desc(track_playlist[, sort_by]), )
  }


  # selecting elements for output
  # if they are using "track.name" or "track.artist" have to only take those elements and the have a separate section
  # for anything else to avoid selecting double
  if (sort_by == "track.name" | sort_by == "track.artists"){
    ranked_playlist = dplyr::select(track_playlist, c(track.name, simple_artist))
    # can select columns dplyr::select
  }
  else {
    ranked_playlist = dplyr::select(track_playlist, c(track.name, simple_artist, all_of(sort_by)))
  }

  # re-index output
  row.names(ranked_playlist) = 1:nrow(ranked_playlist)

  return(ranked_playlist)
}
