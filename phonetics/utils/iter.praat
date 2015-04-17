# # Demo: print all pairs of items in two file lists
# @strings_iter("fileList", "initialize")
# 
# while strings_iter.fileList.has_next
#     @strings_iter("fileList", "next")
#     @strings_iter("otherFileList", "initialize")
# 
#     while strings_iter.otherFileList.has_next
#         @strings_iter("otherFileList", "next")
#       
#         appendInfoLine: strings_iter.fileList.next$ + " " + 
#                         ... strings_iter.otherFileList.next$
#     endwhile
# endwhile

# An iterator for a list of strings
procedure strings_iter(.list$, .method$)
    selectObject: "Strings '.list$'"
    
    if .method$ = "initialize"
        .'.list$'.length = Get number of strings
        .'.list$'.index = 0
    endif
    
    if .method$ = "next"
        .'.list$'.index = .'.list$'.index + 1
        .'.list$'.next$ = Get string: .'.list$'.index
    endif

    
    if .method$ = "has_next"
        # .has_next is updated whenever procedure is invoked
    endif
    
    if .'.list$'.index < .'.list$'.length
        .'.list$'.has_next = 1
    else
        .'.list$'.has_next = 0
    endif
endproc
