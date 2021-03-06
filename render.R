# This script builds both the HTML and PDF versions of your CV

# declare param inputs to render
sheet_ss_id <-  "1JLnOdTkLmNy7c08_61NGYS2AlOt5fgqfPGmnKRW0pdM"
online_link <- "https://jtgregoire93.github.io/resume/"
pdf_location <- "https://github.com/jtgregoire93/resume/raw/main/jgregoire_resume.pdf"
# Knit the HTML version
rmarkdown::render("resume.rmd",
                  params = list(pdf_export = FALSE, 
                                sheet_ss_id = sheet_ss_id, 
                                online_link = online_link, 
                                pdf_location = pdf_location
                                ),
                  output_file = "index.html")


# Knit the PDF version to temporary html location
tmp_html_cv_loc <- fs::file_temp(ext = ".html")
rmarkdown::render("resume.rmd",
                  params = list(pdf_export = TRUE, 
                                sheet_ss_id = sheet_ss_id, 
                                online_link = online_link, 
                                pdf_location = pdf_location
                  ),
                  output_file = tmp_html_cv_loc)

# Convert to PDF using Pagedown
pagedown::chrome_print(input = tmp_html_cv_loc,
                       output = "resume.pdf") 
pdftools::pdf_compress("resume.pdf", output = "jgregoire_resume.pdf")

