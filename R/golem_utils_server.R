# Inverted versions of in, is.null and is.na
#
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



import_movie <- function(x){

  # https://www.imdb.com/title/tt8579674/?ref_=shtt_ov_tt
  # extract ID
  movie_id <- unlist(strsplit(x, "/"))[[4]]
  
  movie_page <- 
    paste0("https://www.imdb.com/title/",    movie_id, collapse = "") %>% 
    xml2::read_html()
  
  # extract json dictionary
  dict  <- movie_page %>% 
    rvest::html_nodes(xpath = './/script[contains(@type,"application/ld+json")]') %>%
    rvest::html_text() %>% 
    jsonlite::fromJSON()

  dict$review
  
  title_year  <- movie_page %>% 
    rvest::html_nodes(xpath = './/h1') %>%
    rvest::html_text() 
  
  
  # meta <- 
  metascore <- movie_page %>% 
    rvest::html_nodes(xpath = './/div[contains(@class,"metacriticScore")]/span') %>%
    rvest::html_text()  %>% 
    as.numeric()
  
  popularity <- movie_page %>% 
    rvest::html_nodes(xpath = './/span[contains(@class,"subText")]') %>%
    rvest::html_text() 
  
  popularity <- stringr::str_extract(popularity[[3]], "[0-9]")
  

  
  
  prova$actor
  
}


import_IMDB <- function(){
  browser()
  in_th <- xml2::read_html("https://www.imdb.com/showtimes/location/US/21210?ref_=inth_sh") 
  
  # get movie link
  movies_links <-  in_th  %>%
    rvest::html_nodes(xpath = '//*[contains(@class,"title")]/a') %>%
    rvest::html_attr("href") 
  
  



  
}