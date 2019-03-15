rmstrong_depends <- c("dplyr", "foreign", ggplot2, stringr, tidyverse)
library(rmstrong_depends)

# package installation ----
# to load packages
# https://stackoverflow.com/questions/8175912/load-multiple-packages-at-once
# ricardo
mrip <- function(..., install = TRUE){
  reqFun <- function(pack) {
    if(!suppressWarnings(suppressMessages(require(pack, character.only = TRUE)))) {
      message(paste0("unable to load package ", pack,
                     ": attempting to download & then load"))
      install.packages(pack)
      require(pack, character.only = TRUE)
    }
  }
  lapply(..., reqFun)
}

# ipak function: install and load multiple R packages.
# check to see if packages are installed. Install them if they are not, then load them into the R session.
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

# usage
packages <- c("ggplot2", "plyr", "reshape2", "RColorBrewer", "scales", "grid")
ipak(packages)

