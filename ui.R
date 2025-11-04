library(bslib)
library(shiny)
library(ggplot2)

# Define the User Interface (Frontend)
ui <- fluidPage(
  titlePanel("Virtual Gene Generator"),
  
  # --- card con i controlli delle probabilità ---
  card(
    numericInput(inputId = "prob_A",
                 label = "Probability of A",
                 value = 0.25,
                 min = 0,
                 max = 1),
    numericInput(inputId = "prob_B",
                 label = "Probability of B",
                 value = 0.25,
                 min = 0,
                 max = 1),
    numericInput(inputId = "prob_C",
                 label = "Probability of C",
                 value = 0.25,
                 min = 0,
                 max = 1),
    numericInput(inputId = "prob_D",
                 label = "Probability of D",
                 value = 0.25,
                 min = 0,
                 max = 1)
  ),
  
  # --- layout con slider e risultati ---
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "n_bases",
                  label = "Number of bases:",
                  min = 3,
                  max = 60,
                  value = 30,
                  step = 3)
    ),
    mainPanel(
      # Quattro card per i quattro output
      card(
        h4("DNA sequence"),
        textOutput(outputId = "dna")
      ),
      card(
        h4("Transcribed RNA"),
        textOutput(outputId = "rna")
      ),
      card(
        h4("Translated Protein"),
        textOutput(outputId = "protein")
      ),
      card(
        h4("Base Frequencies"),
        textOutput(outputId = "base_freqs")
      ),
      card(
        h4("Base frequency plot"),
        plotOutput(outputId = "base_plot")
      )
    )
  )
)
