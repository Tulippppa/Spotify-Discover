#' Average music metrics of a given playlist
#'
#' @param username The Spotify username
#' @param URI The playlist URI
#' @param access_token Your API token and secret melded using our api_token function
#' @param ... Music metric you wish to average: danceability, energy, speechiness, acousticness, instrumentalness, liveness, valence, tempo, and loudness are default. key, mode, time_signature, track.duration_ms, track.popularity can be added
#' @param test Allows user to use example data in order to see the intended output. Defaulted to test = FALSE
#'
#' @return Data frame that contains the averages and / or modes of the music metrics desired
#' @export
#'
#' @examples
#' # Here is an example dataframe for when you input the URI of Spotify US Top 50 playlist..
#' # When you want to run your own artists, you will remove 'test = TRUE'
#' # since this argument uses saved data.
#'
#' # Then replace the URI with a playlist and its owner of your choice and use your
#' # access token as a parameter.
#'
#' result <- playlist_averages('spotify', c('37i9dQZEVXbLRQDuF5jeBp'), test = TRUE)

playlist_averages <- function(username, URI, access_token, ..., test = FALSE){


  if(test){return(playlist_avg_saved)} else {

    # create playlist object
    playlist <- tryCatch({
      spotifyr::get_playlist_audio_features(username, URI, access_token)
      },
      error = function(e){
        message("Your username, URI, and / or access_token input was invalid. Please try again. Try reloading your access token.")
        },
      warning = function(w){
        message("Your username, URI, and / or access_token input was invalid. Please try again. Try reloading your access token.")
        }
    )
  }

  # chooses the specific columns needed to find the averages
  # if a user wishes to rename one of the columns, they can using the format "new_name" = old_name
  # if a user wishes to find the average of another value, they can by inputting a column name from get_playlist_audio features()
  specific_values <- playlist |>
    dplyr::select(danceability, energy, speechiness, acousticness,
                  instrumentalness, liveness, valence, tempo, loudness, ...)


  # transforms the columns into a list for the sapply()
  values_list = as.list(specific_values)

  # columns that require finding the most common value, or mode, rather than the mean
  mode_values <- playlist |>
    dplyr::select(mode, key, time_signature)

  mode_list <- as.list(mode_values)

  # apply average and/or mode to columns
  value <- sapply(values_list, FUN = function(i){

    # if column belongs to mode, key, or time signature, give the mode. else, find the average value
    if(any(i == mode_list[[1]]) | any(i == mode_list[[2]]) | any(i == mode_list[[3]])){
      # code to find mode from https://www.tutorialspoint.com/r/r_mean_median_mode.htm
      uniqv <- unique(i)
      mode_val = uniqv[which.max(tabulate(match(i, uniqv)))]
    } else {
      mean_val = mean(i)
    }

  })


  # transform all the averages / modes into a dataframe
  averages_df <- as.data.frame(value)

  full_df <- tibble::rownames_to_column(averages_df, var = "logistics")

  # return final data frame
  return(full_df)
}
