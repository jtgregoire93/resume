# This script builds both the HTML and PDF versions of your CV

library(tidyverse)
readr::write_rds(cv_data, 'cached_positions.rds')
cache_data <- FALSE

# Knit the HTML version
rmarkdown::render("resume.rmd",
                  params = list(pdf_mode = FALSE, cache_data = cache_data),
                  output_file = "index.html")


# Knit the PDF version to temporary html location
tmp_html_cv_loc <- fs::file_temp(ext = ".html")
rmarkdown::render("resume.rmd",
                  params = list(pdf_mode = TRUE, cache_data = cache_data),
                  output_file = tmp_html_cv_loc)

# Convert to PDF using Pagedown
pagedown::chrome_print(input = tmp_html_cv_loc,
                       output = "resume.pdf") 
pdftools::pdf_compress("resume.pdf", output = "jgregoire_resume.pdf")
