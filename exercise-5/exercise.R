### Exercise 5 ###
library(jsonlite)
library(dplyr)

# Write a function that allows you to specify a movie, then does the following:
specifymovie <- function(movie.name){
  # Replace all of the spaces in your movie title with plus signs (+)
  movie.plus <- gsub(" ", "+", movie.name)
  # Construct a search query using YOUR api key
  # The base URL is https://api.nytimes.com/svc/movies/v2/reviews/search.json?
  # See the interactive console for more detail:https://developer.nytimes.com/movie_reviews_v2.json#/Console/GET/reviews/search.json
  # Request data using your search query
  base.url <- "https://api.nytimes.com/svc/movies/v2/reviews/search.json?"
  api.key <- "&api-key=9357ba6417bb4d5abf55b12bc5046ea5"
  request.data <- paste0(base.url, "query=", movie.plus, api.key)
  request <- fromJSON(request.data)
  # What type of variable does this return?
  
  # Flatten the data stored in the `$results` key of the data returned to you
  flattened <- flatten(request$results)
  
  # From the most recent review, store the headline, short summary, and link to full article each in their own variables
  first.rev <- flattened[1,]
  headline <- first.rev$headline
  summary <- first.rev$summary_short
  link <- first.rev$link.url
  # Return an list of the three pieces of information from above
  result <- list(headline=headline, summary=summary, link=link)
return(result)
}
# Test that your function works with a movie of your choice
movies <- specifymovie("The Transporter")

