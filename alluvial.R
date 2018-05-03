
pacman::p_load(alluvial, data.table, tidyr, ggplot2, 
               ggforce, ggalluvial, plotly, magrittr, dplyr)

# Download data 
URL = 'http://makeup-api.herokuapp.com/api/v1/products.json'
MU = jsonlite::fromJSON(URL) %>% 
        select(brand, name, price, rating, category, product_type) 

# Convert brand, category and product_type into factors
cols = c('brand', 'category', 'product_type')
MU[cols] <- lapply(MU[cols], factor)

keep = c('almay', 'annabelle', 'benefit',  'cargo cosmetics', 'clinique', 
         'covergirl', 'dior', 'e.l.f',  "`l'oreal`", 'marcelle', 
        'maybelline', 'nyx', 'physicians formula', 'revlon', 'smashbox', 
        'wet n wild')

fewer = MU %>% 
        group_by(brand, product_type) %>% 
        mutate(count = n()) %>% 
        filter(count > 15  | brand %in% keep) %>% 
        ungroup()

# Turn data into Sankey data 
mu2 = fewer %>% 
        filter(rating != 'NA') %>% # get rid of products with missing ratings
        select(brand, rating, product_type) %>% # select brands and ratings
        mutate(rating = round(rating, 0)) %>% #round ratings to integers 
        group_by(brand, rating, product_type) %>% 
        summarise(count = n()) %>% #Create a count of number of brandXratings
        ungroup() %>% 
        #dplyr::rename(source = brand, 
        #              target = rating) %>% 
        na.omit() %>%
        mutate(brand = droplevels(brand)) %>% 
        arrange(desc(brand)) %>%  
        filter(count >1) %>% 
        data.frame()


# Alluvial plot
alluvial(mu2[,1:2], freq=mu2$count,
         col = ifelse(mu2$rating == "5", "orange", "grey"),
         border = ifelse(mu2$rating == "5", "orange", "grey"),
         hide = mu2$count < 5,
         cex = 0.6
)


# with GGplot

plot = ggplot(data = mu2, aes(axis1 = brand, axis2 = rating, axis3 = product_type, weight = count)) + 
        scale_x_discrete(limits = c('Brand', 'Rating', 'Product Type'), expand = c(.1, .05)) +
        geom_alluvium(aes(fill = rating, colour = rating), na.rm = T) + 
        geom_stratum(na.rm = T) +
        geom_text(stat= 'stratum', label.strata = T) +
        theme_minimal() + 
        ggtitle('Makeup brands, types and ratings') + 
        theme(axis.text.y=element_blank(), 
              panel.grid.major=element_blank(),
              panel.grid.minor=element_blank())



plot

        








data(majors)
head(majors)
majors$curriculum <- as.factor(majors$curriculum)
ggplot(majors,
       aes(x = semester, stratum = curriculum, alluvium = student,
           label = curriculum)) +
        geom_alluvium(fill = "darkgrey", na.rm = TRUE) +
        geom_stratum(aes(fill = curriculum), color = NA, na.rm = TRUE) +
        theme_bw() +
        theme(axis.text.x=element_blank(),
              axis.text.y=element_blank(),
              axis.ticks=element_blank(),
              axis.title.x=element_blank(),
              axis.title.y=element_blank(),
              legend.position="none",
              panel.background=element_blank(),
              panel.border=element_blank(),
              panel.grid.major=element_blank(),
              panel.grid.minor=element_blank(),
              plot.background=element_blank())

              