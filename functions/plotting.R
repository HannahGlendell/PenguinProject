#making a plotting function


plot_boxplot <- function(data, 
                         x_column,
                         y_column,
                         x_label,
                         y_label,
                         colour_mapping) {
  #drop the na
  no_nan_data <- data %>%
    drop_na({{y_column}})
  
  #now we make the plot
  ggplot(
    data = no_nan_data,
    aes(x = {{x_column}},
        y = {{y_column}},
        color = {{x_column}} )) + 
    geom_boxplot(width = 0.3,
                 show.legend = FALSE) + 
    geom_jitter(aes(color = species),
                alpha = 0.3,
                show.legend = FALSE,
                position = position_jitter(
                  width = 0.2,
                  seed = 0)) +
    scale_color_manual(values = species_colours) +
    labs(x = "x_label",
         y = "y_label") +
    theme_bw()
}

species_colours <- c("Adelie" = "darkorange",
                     "Chinstrap" = "purple",
                     "Gentoo" = "cyan4")

plot_boxplot(penguins_clean, "species", "flipper_length_mm", "Penguin Species", "Flipper Length (mm)")


flipper_boxplot

######