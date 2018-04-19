# Sankey plot for blog post     
# Based on this blog post https://christophergandrud.github.io/networkD3/
# Data from: https://makeup-api.herokuapp.com/
# Code inspired by https://stackoverflow.com/questions/33499476/how-to-prepare-input-data-for-a-sankey-diagrams-in-r


pacman::p_load(networkD3, data.table, tidyr, ggplot2, plotly, magrittr, dplyr)


# Download data 
URL = 'http://makeup-api.herokuapp.com/api/v1/products.json'
MU = jsonlite::fromJSON(URL) %>% 
        select(brand, name, price, rating, category, product_type) 

# Convert brand, category and product_type into factors
cols = c('brand', 'category', 'product_type')
MU[cols] <- lapply(MU[cols], factor)

# Turn data into Sankey data 
mu2 = MU %>% 
        filter(rating != 'NA') %>% # get rid of products with missing ratings
        select(brand, rating) %>% # select brands and ratings
        mutate(rating = round(rating, 0)) %>% #round ratings to integers 
        group_by(brand, rating) %>% 
        summarise(value = n()) %>% #Create a count of number of brandXratings
        ungroup() %>% 
        dplyr::rename(source = brand, 
               target = rating) %>% 
        na.omit() %>% 
        data.frame()

# create the dataset that will need their name (links dataframe)
links = mu2
links$source = as.numeric(links$source)   
links$target = as.integer(links$target)
#mu2$source = gsub(" ", "_", mu2$source, fixed=TRUE)

# create nodes dataframe with 'name'
#nodes = mu2 %>% unite(name, target, source, sep = " ", remove = FALSE) %>% 
#        select(name)

# nodes 3 doesn't work! nodes1
nodes1 = mu2 %>% select(source) %>% dplyr::rename(name = source)

#nodes3 = MU %>% filter(rating != 'NA') %>% distinct(brand) %>% na.omit %>% dplyr::rename(name = brand) %>% data.frame()
#nodes3$name = as.character(nodes3$name)

#nodes1$name = as.factor(nodes1$name)

# Change indexing to 0 because of javascript
links$source = links$source-1
links$target = links$target-1


# links = df called links (which has source, target & value)
# Nodes = df called nodes3 (which has name)

sankeyNetwork(Links = links, Nodes = nodes1, Source = "source",
              Target = "target", Value = "value", NodeID = "name")

        
# plotly
 plot_ly(
         type = 'sankey', 
         orientation = 'h', 
         
         node = list(
                 label = c('brand', 'name', 'product_type'), 
                 pad = 15, 
                 thickness = 20, 
                 line = list(
                         color = 'black', 
                         width = 0.5
                 )
         ), 
         
         link = list(
                 source = 'brand', 
                 targer = 'name', 
                 value = ''
         )
 )

# Plot
sankeyNetwork(Links = Energy$links, Nodes = Energy$nodes, Source = "source",
              Target = "target", Value = "value", NodeID = "name",
              units = "TWh", fontSize = 12, nodeWidth = 30)






