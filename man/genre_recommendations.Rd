% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/genre_function.R
\name{genre_recommendations}
\alias{genre_recommendations}
\title{Get new artist recommendations}
\usage{
genre_recommendations(URI, access_token, test = FALSE)
}
\arguments{
\item{URI}{An artist's URI}

\item{access_token}{Your API token and secret melded using our api_token function}

\item{test}{Allows user to use example data in order to see the intended output. Defaulted to test = FALSE}
}
\value{
Data frame that contains 20 artists for every genre that the inputted artist is categorized as from Spotify
}
\description{
Get new artist recommendations
}
\examples{
# Here is an example dataframe for when you input the URI of Beyonce.
# When you want to run your own artists, you will remove 'test = TRUE'.
# This is because the test parameter uses the saved data.
# Then replace the URI with an artist of your choice
# and use your access token as a parameter.

result <- genre_recommendations(c('6vWDO969PvNqNYHIOW5v0m'), test = TRUE)
}
