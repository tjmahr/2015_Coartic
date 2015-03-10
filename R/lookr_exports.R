# Functions that normally are packaged in lookr (github.com/tjmahr/lookr), but
# are included here for reproducibility.

#' Aggregate looks to target image
#'
#' The returned dataframe has columns for the number of looks to the target
#' image (\code{Target}), looks to distractor image(s) (\code{Others}), number
#' of missing looks (\code{NAs}), number of tracked looks that don't fall in an
#' AOI (\code{Elsewhere}), and the proportion of looks to target versus
#' competing AOIs (\code{Proportion}).
#'
#' @param frame a dataframe of melted looking data, containing a
#'   \code{GazeByImageAOI} column.
#' @param formula a \code{dcast} formula for aggregating the looking data. The
#'   default is \code{Subj + Condition + Time ~ GazeByImageAOI}
#' @return a dataframe with columns of aggregated looks.
#' @importFrom reshape2 dcast
#' @export
aggregate_looks <- function(frame, formula = Subj + Condition + Time ~ GazeByImageAOI) {
  looks <- dcast(frame, formula = formula, fun.aggregate = length,
                 value.var = "GazeByImageAOI")
  other_AOIs <- setdiff(frame$GazeByImageAOI, c("Target", "tracked", NA))
  looks$Others <- rowSums(looks[other_AOIs])
  names(looks)[which(names(looks) == "NA")] <- "NAs"
  names(looks)[which(names(looks) == "tracked")] <- "Elsewhere"
  transform(looks, Proportion = Target / (Others + Target))
}

#' Assign bin numbers to a vector
#'
#' The first step in binning/down-sampling some data is assigning items to bins.
#' This function takes a vector and a bin size and returns the bin assignments.
#'
#' @param xs a vector
#' @param bin_width the number of items to put in each bin. Default is 3.
#' @param na_location Where to assign \code{NA} bin numbers. \code{"head"} and
#'   \code{"tail"} respectively put the NA elements at the head and tail of the
#'   vector; \code{"split"} alternates between \code{"tail"} and \code{"head"}.
#' @param partial whether to exclude values that don't fit evenly into bins.
#'   Defaults to FALSE, so that the user is warned if a bin is incomplete.
#' @return a vector of bin-numbers. If \code{bin_width} does not evenly divide
#'   \code{xs}, the remainder elements are given a bin number of \code{NA}.
#' @export
#' @examples
#' assign_bins(1:14, bin_width = 3, "head")
#' # [1] NA NA  1  1  1  2  2  2  3  3  3  4  4  4
#' assign_bins(1:14, bin_width = 3, "tail")
#' # [1]  1  1  1  2  2  2  3  3  3  4  4  4 NA NA
#' assign_bins(1:7, bin_width = 5, "split")
#' # [1] NA  1  1  1  1  1 NA
#' assign_bins(1:8, bin_width = 5, "split")
#' # [1] NA  1  1  1  1  1 NA NA
assign_bins <- function(xs, bin_width = 3, na_location = "tail", partial = FALSE) {
  if (is.unsorted(xs)) {
    warning("Elements to be binned are not sorted")
  }

  if (length(xs) != length(unique(xs))) {
    warning("Elements to be binned are not unique")
  }

  num_bins <- floor(length(xs) / bin_width)
  leftover <- length(xs) %% bin_width
  bin_indices <- sort(rep(seq_len(num_bins), times = bin_width))

  if (partial) {
    partial_bin <- rep(max(bin_indices) + 1, leftover)
    bin_indices <- c(bin_indices, partial_bin)
    leftover <- 0
  }

  if (na_location == "head") {
    bin_indices <- c(rep(NA, leftover), bin_indices)
  } else if (na_location == "tail") {
    bin_indices <- c(bin_indices, rep(NA, leftover))
  } else if (na_location == "split") {
    first <- floor(leftover / 2)
    last <- ceiling(leftover / 2)
    bin_indices <-  c(rep(NA, first), bin_indices, rep(NA, last))
  }

  lost_values <- xs[which(is.na(bin_indices))]

  if (length(lost_values) > 0) {
    listed_values <- paste0(lost_values, collapse = (", "))
    warning("Some values were not assigned to a bin: ", listed_values)
  }

  bin_indices
}





#' Compute empirical logit
#'
#' @param x vector containing number of looks to target
#' @param y vector containing number of looks to distractors
#' @return \code{empirical_logit} returns the empirical logit of looking to
#'   target. \code{empirical_logit_weight} returns weights for these values.
#' @export
#' @references Dale Barr's
#' \href{http://talklab.psy.gla.ac.uk/tvw/elogit-wt.html}{Walkthrough of an
#' "empirical logit" analysis in R}
empirical_logit <- function(x, y) {
  log((x + 0.5) / (y + 0.5))
}

#' @rdname empirical_logit
#' @export
empirical_logit_weight <- function(x, y) {
  var1 <- 1 / (x + 0.5)
  var2 <- 1 / (y + 0.5)
  var1 + var2
}

#' Compute orthogonal times
#'
#' @param times a vector of time values
#' @param degree of the desired polynomial
#' @return a data-frame with original time values and an \code{ot} column for
#'   each polynomial degree
#' @export
orthogonal_time <- function(times, degree) {
  clean_times <- sort(unique(times))
  time_df <- as.data.frame(poly(clean_times, degree))
  names(time_df) <- paste0("ot", names(time_df))
  time_df$Time <- clean_times
  time_df
}









