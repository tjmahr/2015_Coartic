Data and R scripts for our article:

**Mahr, T., McMillan, B. T. M., Saffran, J. R., Ellis Weismer, S., & Edwards, J. (2015, in press). Anticipatory coarticulation facilitates word recognition in toddlers. _Cognition_.**

## Repository overview

* `data` contains the eye-tracking data, child demographics and model-ready 
  aggregated eye-tracking data. 
    - `data/README` provides a "codebook" for the data in each file.
* `R` contains scripts that aggregate the eye-tracking data, fit lme4 models, 
  as well as utility functions for formatting tables, numbers and other R objects.
* `reports` holds RMarkdown files that are used to produce formatted tables, 
  formatted citations, and number-heavy paragraphs which appear in the article.
* `packrat` helper directory for managing a custom R package library.

The shell script `build.sh` runs all the R scripts to aggregate the data, fit the models, 
and generate HTML output from the RMarkdown files.

This repository works best with a current version of RStudio. Current (2015) versions 
of RStudio include pandoc, and it is possible to render RMarkdown files or run the 
`build.sh` script with a single click. Use `New Project > Version Control > Git > ...` 
to clone this repository as an RStudio project. Once it's cloned, the `packrat` 
bootstrapper will download the packages and recreate the package library used for this 
repository.
