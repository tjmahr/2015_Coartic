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
  rmarkdown::render("reports/citations.Rmd")
  rmarkdown::render("reports/participants.Rmd")
  rmarkdown::render("reports/model_summary.Rmd")
  rmarkdown::render("reports/plots.Rmd")
'
