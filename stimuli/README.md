# Stimuli
Tristan Mahr  
December 11, 2015  



## Design Summary

`trials.csv` contains a table documenting the experimental design. There is one
row per experimental trial designed. 

The columns of the table indicate:

* `Block`: The experiment was administer using two blocks of trials. This number 
  indicates which block includes this trial.
* `TrialNo`: The number of the trial within the block. Trials are numbered in 
  the order in which they are administered.
* `Condition`: Experimental condition.
* `WordGroup`: Which yoked pair of words were presented.
* `TargetWord`: The word named during that trial.
* `TargetImage`: The side of the screen ("ImageL" = left, "ImageR" = right) 
   containing the target image.
* `DistractorImage`: The side of the screen ("ImageL" = left, "ImageR" = right) 
   containing the distractor image.
* `ImageLFile`: Filename of the image presented on the left side of the screen.
* `ImageRFile`: Filename of the image presented on the left side of the screen.
* `CarrierWord`: Word used to start the carrier phrase.
* `CarrierPitch`: For variety, we use two versions of each carrier phrase 
  starter: One with a high ("hi") pitch and one with a low ("lo") pitch.
* `PromptFile`: Filename of the recording used as the prompt during the trial.
* `AttentionGetterFile`: Filename of the attention-getter/reinforcer that played 
  at the end of each trial.

The output below shows the first few values ("Observations") in each column
("Variables"):


```r
library("readr")
library("dplyr")
library("knitr")
stim_set <- read_csv("trials.csv")
glimpse(stim_set, width = 70)
```

```
#> Observations: 46
#> Variables: 13
#> $ Block               (int) 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1...
#> $ TrialNo             (int) 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12...
#> $ Condition           (chr) "neutral", "facilitating", "filler", ...
#> $ WordGroup           (chr) "dog-book", "duck-ball", "sock-cup", ...
#> $ TargetWord          (chr) "book", "ball", "sock", "duck", "book...
#> $ TargetImage         (chr) "ImageL", "ImageR", "ImageR", "ImageL...
#> $ DistractorImage     (chr) "ImageR", "ImageL", "ImageL", "ImageR...
#> $ ImageLFile          (chr) "book3", "duck1", "cup1", "duck2", "b...
#> $ ImageRFile          (chr) "dog3", "ball1", "sock1", "ball2", "d...
#> $ CarrierWord         (chr) "Where", "Find", "See", "Where", "Whe...
#> $ CarrierPitch        (chr) "hi", "lo", "lo", "hi", "hi", "lo", "...
#> $ PromptFile          (chr) "Whe_hi_the_V_Book_neut", "Fin_lo_the...
#> $ AttentionGetterFile (chr) "AN_LookAtThat", "AN_CheckitOut", "AN...
```

### Pivot Tables

We can check the balance of the trials by counting the trials under different
kinds of grouping. 

Number of times each word is the target in each condition:


```r
stim_set %>% 
  group_by(Condition, WordGroup, TargetWord) %>% 
  tally %>% 
  kable
```



Condition      WordGroup     TargetWord     n
-------------  ------------  -----------  ---
facilitating   dog-book      book           4
facilitating   dog-book      dog            4
facilitating   duck-ball     ball           4
facilitating   duck-ball     duck           4
filler         cat-car       car            2
filler         cat-car       cat            3
filler         cookie-shoe   cookie         3
filler         cookie-shoe   shoe           2
filler         sock-cup      cup            2
filler         sock-cup      sock           2
neutral        dog-book      book           4
neutral        dog-book      dog            4
neutral        duck-ball     ball           4
neutral        duck-ball     duck           4

Number of times the left or right side of the screen contained the target in
each condition:


```r
stim_set %>% 
  group_by(Condition, TargetImage) %>% 
  tally %>% 
  kable
```



Condition      TargetImage     n
-------------  ------------  ---
facilitating   ImageL          8
facilitating   ImageR          8
filler         ImageL          7
filler         ImageR          7
neutral        ImageL          8
neutral        ImageR          8
