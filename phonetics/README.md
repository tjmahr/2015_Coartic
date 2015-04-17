This folder contains the [Praat] script used to extract formant values 
used in Fig. 1. 

`main.praat` creates csv files of the formants for each of the tokens of 
_the_ used in the study. The script was [run from the command line][cli] 
using: 

```
praatcon -a main.praat tokens 3 4000 0 > results.txt
```

Spectrograms of each token are in `plots`. These images were produced 
by the same script--but not from the command line--since `praatcon` 
crashed whenever it tried to save png files. Running the script 
interactively, i.e. from within the Praat program and not from the 
command line, will produce the plots without crashing when the "draw 
formants" option is checked.. 


[praat]: http://www.fon.hum.uva.nl/praat/ "Praat website"
[cli]: http://www.fon.hum.uva.nl/praat/manual/Scripting_6_9__Calling_from_the_command_line.html "Command line documentation"
