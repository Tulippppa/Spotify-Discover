#' Creating a personalized API token
#'
#' @param id User's Spotify Client ID. Requires interaction with Spotify's API website
#' @param secret User's Spotify Secret Code. Requires interaction with Spotify's API website
#'
#' @return Object. Produces api_token as object access_token. Required for package use.
#' @export
#'
#' @examples
#' access_token <- api_token('YOUR API ID', 'YOUR API SECRET')


# Creating API call function that returns access token object

api_token <- function(id, secret){
  tryCatch(
    expr = {
      # creating objects for ID and secret client code
      Sys.setenv(SPOTIFY_CLIENT_ID = id)
      Sys.setenv(SPOTIFY_CLIENT_SECRET = secret)

      # creating access token object from spotify r package
      access_token <- spotifyr::get_spotify_access_token()

      # return access token as object
      message("access token has been created")
      return(access_token)

      # warning("you have not entered a string")
      # warning("if you dont have API go to this website")
    },

    error = function(e){ # from my understanding change the parameter depending on what the error is
      message("error. please look at the parameters and try again")
    },

    warning = function(w){
      message("warning. please look at the parameters and try again")
    },

    finally = {
      message("access token expires in one hour - to renew please rerun this function")
    }

  )}


