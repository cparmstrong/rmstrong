

# cpa_bullet_plot

cpa_plot_bullet <- function(DATA, 
                            OUTCOME, 
                            YLIM,
                            YPRE,
                            YPOST,
                            LABEL,
                            LEGPRE, 
                            LEGPOST, 
                            COLS, 
                            NWRAP, 
                            YLAB,                                     
                            DIR = getwd(),
                            NAME = paste0(deparse(substitute(DATA)), "_plot"),
                            SAVE = FALSE,
                            REVLEGEND = FALSE) {
  plot <- ggplot(data = DATA, 
                 aes(x = cpa_str_wrap_factor(OUTCOME, 
                                             NWRAP))) +
    geom_col(aes(y = YPRE, 
                 fill = LEGPRE),
             width = 0.8) +
    geom_col(aes(y = YPOST,
                 fill = LEGPOST), 
             width = 0.4) +
    geom_text(aes(y = YPOST - 0.05,
                  label = LABEL),
              hjust = 1,
              color = "#000000") +  # make into an argument that defaults to 0/f
    labs(x = "",
         y = YLAB) +    
    scale_fill_manual(name = "",
                      values = COLS) +
    guides(fill = guide_legend(reverse=REVLEGEND)) +
    theme(panel.background = element_rect(fill="white", color="white"),
          text = element_text(size=11, family="serif"),
          panel.border=element_rect(size=1, color="#000000", fill=NA),
          legend.position = "bottom",
          axis.text = element_text(color = "#000000"),
          axis.text.y = element_text(hjust=0.5)) +
    coord_flip(ylim = YLIM) # not ylim bc c_c is zoom
  assign(NAME,
         plot,
         envir = .GlobalEnv)
  print(plot)
  if (SAVE == TRUE) {
    ggsave(paste0(DIR, NAME, ".jpg"), 
           width = 6.5, 
           height = 2.5 + ((length(unique(OUTCOME))-3)/3), 
           dpi = 300)
  }
}
# 
#        # trying something different with the bullet plots
#         cpa_plot_bullet <- function(DATA, 
#                                     OUTCOME, 
#                                     YLIM,
#                                     YPRE,
#                                     YPOST,
#                                     LABEL,
#                                     LEGPRE, 
#                                     LEGPOST, 
#                                     COLS, 
#                                     I,
#                                     NWRAP, 
#                                     YLAB, 
#                                     NAME = DATA,
#                                     DIR = getwd(),
#                                     SAVE = FALSE) {
#           plot <- ggplot(data = DATA, 
#                          aes(x = str_wrap(OUTCOME, 
#                                           NWRAP))) +
#             geom_col(aes(y = YPRE, 
#                          fill = LEGPRE),
#                      width = 0.8) +
#             geom_col(aes(y = rep(1, 4)), 
#                      fill = c("#dddddd", "#bbbbbb", "#999999", "#777777"),
#                      position = "stack",
#                      width = 0.8) +
#             geom_errorbar(aes(ymin = YPOST, 
#                               ymax = YPOST), 
#                           color = COLS[I],
#                           size = 2,
#                           width = 0.8) +
#             geom_text(aes(y = YPOST - 0.05,
#                           label = LABEL),
#                       hjust = 1,
#                       color = "#ffffff") +
#             labs(x = "",
#                  y = YLAB) +    
#             scale_fill_manual(name = "",
#                               values = COLS) +
#             guides(fill = guide_legend(reverse=TRUE)) +
#             theme(panel.background = element_rect(fill="white", color="white"),
#                   text = element_text(size=11, family="serif"),
#                   panel.border=element_rect(size=1, color="#000000", fill=NA),
#                   legend.position = "bottom",
#                   axis.text.y = element_text(hjust=0.5)) +
#             coord_flip(ylim = YLIM) # not ylim bc c_c is zoom
#           assign(NAME,
#                  plot,
#                  envir = .GlobalEnv)
#           print(plot)
#           if (SAVE == TRUE) {
#             ggsave(paste0(DIR, NAME, ".jpg"), width=6.5, height=5, dpi=300)
#           }
#         }
