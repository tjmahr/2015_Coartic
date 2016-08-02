# For some reason, the script cannot save .png files from the command line.
# It can save png files when run interactively. Therefore, we set a boolean flag 
# "draw_formants" so that the command line doesn't crash, and 

include utils/select.praat
include utils/iter.praat
@reset_viewer()

# For reproducibility
writeInfoLine: "Praat Version: " + praatVersion$
writeInfoLine: "Date: " + date$()

# This script deviates slightly from the default formant-extraction 
# procedure by extracting 3 formants under 4 kHz instead of 5 formants 
# under 5.5 kHz.
form Measure formants in tokens in a folder
	sentence directory tokens
	real num_formants 3
	real max_frequency 4000
	boolean draw_formants 0
endform

cons_MAX_HZ = max_frequency
cons_N_FORMANTS = num_formants

writeInfoLine: "Max frequency: " + string$(cons_MAX_HZ)
writeInfoLine: "Num formants to extract: " + string$(cons_N_FORMANTS)

# Initialize a file-list iterator
sound_dir$ = directory$
Create Strings as file list: "fileList", sound_dir$ + "/*.wav"
@strings_iter: "fileList", "initialize"

# FYI to user
file_count = Get number of strings
writeInfoLine: "..." + string$(file_count) + " files found"

while strings_iter.fileList.has_next
	# Get the next sound
	@strings_iter("fileList", "next")
	file$ = strings_iter.fileList.next$
	token$ = file$ - ".wav"
	Read from file: sound_dir$ + "/" + file$
	
	# Make a csv of the formants
	@save_formants: token$, "formants"

	# Draw if asked to
	if draw_formants
		@draw_formants: token$, "plots"
	endif
		
	@selectRemove: "Sound", token$
endwhile

@selectRemove: "Strings", "fileList"




procedure save_formants(.token$, .dir$)
	@formants: .token$
	Down to Table: "yes", "yes", 6, "no", 3, "yes", 3, "yes"
	
	.output$ = .dir$ + "/" + .token$ + ".csv"
	writeInfoLine: "...saving " + .output$
	Save as comma-separated file: .output$

	@selectRemove: "Table", .token$
	@selectRemove: "Formant", .token$
endproc

procedure formants(.token$) 
	@selectSound: .token$
	To Formant (burg): 0, cons_N_FORMANTS, cons_MAX_HZ, 0.025, 50
	@selectFormant: .token$
endproc

procedure draw_formants(.token$, .dir$)
	@selectSound: .token$
	To Spectrogram: 0.005, cons_MAX_HZ, 0.002, 20, "Gaussian"
	Paint: 0, 0, 0, 0, 100, "yes", 50, 6, 0, "no"
	@selectRemove: "Spectrogram", .token$

	@formants: .token$
	Speckle: 0, 0, cons_MAX_HZ, 30, "yes"
	@selectRemove: "Formant", .token$	

	@make_title(.token$)
	Text top: "no", make_title.result$

	.output$ = .dir$ + "/" + .token$ + ".png"
	writeInfoLine: "...saving " + .output$
	Save as 300-dpi PNG file: .output$
	@reset_viewer()
endproc

procedure make_title(.token$) 
	.result$ = replace$(.token$, "_", " ", 1) 
endproc

procedure reset_viewer()
	Select outer viewport: 0, 6, 0, 4
	Helvetica
	Red
	Erase all
endproc
