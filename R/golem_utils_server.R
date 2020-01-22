#' import_movie
#'
#' import_movie scrapes info of a movie on its IMDB page.
#'
#' @param dat webpage of movie on IMDB.
#' @return a list of dataframes:
#' @importFrom rlang .data
#' @importFrom magrittr %>%
#' @import stats
#' @export
import_movie <- function(dat){

  x <-  "https://www.imdb.com/title/tt0081573/?ref_=fn_al_tt_1"
  # extract ID
  movie_id <- unlist(strsplit(x, "/"))[[5]]

  movie_page <-
    paste0("https://www.imdb.com/title/",    movie_id, collapse = "") %>%
    xml2::read_html()

  # extract json dictionary
  dict  <- movie_page %>%
    rvest::html_nodes(xpath = './/script[contains(@type,"application/ld+json")]') %>%
    rvest::html_text() %>%
    jsonlite::fromJSON()

  metascore <- movie_page %>%
    rvest::html_nodes(xpath = './/div[contains(@class,"metacriticScore")]/span') %>%
    rvest::html_text()  %>%
    as.numeric()

  popularity <- movie_page %>%
    rvest::html_nodes(xpath = './/span[contains(@class,"subText")]') %>%
    rvest::html_text()
  popularity <- stringr::str_extract(popularity[[3]], "[0-9]")

  # key will be url tt8579674: movie_id



  tosub <- c("@context", "@type", "url", "name", "image", "genre", "contentRating",  "description", "datePublished", "keywords",
             "duration")

  movie_info <-  as.data.frame(list(dict[tosub],
                                    metascore = metascore,
                                    popularity = popularity))

  all_info <- list(
       genre = dict$genre,
       actor = dict$actor,
       director = dict$director,
       creator = dict$creator,
       aggregateRating = dict$aggregateRating,
       review = dict$review,
       trailer = dict$trailer,
       other_info = movie_info)


  all_info <- lapply(all_info, as.data.frame)

  all_info <- lapply(all_info, function(x){
                  x[, "movie_id"] <- movie_id
                  x
  })

}


#' import_IMDB
#'
#' import_IMDB scrapes info of all the movies in theater that week.
#'
#' @param zip zip code (5 numbers).
#' @return a list of dataframes.
#' @export
import_IMDB <- function(zip = 21210){

  # construct the page
  imdb_page <- paste0("https://www.imdb.com/showtimes/location/US/", zip, "?ref_=inth_sh", collapse = "")

  in_th <- xml2::read_html(imdb_page)

  # get the links of all the movies
  movies_links <-  in_th  %>%
    rvest::html_nodes(xpath = '//*[contains(@class,"title")]/a') %>%
    rvest::html_attr("href")

  movies <- lapply(movies_links, import_movie) # this take too much (26 sec) but becouse of rvast

  # bind row of each of dataframe
  # bind row of each of dataframe
  # bind row of each of dataframe
  arg <- paste0("movies[[", 1:length(movies), "]]", collapse = ",")

  form <- paste0("mapply(dplyr::bind_rows,", arg, ")", collapse = "")

  movies_b <- eval(parse(text = form))

  movies_b

}

# Inverted versions of in, is.null and is.na
`%not_in%` <- Negate(`%in%`)

not_null <- Negate(is.null)

not_na <- Negate(is.na)

# Removes the null from a vector
drop_nulls <- function(x){
  x[!sapply(x, is.null)]
}

# If x is null, return y, otherwise return x
"%||%" <- function(x, y){
  if (is.null(x)) {
    y
  } else {
    x
  }
}
# If x is NA, return y, otherwise return x
"%|NA|%" <- function(x, y){
  if (is.na(x)) {
    y
  } else {
    x
  }
}

# Inverted versions of in, is.null and is.na
`%not_in%` <- Negate(`%in%`)

not_null <- Negate(is.null)

not_na <- Negate(is.na)

# Removes the null from a vector
drop_nulls <- function(x){
  x[!sapply(x, is.null)]
}

# If x is null, return y, otherwise return x
"%||%" <- function(x, y){
  if (is.null(x)) {
    y
  } else {
    x
  }
}
# If x is NA, return y, otherwise return x
"%|NA|%" <- function(x, y){
  if (is.na(x)) {
    y
  } else {
    x
  }
}

# typing reactiveValues is too long
rv <- shiny::reactiveValues
rvtl <- shiny::reactiveValuesToList