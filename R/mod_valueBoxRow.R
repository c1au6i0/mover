# valueBoxRow

#' @title   valueBoxRow 
#' @description  creates a row of valueBox with a single value
#'
#' @param outputId list of outputId
#'
#' @rdname valueBoxRow
#'
#' @keywords internal
#' @importFrom shinydashboard valueBoxOutput
#' @export 
valueBoxRow <- function(outputId){
  valueBoxes <- purrr::map(outputId, valueBoxOutput)
  ui <- fluidRow(!!!valueBoxes)
}


# Module UI
  
#' @title   mod_valueBoxRow_ui and mod_valueBoxRow_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#' @param outputL list of quoted outputIds
#' @rdname mod_my_first_module
#'
#' @keywords internal
#' @export 
#' @import shiny shinydashboard
mod_valueBoxRow_ui <- function(id, outputL){
  ns <- NS(id)
  tagList(
    valueBoxRow(ns(outputL))
  )
}

# list("rate", "count", "users")
    
# Module Server
    
#' @rdname mod_my_first_module
#' @export
#' @keywords internal
    
mod_valueBoxRow_server <- function(input, output, session){
  ns <- session$ns
  
  output$rate <- renderValueBox({

    valueBox(
      value = 100,
      subtitle = "Downloads per sec (last 5 min)",
      icon = icon("area-chart")
    )
  })
  
  output$count <- renderValueBox({
    valueBox(
      value = 123,
      subtitle = "Total downloads",
      icon = icon("download")
    )
  })
  
  output$users <- renderValueBox({
    valueBox(
      190,
      "Unique users",
      icon = icon("users")
    )
  })
  
}
    
## To be copied in the UI
# mod_my_first_module_ui("my_first_module_ui_1")
    
## To be copied in the server
# callModule(mod_my_first_module_server, "my_first_module_ui_1")
 
