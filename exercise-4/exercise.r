# Install and load the jsonlite package
install.packages("jsonlite")
library(jsonlite)
# Make a variable base.url that has the same base url from the omdb documentation.
# (Hint: visit https://www.omdbapi.com/ to find the base url)
base.url <- 'https://www.omdbapi.com/?'
# Make a variable called movie that has the names of your favorite movie
movie <- "Fast 8"
# Make a variable called move.no.spaces that holds movie where all the spaces
# are replaced with the '+' character
movie.plus <- gsub(" ", "+", movie)
# Make a variable called "parameters" that holds a string with the parameters
# to pass to the API. View the OMDb documentation to see which parameters
# are available. Remember to separate parameters with the '&' character.
parameters <- paste0("t=", movie.plus, "&r=json")
# Make a variable called request that is a string of a request URL made up of the base URL
# and the parameters string
comb <- paste0(base.url, parameters)
# Use fromJSON to retrieve JSON data from the omdb api using your request URL.
# Store the result in a variable called movie.data
movie.data <- fromJSON(comb)
# Make movie_data into a data frame using as.data.frame
movie_data <- as.data.frame(movie.data)
# Write a function called Director that accepts a data frame of movie info and returns
# A vector of strings that states a movie and the director of said movie.
Director <- function(name){
  return(paste(name$Title, "was directed by the great", name$Director))
}
# Call Director with your favorite movie, and assign it to the variable movie.director
movie.director <- Director(movie_data)
# Bonus 

# Knowing the director of on movie is okay, but it'd be great to know the directors of different
# movies. 

# Start by making a vector of movies and save it to the variable movie.list
movie.list <- c("Fast 8", "The Transporter")
# Remove spaces from each movie title
movies.plus <- gsub(" ","+", movie.list)
# Prepare this list to be passed in as parameters for the API
parameter <- paste0("t=", movies.plus, "&r=json")
# Create API URL request and assign it to the variable api.request
api.request <- paste0(base.url, parameter)

# For every entry in the vector api.request, APPLY the function fromJSON to make a list of lists
# one entry for each request and assign this to a variable called data. 
# (Hint: ?lapply. It's similar a 'for' loop but better!)
data <- lapply(api.request, fromJSON)
# Using the function do.call, call rbind on each entry in data (check out the do.call documentation)
data.do <- do.call(rbind, data)
# Make sure movies is treated as a data frame by calling as.data.frame and assign that to movies.df
movie.df <- as.data.frame(data.do)
# Use your Director function to see who directed all these movies. Assign the result to movie.info
movie.info <- Director(movie.df)
# Create a variable called meta.scores which is a vector containing the Metascore column from movie.df
meta.scores <- movie.df$Metascore 
# Create a variable called movie_titles which is a vector containing the Title column from movie.df
movie.titles <- movie.df$Title
# Once you finish the rest of the lab you can uncomment this next line for some sweet data viz
barplot(as.numeric(meta.scores), names.arg=as.vector(movie.titles), las=2)
