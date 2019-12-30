# valueBoxRow

#' @title   valueBoxRow
#' @description  creates a row of valueBoxes
#'
#' @param outputId list of outputId
#'
#' @rdname valueBoxRow
#'
#' @keywords internal
#' @importFrom shinydashboard valueBoxOutput
#' @export
valueBoxRow <- function(outputId) {
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
#' @param outputL list of quoted outputIds (do not include `output`)
#' @rdname mod_valueBoxRow
#'
#' @keywords internal
#' @export
#' @import shiny shinydashboard
mod_valueBoxRow_ui <- function(id, outputL) {
  ns <- NS(id)
  tagList(
    valueBoxRow(ns(outputL))
  )
}



# Module Server

#' @rdname mod_valueBoxRow
#' @param valueL list of valueBox  values
#' @param colorL list of valueBox colors
#' @param iconL list of valueBox icons. Do not enclose in 'icon()'
#'
#' @export
#' @keywords internal

mod_valueBoxRow_server <- function(input, 
                                   output,
                                   session, 
                                   outputL, 
                                   valueL,
                                   colorL = rep("aqua", length(valueL)),
                                   iconL = rep("table",length(valueL))
                                   ){
  ns <- session$ns




  purrr::pmap(list(outputL, valueL, colorL, iconL), function(outputL, valueL, colorL, iconL) {
    output[[outputL]] <- renderValueBox({
      valueBox(
        value = valueL,
        subtitle = outputL,
        color = colorL,
        icon = icon(iconL)
      )
    })
  })
}


## To be copied in the UI
# mod_my_first_module_ui("my_first_module_ui_1")

## To be copied in the server
# callModule(mod_my_first_module_server, "my_first_module_ui_1")
