#' format is "csv" or "excel"
read_files_combine <- function(FOLDER,
                       STR_TEXT  = NULL,
                       STR_START,
                       STR_STOP,
                       # NCOL,
                       FORMAT = "csv"){
  
  files <- list.files(FOLDER)
  
  if(!is.null(STR_TEXT)) {
    files <- files[str_sub(files,
                           STR_START, 
                           STR_STOP) == STR_TEXT]
  }

  out <- data.frame(matrix(nrow = 0, 
                           ncol = 0))
  
  for(i in seq_along(files)) {
    if(FORMAT == "csv") {
      temp    <- read.csv(paste0(getwd(), "/Data & Analysis/Data/Original data/Achievement/Research Data/", files[i]))
    } else if(FORMAT == "excel") {
      temp    <- read_excel(paste0(getwd(), "/Data & Analysis/Data/Original data/Achievement/Research Data/", files[i]))
    }
    temp$file <- paste0(as.character(files[i]))
    out       <- plyr::rbind.fill(out, temp)
  }
  
  out <- out[ ,colSums(is.na(out)) < nrow(out)]
}



read_files_separate <- function(FOLDER) {
  files <- list.files(FOLDER)
  
  for(i in seq_along(files)) {
    # if(str_sub(files[i], -4, -1) == ".csv") {
    #   temp <- read.csv(paste0(FOLDER, "/", files[i]))
    #   assign(files[i],
    #          temp,
    #          envir = .GlobalEnv)
    # } else
      if(grepl(".xls", files[i])) {
      temp <- readxl::read_excel(paste0(FOLDER, "/", files[i]))
      assign(files[i],
             temp,
             envir = .GlobalEnv)
    }
  }
}
# provide a way to exclude some items

add_df_name <- function(OBJS) {
  for(i in seq_along(OBJS)) {
    temp <- data.frame(get(OBJS[i]))
    temp$df_id <- paste(OBJS[i])
    assign(OBJS[i],
           temp,
           envir = .GlobalEnv)
  }
}