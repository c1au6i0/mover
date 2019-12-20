#' @import shiny shinydashboard
app_ui <- function() {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here
    dashboardPage(
      dashboardHeader(title = div("moveR", style = "font-style: italic;")),
      dashboardSidebar(
        menuItem("Dashboard", tabName = "dashboard"),
        menuItem("Raw data", tabName = "rawdata")
      ),
      dashboardBody(
        tabItems(
          tabItem(
            "dashboard",
            fluidRow(
              mod_valueBoxRow_ui("xr", list("rate", "count", "users"))
            )
          ),
          tabItem(
            "rawdata",
            fluidRow(h2("xxxx"))
          )
        )
      )
    )
  )
}

#' @import shiny
golem_add_external_resources <- function() {
  addResourcePath(
    "www", system.file("app/www", package = "mover")
  )

  tags$head(
    golem::activate_js(),
    golem::favicon()
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    # tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
  )
}
