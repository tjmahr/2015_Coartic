
echo "Building data set"
Rscript --no-environ R/01_bin_looks.R

echo "Fitting models"
Rscript --no-environ R/02_models.R

echo "Removing old plots"
rm -v -- plots/*
rm -v -r -- reports/plots_files/

echo "Generating report output"
Rscript -e '
  options(warn = -1)
  rmarkdown::render("reports/citations.Rmd", "all")
  rmarkdown::render("reports/participants.Rmd", "all")
  rmarkdown::render("reports/model_summary.Rmd", "all")
  rmarkdown::render("reports/citations.Rmd", "md_document")
  rmarkdown::render("reports/participants.Rmd", "md_document")
  rmarkdown::render("reports/model_summary.Rmd", "md_document")
  rmarkdown::render("reports/plots.Rmd", "md_document")
'
