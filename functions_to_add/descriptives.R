

## function to recode all NA issues
# trimws() ?
# NA, "NA", "" -> NA


# ## DEPENDENCIES
# library(ggplot2)
# library(tidyr)
# 
# ## TEST DATA
# # dummy variables
# temp <- data.frame(id = 1:100,
#                    q1 = rbinom(100, 1, 0.445),
#                    q2 = rbinom(100, 1, 0.689),
#                    q3 = c(rbinom(98, 1, 0.132), NA, NA))
# DATA = temp
# QNUMS = c("q1", "q2", "q3")
# DIR = getwd()
# i <- 1
# 
# DATA = nums
# QNUMS = names(nums[3:22])
# DIR = paste0(getwd(), "/Output/")
# i <- 1
# 
# 
# # numeric variables
# 
# #character variables
# 
# desc_dummy <- function(DATA, 
#                        QNUMS,  # character vector of dummy vars
#                        DIR = paste0(getwd(), "/Output/")) {
#   desc_dummy_out <- data.frame(
#     var           = character(),
#     n             = integer(),
#     true_count    = integer(),
#     false_count   = integer(),
#     na_count      = integer(),
#     true_perc     = numeric(),
#     false_perc    = numeric(),
#     na_perc       = numeric(),
#     stringsAsFactors = FALSE
#   )
#   for(i in 1:length(QNUMS)) {
#     desc_dummy_out[i,"var"]         <- QNUMS[i]
#     desc_dummy_out[i,"n"]           <- sum(!is.na(DATA[ ,QNUMS[i]]))
#     desc_dummy_out[i,"true_count"]  <- sum(DATA[ ,QNUMS[i]], na.rm = TRUE)    
#     desc_dummy_out[i,"false_count"] <- sum(!is.na(DATA[ ,QNUMS[i]])) - sum(DATA[ ,QNUMS[i]], na.rm = TRUE)
#     desc_dummy_out[i,"na_count"]    <- sum(is.na(DATA[ ,QNUMS[i]]))
#     desc_dummy_out[i,"true_perc"]   <- mean(DATA[ ,QNUMS[i]], na.rm = TRUE)
#     desc_dummy_out[i,"false_perc"]  <- 1 - mean(DATA[ ,QNUMS[i]], na.rm = TRUE)
#     desc_dummy_out[i,"na_perc"]     <- sum(is.na(DATA[ ,QNUMS[i]])) / length(DATA[ ,QNUMS[i]]) *100
#   }
# 
#   write.csv(desc_dummy_out, 
#             file = paste0(DIR, "/desc_dummy_out.csv"), 
#             row.names = FALSE)
# 
#   
#   
#   # the question numbers aren't in order (Q1, Q10, Q11, ..., Q8, Q9)
#   # make the y axis a percentage rather than a count; should be easy, just modify summarize call
#   # change legend labels
#   # run the graph with tests separated (so 3 total)
#   gg <- DATA %>%
#     gather(key = "question", 
#            value = "response",
#            QNUMS) %>%
#     group_by(question, response) %>% 
#     summarize(count = n()) %>%
#     replace_na(list(response = "Missing")) %>%
#     mutate(response = factor(response, 
#                              levels = c("0", "1", "Missing"))) %>%
#     ggplot() +
#       geom_bar(aes(x = question, 
#                    y = count,
#                    fill = response),
#                stat = "identity",
#                width = 0.8)  + # hard code conceptually restricted domain
#       scale_fill_manual(values = c("#000000", "#6cace4", "#002D72"))
#   # test to make sure 0<=sum(count)<=100
# 
#   ggsave(filename = "desc_dummy_out.jpg",
#          plot     = gg,
#          path     = DIR,
#          width    = 9,
#          height   = 6.5,
#          dpi      = 300)
# 
# }


# desc_dummy(temp, c("q1", "q2", "q3"))





desc_numeric <- function(DATA, 
                         # QNUMS,  # character vector of dummy vars
                         DIR = getwd()) {
  # select only numeric vars and get them back to numeric in a proper df
  numerics <- DATA[ ,which(t(data.frame(lapply(DATA, is.numeric))))]
  numerics <- data.frame(lapply(numerics, as.numeric))  # idk why they were char
  ##HEYAA!! I can use this tool to make them all into fucntions; use if() to selectively do code based on argument (only nums, only binary, only char, etc.) or could also let it do a whole df at once
  
  desc_numeric_out <- data.frame(
    var        = c(),
    n          = integer(),
    na         = integer(),
    percent_na = numeric(),
    median     = numeric(),
    sd         = numeric(),
    min        = numeric(),
    q1         = numeric(),
    mean       = numeric(),
    q3         = numeric(),
    max        = numeric(),
    range      = numeric(),
    stringsAsFactors = FALSE
  )
  for (i in seq_along(numerics)) {
    desc_numeric_out[i,"var"]    <- names(numerics)[i]
    desc_numeric_out[i,"n"]      <- nrow(numerics)
    desc_numeric_out[i,"na"]     <- sum(is.na(numerics[ ,i]))
    desc_numeric_out[i,"percent_na"] <- sum(is.na(numerics[ ,i])) / nrow(numerics)
    desc_numeric_out[i,"median"] <- median(numerics[ ,i], na.rm = TRUE)
    desc_numeric_out[i,"sd"]     <- sd(numerics[ ,i], na.rm = TRUE)
    desc_numeric_out[i,"min"]    <- min(numerics[ ,i], na.rm = TRUE)
    desc_numeric_out[i,"q1"]     <- quantile(numerics[ ,i], 0.25, na.rm = TRUE)
    desc_numeric_out[i,"mean"]   <- mean(numerics[ ,i], na.rm = TRUE)
    desc_numeric_out[i,"q3"]     <- quantile(numerics[ ,i], 0.25, na.rm = TRUE)
    desc_numeric_out[i,"max"]    <- max(numerics[ ,i], na.rm = TRUE)
    desc_numeric_out[i,"range"]  <- max(numerics[ ,i], na.rm = TRUE) - min(numerics[ ,i], na.rm = TRUE)
  }
  write.csv(desc_numeric_out, file = paste0(DIR, "/descriptives_numeric_out.csv"))
  # add warning to print path name and ensure it works
  
  # if(plot = TRUE)
  ## create violin plot for all
  # gg <- ggplot(data = temp) +
  #     geom_violin(aes(x = ))
  ## violin only works if all on same scale
  # what if running the function created a .Rmd and exported it all
  # 
  # ggsave(filename = "desc_numeric_out.jpg",
  #        plot     = gg,
  #        path     = paste0(DIR, "/Output/"),
  #        width    = 9,
  #        height   = 6.5,
  #        dpi      = 300)
}

 

# check if any columns are factors and convert to char
# subset to numeric vs. char -- will have to fix the looping








# skimr::skim()
# exmexamp %>%
  # select_if(is.numeric()) %>%
  # skimr::skim()