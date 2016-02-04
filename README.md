Research compendium for our article:

Mahr, T., McMillan, B. T. M., Saffran, J. R., Ellis Weismer, S., & Edwards, J. (2015). 
**Anticipatory coarticulation facilitates word recognition in toddlers.** _Cognition_, 
_142_, 345–350. [10.1016/j.cognition.2015.05.009](http://doi.org/10.1016/j.cognition.2015.05.009)

## Repository overview

* `data` contains the eye-tracking data, child demographics and model-ready 
  aggregated eye-tracking data. 
    - `data/README` provides a "codebook" for the data in each file.
* `R` contains scripts that aggregate the eye-tracking data, fit lme4 models, 
  as well as utility functions for formatting tables, numbers and other R 
  objects.
* `reports` holds RMarkdown files that are used to produce formatted tables, 
  formatted citations, and number-heavy paragraphs which appear in the article.
* `plots` contains the figures for the article.
* `phonetics` houses Praat scripts.
* `stimuli` contains sounds and images used in the experiment.
* `extras` are like the "bonus features" from the project.
* `packrat` is helper directory for managing a custom R package library.

The shell script `build.sh` runs all the R scripts to aggregate the data, fit
the models, and generate HTML output from the RMarkdown files.

### Tools 

This repository works best with a current version of RStudio. Current (2015+) versions 
of RStudio include pandoc, and it is possible to render RMarkdown files or run the 
`build.sh` script with a single click. Use `New Project > Version Control > Git > ...` 
to clone this repository as an RStudio project. Once it's cloned, the `packrat` 
bootstrapper will download the packages and recreate the package library used for this 
repository. This process takes a while -- feel free to reread the article! (If that 
process fails, instead just manually install the packages listed  in `libraries.R`.) 
Once the bootstrapper finishes, click Build All in the Build tab to re-run all the 
analyses and re-render the RMarkdown documents.

### License 

The GPL-2 license applies to the R code I have written in the .R and .Rmd files and 
to the Praat scripting code in the .praat files. The data, collected at the University 
of Wisconsin–Madison, still belong to the university.

### Citation

Here is the BibTex entry for the article:

```
@article {Mahr2015,
title    = {Anticipatory coarticulation facilitates word recognition 
            in toddlers},
author   = {Mahr, Tristan and McMillan, Brianna T. M. and Saffran, Jenny R. 
            and {Ellis Weismer}, Susan and Edwards, Jan},
year     = {2015},
journal  = {Cognition},
pages    = {345--350},
volume   = {142},
doi      = {10.1016/j.cognition.2015.05.009},
url      = {http://doi.org/10.1016/j.cognition.2015.05.009},
abstract = {Children learn from their environments and their caregivers. 
            To capitalize on learning opportunities, young children have to 
            recognize familiar words efficiently by integrating contextual 
            cues across word boundaries. Previous research has shown that 
            adults can use phonetic cues from anticipatory coarticulation 
            during word recognition. We asked whether 18--24 month-olds (n=29) 
            used coarticulatory cues on the word "the" when recognizing the 
            following noun. We performed a looking-while-listening eyetracking 
            experiment to examine word recognition in neutral versus 
            facilitating coarticulatory conditions. Participants looked to the 
            target image significantly sooner when the determiner contained 
            facilitating coarticulatory cues. These results provide the first 
            evidence that novice word-learners can take advantage of 
            anticipatory sub-phonemic cues during word recognition.}
}
```
