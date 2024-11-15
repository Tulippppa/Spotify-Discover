% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/API_token_function.R
\name{api_token}
\alias{api_token}
\title{Creating a personalized API token}
\usage{
api_token(id, secret)
}
\arguments{
\item{id}{User's Spotify Client ID. Requires interaction with Spotify's API website}

\item{secret}{User's Spotify Secret Code. Requires interaction with Spotify's API website}
}
\value{
Object. Produces api_token as object access_token. Required for package use.
}
\description{
Creating a personalized API token
}
\examples{
access_token <- api_token('YOUR API ID', 'YOUR API SECRET')
}
