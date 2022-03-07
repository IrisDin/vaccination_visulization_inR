library(ggplot2)
library(plotly)
library(dplyr)
library(tidyverse)

# load the data
country_vac <- read.csv("https://raw.githubusercontent.com/info-201b-wi22/final-project-IrisDin/main/country_vaccinations.csv?token=GHSAT0AAAAAABRSLIK2HJKRZCJPDBCGOOFYYROVNXA")
manu_vac <- read.csv("https://raw.githubusercontent.com/info-201b-wi22/final-project-IrisDin/main/country_vaccinations_by_manufacturer.csv?token=GHSAT0AAAAAABRSLIK3YTTS3SECTDZZXNQQYROVOVQ")

# Making interactive plots
# the visualization is about world co2 
# users can choose the year and country

server <- function(input, output) {
  
  output$Plot <- renderPlotly({
    # Allow user to filter by multiple countries
    climate_data <- climate_data %>% filter(country == input$user_category) %>% 
      filter(year > input$slider_year[1] & year < input$slider_year[2])
    plot <-  ggplot(data = ) +
      geom_line(mapping = aes(x = , 
                              y = , 
                              color= )) +
      labs(x = "", y = "", title = "")
    
    # Make interactive plot
    plotly_plot <- ggplotly(co2_plot)
    
    return(plotly_plot)
  })
}
