# import the library we need to use
library(ggplot2)
library(plotly)
library(bslib)
library(dplyr)
library(ggplot2)
library(tidyverse)
#load the dataset
vac_data <- read.csv("https://raw.githubusercontent.com/info-201b-wi22/final-project-IrisDin/main/country_vaccinations.csv?token=GHSAT0AAAAAABQJIPKKBIXZC475QKPXS5CKYRPXS7Q")
vac_type_data <- read.csv("https://raw.githubusercontent.com/info-201b-wi22/final-project-IrisDin/main/country_vaccinations_by_manufacturer.csv?token=GHSAT0AAAAAABQJIPKKN2REY6KTUB2TIXI4YRPXTSA")
vac_type_data <- rename(vac_type_data, country = location)
options(scipen=999)
vac_type_data$date <- as.Date(vac_type_data$date)
vac_data$date <- as.Date(vac_data$date)

intro_tab <- tabPanel(
  "Introduction",
  fluidPage(theme = bs_theme(bootswatch = "minty"),
            h1(""),
            p("Welcome")
  )
)


type_plot_main <- mainPanel(
  plotlyOutput(outputId = "vacplot"),
  h1("Description/Analysis of the visulization:"),
  br(),
  p("The reason why we construct the vaccine used in the world, to be more specific, classified by the brand of the vaccine throughout of the world, is to see what's the trend of people getting vaccinated worldwide, and reveals the people's awareness of self-protection.  Meanwhile, we can spot among all these different kinds of vaccines, which one is most prevalent after all. From the graphs generated, it is very obvious, considering all the countries as a whole, more and more people getting vaccinated global-wise, an increasing pattern, though there are some sag occurred. Another insight we can extract the graph is that the most popular vaccine would be Pfizer/BioNtech, Moderna, and Pfizer is the one used most frequently.", style = "font-size:23px;")
)

plot_sidebar_type <- sidebarPanel(
  selectInput(
    inputId = "vac_type",
    label = "Select vaccine",
    choices = vac_type_data$vaccine,
    selected = "Moderna",
    multiple = TRUE
  )
)

vac_type_tab <- tabPanel(
  "Vaccine types used in the world",
  sidebarLayout(
    plot_sidebar_type,
    type_plot_main
  )
)

line_sidebar <- sidebarPanel(
  selectInput(
    inputId = "user_category",
    label = "Select country",
    choices = vac_data$country,
    selected = "China",
    multiple = TRUE,
  ),
  dateRangeInput(inputId = "date", label = "Date range",
                 start = '2021-10-01',
                 end  = '2021-12-31')
)

line_plot_main <- mainPanel(
  plotlyOutput(outputId = "fig"),
  h1("Description/Analysis of the visulization:"),
  br(),
  p("", style = "font-size:23px;")
)

line_daily_vaccination_tab <-tabPanel(
  "Daily vaccination trend in different country/time",
  sidebarLayout(
    line_sidebar,
    line_plot_main
  )
)

ui <- navbarPage(
  "Covid-19 Vaccination Analysis",
  intro_tab,
  vac_type_tab,
  line_daily_vaccination_tab
)