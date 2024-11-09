#' Finding the minimum for a specific music metric
#'
#' @param username Character. User input of user's spotify username
#' @param URI Playlist identification code. Requires use of function(access_token)
#' @param access_token Access token code. Requires use of function(access_token)
#' @param max_or_min Identification of desired min or max results (function(max_metric_summary) preferable for max outputs)
#' @param ... Optional. Additional metrics from spotifyr::package function(get_audio_playlist_features)
#' @param test Allows user to use example data in order to see the intended output. Defaulted to test = FALSE description
#'
#' @return A dataframe showing min value of music metric and the associated song from user playlist
#' @export
#'
#' @examples
#' # Here is an example dataframe for when you input the URI of Beyonce.
#' result <- min_metrics_summary(c('6vWDO969PvNqNYHIOW5v0m'), test = TRUE)
#' # When you want to run your own playlist, you will remove 'test = TRUE'
#' # since this argument uses saved data.
#'
#' # Then replace the URI with the playlist of your choice and use your
#' # access token as a parameter.


# this function goes through a user's playlist to produce a dataframe with the songs that have the highest values within each music metric
min_metrics_summary <- function(username, URI, access_token, max_or_min, ..., test = FALSE){

  # create playlist object from user's spotify username, URI, and access token
  # includes a tryCatch that results in an error if input values are not valid
  if(test){return(min_metrics_data)} else {
    playlist <- tryCatch({spotifyr::get_playlist_audio_features(username, URI, access_token)},
                         error = function(x){
                           warning("The username, URI, or access code input does not exist, please try again")
                           return(data.frame)
                         })}

  # creating new dataframe object for playlist
  # using dyplr and tidyr packages to clean dataframe
  min_values <- playlist %>%

    # selecting track name and chosen music metrics
    dplyr::select(danceability,
                  energy,
                  loudness,
                  speechiness,
                  acousticness,
                  instrumentalness,
                  liveness,
                  valence,
                  tempo,
                  track.name,
                  ...) %>%
    # organizing layout of dataframe
    tidyr::pivot_longer(cols = -track.name,
                        names_to = "metric",
                        values_to = "value") %>%

    # grouping by music metric
    group_by(metric) %>%

    # finding minimum value and selecting one min value
    summarize(title = track.name[value == min(value)][1],
              metric = metric[1],
              value = min(value)) %>%

    # select summarized items to include in final dataframe output
    select(title, metric, value)

  # returning dataframe with the min music value per metric with associated song title
  return(min_values)
}
