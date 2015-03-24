echo "Building data set"
Rscript --no-environ R/01_bin_looks.R

echo "Fitting models"
Rscript --no-environ R/02_models.R

echo "Generating report output"
Rscript -e '
  options(warn = -1)
  rmarkdown::render("reports/participants.Rmd")
  rmarkdown::render("reports/model_summary.Rmd")
'
