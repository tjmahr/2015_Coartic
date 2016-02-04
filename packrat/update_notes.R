# These are the commands I had to run to get the packrat library up-to-date in
# Feb. 2016.


# Make sure R is up to date all the way

# # Manually update packrat
# install.packages("packrat")
# library("packrat")
# packrat::status()
# packrat::snapshot()


# restart session

# # Check which packages need to be updated. Do a big update (manually, not via
# # RStudio). If the process seems to hang, # that's the BH package. It takes
# # ~10 minutes to install.
# install.packages(c("BH", "broom", "curl", "digest", "dplyr", "evaluate",
# "formatR", "ggplot2", "highr", "htmltools", "knitr", "lme4", "mime", "plyr",
# "psych", "R6", "Rcpp", "RcppArmadillo", "RcppEigen", "readr", "rmarkdown",
# "scales", "stringi", "tidyr", "unmarked", "VGAM", "xtable"))
# packrat::status()


# restart session

# # re-install packages that raised errors
# install.packages("stringi")
# packrat::status()
# packrat::snapshot()


# other notes

# # If you see a package installation leftover, as indiciated in the error below,
# # close RStudio and delete it in packrat/lib
# Error in if (pkg$name == pkgName) return(pkg) :
#   argument is of length zero
# In addition: Warning message:
#   In FUN(X[[i]], ...) :
#   No DESCRIPTION file for installed package 'file7d454b92991'
