# Load R package
library(pacman)
p_load(shiny,shinythemes)

  # Define UI
  ui <- fluidPage(theme= shinytheme("superhero"),
                  navbarPage(
                  # theme= "superhero", #<---to use a theme, uncomment this
                    "My web app",
                    tabPanel ("Navbar 1",
                              sidebarPanel(
                                tags$h3("Input:"),
                                textInput("txt1","First Name:", ""),
                                textInput("txt2","Last Name:", ""),
                              ),# end of side
                              mainPanel(
                                h1("Header 1"),
                                h4("Output 1"),
                                verbatimTextOutput("txtout")
                              )# end of main
                      ),#end of Nav1,tab
                    tabPanel("Navbar2"," This panel is intentionally left blank"),
                    tabPanel("Navbar3"," This panel is intentionally left blank")
                    
                ) #end of nav page
              )# end of fluidpage
 
   # Define server function
  server <- function(input,output){
    output$txtout <- renderText({
      paste (input$txt1, input$txt2, sep=" ")
    })
  }# send of server
  
  # Create Shiny object
  
  shinyApp(ui=ui, server=server)
  
  
  