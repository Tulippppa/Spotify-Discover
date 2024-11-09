api_call = c(c('6vWDO969PvNqNYHIOW5v0m'), api_key())

# get data that requires credential, like your access tokens
api_call_genre_data = genre_recommendations(api_call)


usethis::use_data(api_call_genre_data, overwrite = TRUE)

# function creation #### -------------------------------------------------------

# THIS IS YOUR SCRIPT FILE IN ./R/

clean_api_return = function(api, use_cache = FALSE){

  # get the data
  ## if cache == TRUE, use the version from the package (your example data)
  if(use_cache){
    # I can call `api_call_data` as an object even though I have not made it
    # because it is now a data object in my package that gets loaded with my package.
    api_data = api_call_data
  } else {

    ## if cache == FALSE, run the API call like normal
    api_data = googlesheets4::read_sheet(api)

  }

  # now that the data is sorted, do whatever this function is meant to do

  ## get rid of "NA" strings and turn into real NAs
  api_data[api_data == "NA"] = NA

  # return
  return(api_data)
}

# Try it out #### --------------------------------------------------------------


# try it out with cache FALSE, so it runs the API call
clean_api_return(api = api_call, use_cache = FALSE)

# try it out with cache TRUE, so load data I saved earlier from the package
clean_api_return(api = api_call, use_cache = TRUE)
