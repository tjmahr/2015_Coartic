# Codebook

These data were collected as part of the Little Listeners project.

## subj.csv

Child-level scores that relevant for analyses. One row per participant.

- `Subj`: Participant ID number.
- `Age`: Age in months. Rounded to one decimal place, so that 1.1 months 
  is 1 month, 3 days.
- `CDI`: TODO
- `Trials_Block1`, `Trials_Block2`: Number of trials in first/second block.
  Values < 23 indicate that the block was terminated early.
- `PropNA_200_2000`: Proportion of missing eye-tracking data between 
  185-1015 ms. These time values are offset by 1 frame so that when the data are 
  downsampled into 50-ms bins, the center frame for the first and final bins 
  are 200 and 1000 ms.
- `Excluded`: Reason for excluding the child's looking data.
    + `NA`: Included subject.
    + `too-few-trials`: Child has less than 15 trials in one block. The cut-off 
      15 was chosen because it amounts to two-thirds of an experimental block.
    + `no-trials`: Child has no trials at all. They came into the lab, but the 
      child could not be tested. 
    + `excessive-missing-data`: Child has enough trials, but they have more than 
      50% missing data during the analysis window.

### genders.csv

Numbers of included children in each gender. One row per gender.

- `Excluded`: Reason for excluding the child's looking data.
- `Gender`: M: male, F: female.
- `n`: Number of children.

We don't include individual children's genders in the `subj.csv` file because 
that variable was not relevant for our analyses. But we do report general 
demographics in the text, so we include a breakdown in `genders.csv`

## trials.csv

Trial-level (stimuli) properties. One row per trial.

- `Subj`: Participant ID number.
- `Block`: Which of the two experimental blocks this trial belongs to.
- `TrialNo`: Trial number.
- `TargetWord`: Target word.
- `ImageL`, `ImageR`: Image files used for the left/right images.
- `TargetImage`, `DistractorImage`: Which image location (left/right) contain 
  the target/distractor images.
- `Target`: Target word.
- `Audio`: Name of the wav file played for this trial.
- `StimType`: Experimental condition.
    + `facilitating`: Experimental trial in which the determiner has 
      facilitating coarticulation.
    + `neutral`: Experimental trial in which the determiner has neutral 
      coarticulation.
    + `filler`: Filler trial (determiner has neutral coarticulation)
- `BlockOrder`: Relative ordering of the `Block`s within this `Subj`. 1 if this 
  trial belongs to first block that the child saw, and 2 if this trial belongs 
  to the second block.

## gazes.csv

Eye-tracking data. One row per frame of eye-tracking. Raw data were lightly 
pre-processed (see text) using [my `lookr` R package][lookr] 
circa [commit 100ca12e21][100ca12e21]. 

- `Subj`: Participant ID number.
- `Block`: Which of the two experimental blocks this trial belongs to.
- `TrialNo`: Trial number.
- `Time`: Timestamp of the eye-tracker (ms). Times are relative to 
  target-onset, so the target word begins at 0 ms. The determiner begins 
  at -600 ms.
- `XMean`, `YMean`: X/Y locations of the gaze onscreen in terms of screen 
  proportions. Location (0,0) is located in the lower-left corner of the screen.  
- `GazeByAOI`: Location of the gaze onscreen, expressed as an area of interest.
    + `ImageL`, `ImageR`: Gaze located within the left/right image.
    + `tracked`: Gaze located onscreen but not within the left/right image.
    + `NA`: Gaze not tracked.
- `GazeByImageAOI`: Location of the gaze onscreen, expressed as 
  target/distractor/other.
    + `Target`, `Distractor`: Gaze located within the Target/Distractor image.
    + `tracked`: Gaze located onscreen but not within the Target/Distractor 
      image.
    + `NA`: Gaze not tracked.

## binned_looks.csv, model_data.csv

Binned looking probabilities for each Child x Condition. One row per bin of time.

- `Subj`: Participant ID number.
- `Condition`: Experimental condition.
    + `facilitating`: Experimental trial in which the determiner has 
      facilitating coarticulation.
    + `neutral`: Experimental trial in which the determiner has neutral 
      coarticulation.
    + `filler`: Filler trial (determiner has neutral coarticulation)
- `Bin`: Bin number. Looks were down-sampled into 50 ms bins.
- `Time`: Timestamp of the binned looking data (ms) at the center of the bin. 
  Times are relative to target-onset, so the target word begins at 0 ms.
- `ToDistractor`, `ToTarget`: Number of looks to target/distractor image in the bin.
- `elogit`: Empirical log-odds of viewing target during the bin.
- `elogit_wt`: Weighting value for the empirical log-odds. See [Barr's page][Barr].
- `Proportion`: Proportion of looks to target in the bin.

`model_data.csv` has the same columns, except the `filler` condition has been 
removed and the times covered by the bins range from 200 to 1000 ms (the 
analysis window.) It has three additional columns:

- `ot1`, `ot2`, `ot3`: Orthogonal linear, quadratic, cubic polynomials fitted to 
  the Bin number. Allows us to compute uncorrelated Time, Time^2^, Time^3^ 
  coefficients in the models.

[lookr]: https://github.com/tjmahr/lookr
[100ca12e21]: https://github.com/tjmahr/lookr/tree/100ca12e21b347038f250c637c461ba26c4702f6
[Barr]: http://talklab.psy.gla.ac.uk/tvw/elogit-wt.html
