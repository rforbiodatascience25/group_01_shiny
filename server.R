library(bslib)
library(shiny)
library(ggplot2)

server <- function(input, output) {
  
  # --- 1️⃣ DNA ---
  output$dna <- renderText({
    dna_seq <- gene_dna(
      length = input$n_bases,
      base_probs = c(input$prob_A, input$prob_B, input$prob_C, input$prob_D)
    )
    return(dna_seq)
  })
  
  # --- 2️⃣ RNA ---
  output$rna <- renderText({
    # Usa il DNA generato sopra
    dna_seq <- gene_dna(
      length = input$n_bases,
      base_probs = c(input$prob_A, input$prob_B, input$prob_C, input$prob_D)
    )
    rna_seq <- transcribe_dna(dna_seq)
    return(rna_seq)
  })
  
  # --- 3️⃣ PROTEINA ---
  output$protein <- renderText({
    dna_seq <- gene_dna(
      length = input$n_bases,
      base_probs = c(input$prob_A, input$prob_B, input$prob_C, input$prob_D)
    )
    rna_seq <- transcribe_dna(dna_seq)
    protein_seq <- translate_rna(rna_seq)
    return(protein_seq)
  })
  
  # --- 4️⃣ FREQUENZE BASI ---
  output$base_freqs <- renderText({
    dna_seq <- gene_dna(
      length = input$n_bases,
      base_probs = c(input$prob_A, input$prob_B, input$prob_C, input$prob_D)
    )
    base_table <- base_freqs(dna_seq)
    # Convertiamo la tabella in testo leggibile
    paste0(
      "A: ", base_table$Freq[base_table$dna_vec == "A"], " | ",
      "C: ", base_table$Freq[base_table$dna_vec == "C"], " | ",
      "G: ", base_table$Freq[base_table$dna_vec == "G"], " | ",
      "T: ", base_table$Freq[base_table$dna_vec == "T"]
    )
  })
  
  # 5️⃣ Base frequency plot (ggplot)
  output$base_plot <- renderPlot({
    dna_seq <- gene_dna(
      length = input$n_bases,
      base_probs = c(input$prob_A, input$prob_B, input$prob_C, input$prob_D)
    )
    base_table <- base_freqs(dna_seq)
    
    ggplot(base_table, aes(x = dna_vec, y = Freq, fill = dna_vec)) +
      geom_bar(stat = "identity") +
      scale_fill_manual(values = c("A"="#1b9e77", "C"="#d95f02", "G"="#7570b3", "T"="#e7298a")) +
      labs(
        title = "Nucleotide frequencies",
        x = "Base",
        y = "Count"
      ) +
      theme_minimal(base_size = 14) +
      theme(legend.position = "none")
  })
}
