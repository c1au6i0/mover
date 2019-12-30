#' @import shiny
app_server <- function(input, output,session) {
  # List the first level callModules here
 callModule(mod_valueBoxRow_server, id = "xr", outputL = c("rate", "count", "users"), valueL = c(1,2,3))
  # output$rate <- renderValueBox({
  #   valueBox(
  #     value = 100,
  #     subtitle = "Total downloads",
  #     icon = icon("download")
  #   )
  # })
}
