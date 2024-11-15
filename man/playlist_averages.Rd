% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/playlist_averages_function.R
\name{playlist_averages}
\alias{playlist_averages}
\title{Average music metrics of a given playlist}
\usage{
playlist_averages(username, URI, access_token, ..., test = FALSE)
}
\arguments{
\item{username}{The Spotify username}

\item{URI}{The playlist URI}

\item{access_token}{Your API token and secret melded using our api_token function}

\item{...}{Music metric you wish to average: danceability, energy, speechiness, acousticness, instrumentalness, liveness, valence, tempo, and loudness are default. key, mode, time_signature, track.duration_ms, track.popularity can be added}

\item{test}{Allows user to use example data in order to see the intended output. Defaulted to test = FALSE}
}
\value{
Data frame that contains the averages and / or modes of the music metrics desired
}
\description{
Average music metrics of a given playlist
}
\examples{
# Here is an example dataframe for when you input the URI of Spotify US Top 50 playlist..
# When you want to run your own artists, you will remove 'test = TRUE'
# since this argument uses saved data.

# Then replace the URI with a playlist and its owner of your choice and use your
# access token as a parameter.

result <- playlist_averages('spotify', c('37i9dQZEVXbLRQDuF5jeBp'), test = TRUE)
}
