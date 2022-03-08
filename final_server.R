# import the library we used
library(ggplot2)
library(plotly)
library(bslib)
library(dplyr)
library(ggplot2)
library(tidyverse)
# load the data
vac_data <- read.csv("https://raw.githubusercontent.com/info-201b-wi22/final-project-IrisDin/main/country_vaccinations.csv?token=GHSAT0AAAAAABQJIPKKBIXZC475QKPXS5CKYRPXS7Q")
vac_type_data <- read.csv("https://raw.githubusercontent.com/info-201b-wi22/final-project-IrisDin/main/country_vaccinations_by_manufacturer.csv?token=GHSAT0AAAAAABQJIPKKN2REY6KTUB2TIXI4YRPXTSA")

options(scipen=999)
vac_data$date <- as.Date(vac_data$date)

server <- function(input, output) {
  
    output$vacplot <- renderPlotly({

    vac_type_data <- vac_type_data %>% filter(vaccine == input$vac_type)
    vac_plot <- ggplot(data = vac_type_data) +
      aes(x = date, fill = vaccine, group = vaccine, weight = total_vaccinations) +
      geom_bar() +
      coord_flip() +
      scale_fill_brewer("Vaccine", palette = "Dark2")+
      scale_y_continuous(labels = scales::label_number_si()) +
      labs(x = "Date", y = "Total Vaccination", title = "Vaccine types used in the world") +
      theme_minimal() +
      facet_wrap(~vaccine, scales="free")

    vac_plot <- vac_plot + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
    # Make interactive plot
    my_plotly_plot <- ggplotly(vac_plot)
    return(my_plotly_plot)
  })
  
  output$fig <- renderPlotly({
    my_plot <- vac_data %>% filter(country == input$user_category) %>% filter(date >= input$date[1] & date <= input$date[2])
    plots <- ggplot(data = my_plot) + geom_line(mapping = aes(x = date, y = daily_vaccinations, color = country)) +
      scale_y_continuous(labels = scales::label_number_si())+
      labs(x = "Date", y = "daily Vaccination", title = "Daily vaccination trend")
    my_plotly_plot <- ggplotly(plots)
    return(plots)
  })
  
}