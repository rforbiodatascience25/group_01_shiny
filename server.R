library("shiny")
library("bslib")
library("ggplot2")

# Define the Server (Backend)
server <- function(input, output) {
  # This block runs ONLY when its inputs (n_bases, base_probs_X) change.
  generated_dna <- reactive({
    # The 'dna' variable is created and stored here
    gene_dna(length = input$n_bases, 
             base_probs = c(input$base_probs_A, 
                            input$base_probs_T, 
                            input$base_probs_C,
                            input$base_probs_G))
  })
  output$protein <- renderText({
    dna <- generated_dna()
    rna <- transcribe_dna(dna)
    protein_sequence <- translate_rna(rna)
    
    return(protein_sequence)
  })
  
  output$base_freq <- renderDataTable({
    dna <- generated_dna()
    base_freq_df <- base_freqs(dna)
    
    return(base_freq_df)
  })
  
  output$freq_plot <- renderPlot({
    dna <- generated_dna()
    base_freq_df <- base_freqs(dna)
    plot <- plot_dist(base_freq_df)
    
    return(plot)
  })
}
