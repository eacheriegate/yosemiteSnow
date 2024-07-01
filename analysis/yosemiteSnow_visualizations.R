library(ggplot2)
library(extrafont)

############################################
########## Manually Made Legends  ##########
############################################

# Change detection map colors
colors <- c("#006694", "#ffffff", "#9a5532")


# Create a data frame for the dummy plot
data <- data.frame(x = 1, value = seq(-1, 1, length.out = 100))
data$fill <- data$value

p <- ggplot(data, aes(x, fill = value)) +
  geom_tile(aes(y = value, height = 0.02), color = "black", size = 0.5) + 
  scale_fill_gradientn(colors = colors, limits = c(-1, 1), name = "Relative Pixel Difference",
                       breaks = c(-1, 0, 1), labels = c("-1", "0", "1")) +
  theme_void() +
  theme(
    legend.title = element_text(face = "bold", color = "white", size = 18, margin = margin(b = 15)),
    legend.text = element_text(size = 16, color = "white", margin = margin(l = 10)),
    legend.position = "right",
    legend.key.height = unit(0.3, "in"),
    text = element_text(family = "Times New Roman"))


p

g_legend <- function(a.gplot) {
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)
}

legend <- g_legend(p)

ggsave("D:/Emma_C/projects/yosemiteSnow/data/data_finalized/results/CD_legend.png", legend, bg = "transparent", width = 3, height = 2.5, dpi = 800)

