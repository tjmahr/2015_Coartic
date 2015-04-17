procedure selectSound(.x$)
	selectObject: "Sound " + .x$
endproc

procedure plusSound(.x$)
	plusObject: "Sound " + .x$
endproc


procedure selectTextGrid(.x$)
	selectObject: "TextGrid " + .x$
endproc

procedure selectTable(.x$)
	selectObject: "Table " + .x$
endproc

procedure selectFormant(.x$)
	selectObject: "Formant " + .x$
endproc

procedure selectRemove(.type$, .x$)
	selectObject: .type$ + " " + .x$
	Remove
endproc