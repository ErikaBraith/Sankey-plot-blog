# K-means clustering - price and ratings for makeup brands

pacman::p_load(tidyr, dplyr, ggplot2, cluster, factoextra, magrittr, gridExtra)

rating = readRDS('rating.rds')

# Data prep -------------------------------------------------
# Set seed 
set.seed(12345)

# Plot original data 

price.plot =  ggplot(dat = rating) + 
        geom_histogram(aes(x = price))

rating.plot = ggplot(dat = rating) + 
        geom_histogram(aes(x = rating))

# Scale data 
rating.scaled = scale(rating[,2:3])
# Create data frame from scaled matrix to plot
rating.scaled.df = data.frame(rating.scaled)

price.plot.scaled = ggplot(dat = rating.scaled.df) + 
        geom_histogram(aes(x = price)) + 
        labs(x = 'scaled price')

rating.plot.scaled = ggplot(dat = rating.scaled.df) + 
        geom_histogram(aes(x = rating)) + 
        labs(x = 'scaled rating')

# Plot together
dist.plot = grid.arrange(price.plot, rating.plot, price.plot.scaled, rating.plot.scaled)
ggsave(dist.plot, filename = 'dist-plot.png', width = 8, height = 6)

# K-means ---------------------------------------------------
# Make a screeplot of gap statistics for 1-10 clusters
source('gap-statistic.R')
png("scree-plot.png")
gap_statistic(rating.scaled)
dev.off()


# Specify 3 cluster
ratingCluster = kmeans(rating.scaled, 3, nstart = 20)
cluster.plot = fviz_cluster(ratingCluster, rating[, 2:3], ellipse.type = "norm", geom = 'point')
cluster.plot

ggsave(cluster.plot, filename = 'cluster-plot.png', width = 8, height = 6)




