# infographic
## change this to get them all on one sheet so a .csv will work; just need to change the data argument in the function call from "temp" to "temp[temp$graphic==i,]"

infographic <- function(data, grid, big, small, bolded, notbold, cols, jpgname) {
  # just copied from above
  ggplot(data = data) +
    lims(x = c(0,100), y = c(0,100)) +
    geom_text(aes(x = 0, y = 50, label = big, color = grid), size = 20, hjust = 0, vjust = 0.5) +
    geom_text(aes(x = 100, y = 10, label = small, color = grid), size = 4, hjust = 1) +
    geom_text(data=data[data$bullet==1,], aes(x = 55, y = 80, label = bolded, color = grid), size = 3, hjust = 0, vjust = 0, parse = TRUE) +
    geom_text(data=data[data$bullet==1,], aes(x = 55, y = 80, label = notbold), color = "#000000", size = 3, hjust = 0, vjust = 0, parse = TRUE) +
    geom_text(data=data[data$bullet==2,], aes(x = 55, y = 68, label = bolded, color = grid), size = 3, hjust = 0, vjust = 0, parse = TRUE) +
    geom_text(data=data[data$bullet==2,], aes(x = 55, y = 68, label = notbold), color = "#000000", size = 3, hjust = 0, vjust = 0, parse = TRUE) +
    geom_text(data=data[data$bullet==3,], aes(x = 55, y = 56, label = bolded, color = grid), size = 3, hjust = 0, vjust = 0, parse = TRUE) +
    geom_text(data=data[data$bullet==3,], aes(x = 55, y = 56, label = notbold), color = "#000000", size = 3, hjust = 0, vjust = 0, parse = TRUE)  +
    geom_text(data=data[data$bullet==4,], aes(x = 55, y = 44, label = bolded, color = grid), size = 3, hjust = 0, vjust = 0, parse = TRUE) +
    geom_text(data=data[data$bullet==4,], aes(x = 55, y = 44, label = notbold), color = "#000000", size = 3, hjust = 0, vjust = 0, parse = TRUE) +
    facet_grid(grid ~ .) +
    scale_color_manual(values = cols) +
    theme(panel.background = element_rect(fill="#f2f2f2", color="white"),
          panel.grid = element_blank(),
          text = element_text(family="serif"),
          legend.position = "none",
          axis.title = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          strip.background = element_blank(),
          strip.text = element_blank())
  ggsave(paste0(getwd(), "/Output/", jpgname, ".jpg"), dpi = 300,
         height=1.4*max(as.numeric(as.character(data$grid))),
         width = 6.5)
  
}