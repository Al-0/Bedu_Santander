#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(shinythemes)

# Define UI for application
ui <- fluidPage(
    dashboardPage(
        dashboardHeader(title = "Basic Dashboard"),
        skin = "green",
        dashboardSidebar(
            sidebarMenu(
                menuItem("Gráficas de Barras",
                         tabName = "chart-bar",
                         icon = icon(
                             name = "chart-bar",
                             class = NULL,
                             lib = "font-awesome")),
                menuItem("Gráficas de Probabilidades",
                         tabName = "graph",
                         icon = icon(
                             name = "images",
                             class = NULL,
                             lib = "font-awesome")),
                menuItem("Tabla de Datos",
                         tabName = "data-table",
                         icon = icon(
                             name = "table",
                             class = NULL,
                             lib = "font-awesome")),
                menuItem("Imágenes",
                         tabName = "images",
                         icon = icon(
                             name = "images",
                             class = NULL,
                             lib = "font-awesome"))
            )
        ),
        dashboardBody(
            tabItems(
                tabItem(
                    tabName = "chart-bar",
                    fluidRow(
                        titlePanel(h3("Gráficas de Barras", align = "center")),
                        selectInput("x", "Seleccione gráficas de visita o local.",
                                    choices = c("Goles de Local", "Goles de visita")),
                        
                        plotOutput("plot1", height = 900)
                    )
                ),
                tabItem(
                    tabName = "graph",
                    fluidRow(
                        tabsetPanel(
                            tabPanel(
                                title = "Home Team",
                                img(src = "PMFTHG.png")),
                            tabPanel(
                                title = "Away Team",
                                img(src = "PMFTAG.png")),
                            tabPanel(
                                title = "Home Team vs Away Team",
                                img(src = "PC.png"))
                        )
                    )
                ),
                tabItem(
                    tabName = "data-table",
                    fluidRow(
                        titlePanel(h3("Tabla de Datos de Match.Data", align = "center")),
                        dataTableOutput("data_table")
                    )
                ),
                tabItem(
                    tabName = "images",
                    fluidRow(
                        tabsetPanel(
                            tabPanel(
                                title = "Factor de ganancia promedio",
                                img(src = "avg.png", height = 360, width = 540)
                            ),
                            tabPanel(
                                title = "Factor de ganancia máximo",
                                img(src = "max.png", height = 360, width = 540)
                            )
                        )
                    )                
                )
            )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    library(ggplot2)
    library(dplyr)
    
    match.data <- na.omit(read.csv("match.data.csv"))
    
    
    output$plot1 <- renderPlot({
        
        res <- vector()
        for (i in 1:dim(match.data)[1]){
            if(match.data$home.score[i] > match.data$away.score[i]) {
                res[i] <- "H"
            } else {
                if(match.data$home.score[i] < match.data$away.score[i]) {
                    res[i] <- "A"
                } else {
                    res[i] <- "D"
                }
            }
        }
        
        match.data <- mutate(match.data, FTR = res)
        #summary(match.data)
        match.data %>% ggplot(aes(match.data[,ifelse(input$x == "Goles de Local", "home.score", "away.score")], fill = FTR)) + 
            geom_bar() + 
            facet_wrap("away.team") +
            
            labs(x =input$x, y = "Goles") + 
            ylim(0,50)
    })
    
    
    output$data_table <- renderDataTable(
        {match.data},
        options = list(aLengthMenu = c(20, 50, 100, 500, 1000), iDisplayLength = 20)
    )
}

# Run the application 
shinyApp(ui = ui, server = server)
