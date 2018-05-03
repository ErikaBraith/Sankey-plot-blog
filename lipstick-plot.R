# Code to make the plot for the blog post banner

pacman::p_load(ggplot2, png, grid)


img = readPNG("lipstick.png")
g = rasterGrob(img, interpolate=FALSE)
lip = qplot(1:10, 1:10, geom="blank") + 
        annotation_custom(g, xmin=4, xmax=6, ymin=2, ymax=6) +
        annotation_custom(g, xmin=1, xmax=3, ymin=3, ymax=6) +
        annotation_custom(g, xmin=7, xmax=10, ymin=5, ymax=8) +
        annotation_custom(g, xmin=7, xmax=10, ymin=1, ymax=4) +
        annotation_custom(g, xmin=3, xmax=6, ymin=6, ymax=9) +
        geom_point(color = 'lightgrey') +
        labs(x = '' ,
             y = '')

ggsave(lip, filename = 'lipstick-plot.png', width = 12, height = 8)


