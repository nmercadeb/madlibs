library(shiny)
library(useself)

cat("LOG --- Get back trace \n", file = stderr())
rlang::global_entrace()
options(rlang_backtrace_on_error = "full")

cat("LOG --- Generate story \n", file = stderr())
generate_story <- function(noun, verb, adjective, adverb) {
  glue::glue("
    Once upon a time, there was a {adjective} {noun} who loved to
    {verb} {adverb}. It was the funniest thing ever!!!
  ")
}

cat("LOG --- Read ui \n", file = stderr())
ui <- fluidPage(
  titlePanel("Mad Libs Game"),
  sidebarLayout(
    sidebarPanel(
      textInput("noun1", "Enter a noun:", ""),
      textInput("verb", "Enter a verb:", ""),
      textInput("adjective", "Enter an adjective:", ""),
      textInput("adverb", "Enter an adverb:", "")
      # actionButton("submit", "Create Story")
    ),
    mainPanel(
      h3("Your Mad Libs Story:"),
      textOutput("story")
    )
  )
)

cat("LOG --- Read server \n", file = stderr())
server <- function(input, output) {
  cat("LOG --- Reactive story \n", file = stderr())
  story <- reactive({
    generate_story(input$noun1, input$verb, input$adjective, input$adverb)
  })
  cat("LOG --- Output story \n", file = stderr())
  output$story <- renderText({
    story()
  })
}

cat("LOG --- Deploy shiny \n", file = stderr())
shinyApp(ui = ui, server = server)
