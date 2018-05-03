# Alluvial plot for blog post     
# Data from: https://makeup-api.herokuapp.com/


pacman::p_load(jsonlite, listviewer, tidyr, plotly, ggplot2, factoextra, magrittr,
               dplyr, alluvial)

#install.packages('data.table') - choose to install from source

# Download data 
URL = 'http://makeup-api.herokuapp.com/api/v1/products.json'
MU = jsonlite::fromJSON(URL) %>% 
        dplyr::select(brand, price, rating, product_type, tag_list)

#saveRDS(MU, file = 'MU.rds')

# View json data 
jsonedit(MU, mode = "view", elementId = "MU")


# Keep selected brands
keep = c('almay', 'annabelle', 'benefit',  'cargo cosmetics', 'clinique', 
         'covergirl', 'dior', 'e.l.f',  "`l'oreal`", 'marcelle', 
         'maybelline', 'nyx', 'physicians formula', 'revlon', 'smashbox', 
         'wet n wild')

# Turn the product tags into a character, keep only complete data 
# Parse product tags into dummy variables
complete = MU %>% mutate(tags = as.character(tag_list), 
                         gluten = ifelse(grepl('Gluten', tags), 'no gluten', 'gluten'), 
                         natural = ifelse(grepl('Natural', tags), 'natural', 'non-natural'), 
                         canadian = ifelse(grepl('Canadian', tags), 'Canadian', 'non-Canadian')) %>% 
        na.omit() %>% 
        filter(brand %in% keep) %>% 
        data.frame()

complete$tag_list = NULL


# Convert brand, category and product_type into factors
cols = c('brand', 'product_type', 'gluten',  'natural', 'canadian')

complete[cols] <- lapply(complete[cols], factor)

# Count the combinations of all the 'healthy' indicators
healthy.dat = complete %>% select(cols) %>% 
        group_by(gluten, natural, canadian) %>% 
        summarise(count = n()) %>% 
        data.frame()

# Alluvial plot for 'healthiness' of makeup products collapsed over types and brands

alluvial(healthy.dat[,1:4], freq=healthy.dat$count,
         col = ifelse(healthy.dat$count== "151", "orange", "grey"),
         border = ifelse(healthy.dat$count == "151", "orange", "grey"),
         cex = 0.9, 
         cex.axis = 0.9, 
         axis_labels = c('Gluten \ncontent', 'Natural', 'Canadian', '# of \nproducts')
)


# saved interactively 

# How do individual brands perform
# 333 products with complete information on brand, price and ratings 

rating = MU %>% select(brand, price, rating) %>% 
        filter(brand %in% keep) %>% 
        na.omit() %>% 
        arrange(brand) %>% 
        mutate(price = as.numeric(price), 
               brand = as.factor(brand)) %>% 
        data.frame()

# Plot ratings versus prices 
rating.plot = ggplot(data = rating, aes(x = price, y = rating,  colour = brand)) +
        geom_point(alpha = 0.6) + 
        geom_hline(yintercept = 3.5) + 
        geom_vline(xintercept = 20) + 
        theme(legend.position = 'none') + 
        labs(x = 'Price', 
             y = 'Rating (1-5)') + 
        geom_label(aes(label = brand)) + 
        scale_color_brewer(palette="Paired") + 
        theme_bw() + 
        ggtitle('Price and ratings of makeup brands') + 
        theme(legend.title=element_blank())

rating.plot
plotly.rating = ggplotly(rating.plot)


# set y-axis  label position 
#plotly.rating[["x"]][["layout"]][["annotations"]][[3]][["y"]] <- 0.93
plotly.rating %<>% layout(margin = list(l = 120, b=70))

plotly.rating

# Publish to plot_ly

# save static plot 
ggsave(rating.plot, filename = 'rating-plot.png', width = 12, height = 8)

# save data 
#saveRDS(rating, file = 'rating.rds')


        
        







