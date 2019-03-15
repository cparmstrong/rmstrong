## CLay
## helper functions


files <- list.files()[str_sub(list.files(),-3, -1) == "csv"]
names(files) <- c("fac", "learn", "well", "staff")
files  # double check that they match

for(i in seq_along(files)) {
  assign(names(files[i]),
         read.csv(files[[i]]), 
         envir = .GlobalEnv)
}






files <- list.files("SOM_survey_export/")[stringr::str_sub(list.files("SOM_survey_export/"),-3, -1) == "csv"]
names(files) <- c("fac", "learn", "well", "staff")
files  # double check that they match

for(i in seq_along(files)) {
  assign(names(files[i]),
         read.csv(paste0(getwd(), "/SOM_survey_export/", files[[i]])), 
         envir = .GlobalEnv)
}


write.csv(well,  file = paste0(getwd(), "/Qualitative Responses/qual_wellness.csv"),row.names = FALSE)
write.csv(fac,   file = paste0(getwd(), "/Qualitative Responses/qual_fac.csv"),row.names = FALSE)
write.csv(staff, file = paste0(getwd(), "/Qualitative Responses/qual_staff.csv"),row.names = FALSE)
write.csv(learn, file = paste0(getwd(), "/Qualitative Responses/qual_learn.csv"),row.names = FALSE)
