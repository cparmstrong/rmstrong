

# my error function

clay_warning <- function(CONDITION, MESSAGE)

if(CONDITION == TRUE) {
  beepr::beep(5)
  cowsay::say(MESSAGE, by = "cow")
  if(STOP == TRUE) {
    # what's code to stop execution?
  }
}
