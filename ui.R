library("shiny")
library("bslib")
library("ggplot2")

# Define the User Interface (Frontend)
ui <- page_fluid(
  layout_columns(
    col_widths = 12,
    card(
      titlePanel("Virtual Central Dogma"),
      style = "background-color: #f0f0f0; padding: 15px;"
    )),
  layout_columns(
    col_widths = 12,
    card(
      titlePanel("About"),
      helpText("This app generates a random gene of a user defined length. 
               The user is also able to define base probabilities for each nucleotide, although they must sum up to 1.")
    )),
  layout_columns(
    col_widths = 12,
    card(
      card_header("Virtual Gene Generator"),
      sliderInput(inputId = "n_bases",
                  label = "Number of bases:",
                  min = 1,
                  max = 60,
                  value = 30,
                  width = "100%"),
      layout_columns(
        col_widths = c(3, 3, 3, 3),
        numericInput(inputId = "base_probs_A",
                     label = "Probability of A",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.05),
        numericInput(inputId = "base_probs_T",
                     label = "Probability of T",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.05),
        numericInput(inputId = "base_probs_C",
                     label = "Probability of C",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.05),
        numericInput(inputId = "base_probs_G",
                     label = "Probability of G",
                     value = 0.25,
                     min = 0,
                     max = 1,
                     step = 0.05)
      ))),
  layout_columns(
    col_widths = c(3, 6, 9),
    card(
      card_header("Generated protein sequence"),
      mainPanel(
        verbatimTextOutput(outputId = "protein")
        )
      ),
    card(
      card_header("DNA base frequencies"),
      mainPanel(
        dataTableOutput(outputId = "base_freq")
        )
      ),
    card(
      card_header("DNA base frequencies"),
      mainPanel(
        plotOutput(outputId = "freq_plot")
        )
      )
  )
)