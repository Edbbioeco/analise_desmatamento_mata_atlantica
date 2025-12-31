# Pacotes ----

library(rmarkdown)

# Convertendo RMD para MD ----

rmarkdown::render("readme.Rmd", 
                  rmarkdown::md_document(variant = "gfm"),
                  output_options = list(fig_path = "man/figures/"))
