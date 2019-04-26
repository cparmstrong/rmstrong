read_sheets <- function(FILE,
                        EXCLUDE = NULL,
                        NAMES = NULL) {
  sheets <- excel_sheets(FILE)

  if(!is.null(EXCLUDE)) {
    sheets <- sheets[sheets != c(EXCLUDE)]
  }

  out <- data.frame()
  for(i in seq_along(sheets)) {
    temp      <- read_excel(FILE, sheet = i)
    temp$sheet_id <- sheets[i]
    out <- rbind(out, temp)
  }

  if(!is.null(NAMES)) {
    names(out) <- NAMES
  }
  out
}
