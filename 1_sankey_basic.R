#sankey plot
pacman::p_load(plotly)

#---most basic sankey plot from plotly website----
p <- plot_ly(
  type = "sankey",
  orientation = "h",
  
  node = list(
    label = c("A1", "A2", "B1", "B2", "C1", "C2"),
    color = c("blue", "blue", "blue", "blue", "blue", "blue"),
    pad = 15,
    thickness = 20,
    line = list(
      color = "black",
      width = 0.5
    )
  ),
  
  link = list(
    source = c(0,0,1,1,0,   2,3,2,2,2),
    target = c(2,2,2,2,3,   4,4,4,5,5),
    value =  c(2,0.5,0.2,1,0.5, 2,0.5,0.5,1,0.2)
  )
) %>% 
  layout(
    title = "Basic Sankey Diagram",
    font = list(
      size = 10
    )
  )

p


#----changed node names and some of the values----
q <- plot_ly(
  type = "sankey",
  orientation = "h",
  
  node = list(
    label = c("No gluten", "Gluten", "Non-natural", "Natural", "Non-Canadian", "Canadian"),
    color = c("blue", "blue", "blue", "blue", "blue", "blue"),
    pad = 15,
    thickness = 20,
    line = list(
      color = "black",
      width = 1
    )
  ),
  
  link = list(
    source = c(0,  0,  0, 1,   1,   2,  3,  2, 2,   2),
    target = c(2,  3,  2, 2,   2,   4,  4,  4, 5,   5),
    value =  c(2,0.2,0.5, 1.5, 1,   2,0.2,1.5, 0.5, 1)
  )
) %>% 
  layout(
    title = "Basic Sankey Diagram",
    font = list(
      size = 10
    )
  )

q

#----trying out adding in more nodes----

r <- plot_ly(
  type = "sankey",
  orientation = "h",
  
  node = list(
    label = c("No gluten", "Gluten", "Non-natural", "Natural", "Non-Canadian", "Canadian", "151", "29"),
    color = c("blue", "blue", "blue", "blue", "blue", "blue", "blue", "blue"),
    pad = 15,
    thickness = 20,
    line = list(
      color = "black",
      width = 1
    )
  ),
  
  link = list(
    source = c(0,  0,  0, 1,   1,   2,  3,  2, 2,   2,   4,  4,  4, 5,   5 ),
    target = c(2,  3,  2, 2,   2,   4,  4,  4, 5,   5   ,6,  6,  7, 6,   7),
    value =  c(2,0.2,0.5, 1.5, 1,   2,0.2,1.5, 0.5, 1,   2,1.5,0.2,0.5, 1)
  )
) %>% 
  layout(
    title = "Basic Sankey Diagram",
    font = list(
      size = 10
    )
  )

r

#----trying to use colours to see the paths----
#doesn't work very well. Not sure how to set alpha. also the colours are pretty ugly anyway
gg_color_hue <- function(n) {
  hues = seq(15, 375, length = n + 1)
  hcl(h = hues, l = 65, c = 100)[1:n]
}

gg_color_hue(5)


s <- plot_ly(
  type = "sankey",
  orientation = "h",
  
  node = list(
    label = c("No gluten", "Gluten", "Non-natural", "Natural", "Non-Canadian", "Canadian", "151", "29", "11", "3"),
    color = c("blue", "blue", "blue", "blue", "blue", "blue", "blue", "blue", "blue", "blue"),
    pad = 15,
    thickness = 15,
    line = list(
      color = "black",
      width = 1
    )
  ),
  
  link = list(
    source = c(  0,  0,  0, 1,   1,      2,  3,  2,   2,   2,       4,  4,  4,  5,   5 ),
    target = c(  2,  3,  2, 2,   2,      4,  4,  4,   5,   5,       7,  6,  8,  9,   9),
    value =  c(0.8,0.6,0.2, 2, 0.3,    0.8,0.6,  2, 0.2, 0.3,     0.8,  2,0.6, 0.2,0.3),
    color = c("#F8766D", "#A3A500", "#00BF7D", "#00B0F6", "#E76BF3",     "#F8766D", "#A3A500", "#00B0F6", "#00BF7D","#E76BF3",    "#F8766D", "#00B0F6","#A3A500", "#00BF7D","#E76BF3")
  )
) %>% 
  layout(
    title = "Basic Sankey Diagram",
    font = list(
      size = 10
    )
  )

s


##----Final sankey plot----
#this is as far as i got. i added in a border around each flow inside the link part, but it doesn't seem continuous.


t <- plot_ly(
  type = "sankey",
  
  orientation = "h",
  
  node = list(
    label = c("no gluten", "gluten", "non-natural", "natural", "non-Canadian", "Canadian", "151", "29", "11", "3"),
    color = c("white", "white", "white", "white", "white", "white", "white", "white", "white", "white"),
    pad = 10,
    thickness = 25,
    line = list(
      color = "black",
      width = 0.5
    )
  ),
  
  link = list(
    line = list(width =0.5),
    source = c(  0,  0,  0, 1,   1,      2,  2,  3,   2,   2,       4,  4,  4,  5,   5 ),
    target = c(  2,  3,  2, 2,   2,      4,  4,  4,   5,   5,       6,  7,  8,  9,   9),
    value =  c( 28, 11,  1, 151, 2,     29,151, 11,   1,   2,     151, 29, 11,  1,   2)#,
    #color = c("#F8766D", "#A3A500", "#00BF7D", "#00B0F6", "#E76BF3",     "#F8766D", "#A3A500", "#00B0F6", "#00BF7D","#E76BF3",    "#F8766D", "#00B0F6","#A3A500", "#00BF7D","#E76BF3")
  )
) %>% 
  layout(
    title = "Make-up categorization",
    font = list(
      size = 10
    )
  )

t


#tried to google reordering the nodes and pretty much only found this:
# https://stackoverflow.com/questions/48839386/plotly-sankey-diagram-how-to-change-default-order-of-nodes
#someone asked the question, and no one's posted an answer