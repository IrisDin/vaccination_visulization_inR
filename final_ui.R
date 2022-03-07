library(ggplot2)
library(plotly)
library(bslib)
# load the data
country_vac <- read.csv("https://raw.githubusercontent.com/info-201b-wi22/final-project-IrisDin/main/country_vaccinations.csv?token=GHSAT0AAAAAABRSLIK2HJKRZCJPDBCGOOFYYROVNXA")
manu_vac <- read.csv("https://raw.githubusercontent.com/info-201b-wi22/final-project-IrisDin/main/country_vaccinations_by_manufacturer.csv?token=GHSAT0AAAAAABRSLIK3YTTS3SECTDZZXNQQYROVOVQ")

intro_tab <- tabPanel(
  "Introduction",
  # set the header/theme and text that showed on the main page
  fluidPage(theme = bs_theme(bootswatch = "minty"),
            h1("Intro/summary:"),
            p(""),
            br(),
            h2(""),
            p(""),
            br(),
            h3(""),
            p(""),
            
            p(" "),
            
            p(""),
            
            p(""),
  )
)

plot_sidebar <- sidebarPanel(
  selectInput(
    inputId = "Plot",
    label = "",
    choices = data$country,
    selected = "United States",
    multiple = TRUE),
  sliderInput("slider_year", label = h3("Year Range"), min = 1750, 
              max = 2020, value = c(2000, 2010))
)

plot_main <- mainPanel(
  plotlyOutput(outputId = ""),
  h1(""),
  p("")
)

plot_tab <- tabPanel(
  "Interactive visulization",
  sidebarLayout(
    plot_sidebar,
    plot_main
  )
)

analysis_page <- tabPanel(
  "",
  h1(""),
  p(""),
  br(),
  p("")
)

ui <- navbarPage(
  "",
  intro_tab,
  plot_tab,
  analysis_page
)