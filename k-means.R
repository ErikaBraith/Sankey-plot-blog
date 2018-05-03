# K-means clustering - price and ratings for makeup brands

pacman::pload(dplyr, ggplot2, cluster)
readRDS(rating)


## K-means with scaled data 
rate = scale(rating)


# Make a screeplot
source(gap-statistic.R)

scree.dat = clusGap(rate, kmeans, 10, B = 100, verbose = interactive())
png("scree-plot.png")
gap_statistic(rate)
dev.off()


ratingCluster = kmeans(rate, 3, nstart = 20)
ratingCluster
table(ratingCluster$cluster,rating$brand)

ratingCluster$cluster =  as.factor(ratingCluster$cluster)

scaled.rate = data.frame(rate)

# I want to eventually add elipses around the cluster
cluster.plot = ggplot(data = scaled.rate, aes(x = price, y = rating, colour = ratingCluster$cluster)) +
        geom_point() + 
        #geom_hline(yintercept = 3.5) + 
        #geom_vline(xintercept = 20) + 
        theme(legend.position = 'none') + 
        labs(x = 'Scaled price', 
             y = 'Scaled ratings') + 
        #geom_label(aes(label = brand)) + 
        scale_color_brewer(palette="Dark2") + 
        theme_bw() + 
        ggtitle('K means')

cluster.plot

ggsave(cluster.plot, filename = 'cluster-plot.png', width = 8, height = 6)
