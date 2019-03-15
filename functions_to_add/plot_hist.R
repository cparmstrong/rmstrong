# library(ggplot2)

#### plots one var with filter and facets
#### HOW TO PASS STRINGS TO FILTER, GEOM, FACET
# peek at hist, didn't tell me much
crossec <- function(DATA,
                    VAR,
                    FACET , # add argument about order of facet + var in filename // OR/ALSO possible argument for creating your own name with ^^ default 
                    # add nrow arg
                    DIR) {
  p <- DATA %>%
    filter((!!as.name(VAR)) > 0) %>%  # string to filter
    ggplot() +
    geom_histogram(aes_string(x = VAR),
                   bins = 20) +  # string to geom
    facet_wrap(as.formula(paste("~", FACET)), ncol = 3)  # string to facet
  
  ggsave(filename = paste0(VAR, "+", FACET, ".jpg"),
         plot     = p,
         path     = DIR,
         width = 9, 
         height = 6.5,
         dpi = 300)
}

#### hist pltos and saves one var

hists <- function(DATA, VAR, DIR) {
  p <- ggplot(data = DATA) + 
    geom_bar(aes_string(x = VAR)) +
    scale_x_continuous(breaks = scales::pretty_breaks())
  
  ggsave(filename = paste0(VAR, ".jpg"),
         plot     = p,
         path     = DIR,
         width = 9, 
         height = 6.5,
         dpi = 300)
}

#### this monstrosity grabs all numerics and plots them
#### 
# example_data <- data.frame(w = rnorm(1000,  5,  1),
#                    x = rnorm(1000, 20,  1),
#                    y = rnorm(1000, 90, 15),
#                    z = rnorm(1000, 10,  4))
DATA <- dat
PANEL <- "school_name"
NCOL <- 3
i <- 1

# add argument to allow filtering (>< )
plot_hist <- function(DATA, 
                      DIR   = getwd(),
                      PANEL = NULL,
                      NCOL  = 3) {
  numerics <- DATA[ ,which(t(data.frame(lapply(DATA, is.numeric))))]
  numerics <- data.frame(lapply(numerics, as.numeric))
  
  for (i in seq_along(numerics)) {
    
    gg <- ggplot(data = numerics,
                 aes(x = numerics[ ,i])) +
      geom_histogram(#aes(y = ..density..),
                     bins = 20) +
      # geom_density(size = 1,
      #              color = "blue") + 
      labs(x = names(numerics)[i]) +
      facet_wrap( ~ school_name, ncol = 3)
      {if(!is.null(PANEL))}
    
    ggsave(filename = paste0("hist_", names(numerics)[i], ".jpg"),
           plot     = gg,
           path     = DIR,
           width    = 9,
           height   = 6.5,
           dpi      = 300)
  }
}

# grade level gets dropped from numerics; 
# create an opposite set file that contains all non-numerics
# generate dataset ID by sorting on student ID plus (something) and doing paste0(studentid, 1:xxxx)


# plot_hist(temp, "C:/Users/carmst18/Desktop/temp")




