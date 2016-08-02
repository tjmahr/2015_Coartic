This folder contains the [Praat] script used to extract formant values 
used in Fig. 1. 

`main.praat` creates csv files of the formants for each of the tokens of 
_the_ used in the study. The script was [run from the command line][cli] 
using the script in `extract_formants.sh`.

The output from the Praat information console is piped into `results.txt`. 
This file also documents the version of Praat used.

Spectrograms of each token are in `plots`.

[praat]: http://www.fon.hum.uva.nl/praat/ "Praat website"
[cli]: http://www.fon.hum.uva.nl/praat/manual/Scripting_6_9__Calling_from_the_command_line.html "Command line documentation"
