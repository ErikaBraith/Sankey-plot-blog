pacman::p_load(readxl, plotly)

#found someone's sankey plots on the plotly website. 
# https://plot.ly/~alishobeiri/1257/plotly-sankey-diagrams/#/
#somehow, i haven't figured out why, the nodes on the left don't seem ordered by value. it uses a dataframe instead of inputing the values in vectors.
#so i tried to duplicate this for the makeup data. i got basically the same thing as t from 1_sankey_plot but a little stranger.

#---scottish independence voting----

scottish_df <- read_xlsx("scottish_df.xlsx")


u <- plot_ly(
  type = "sankey",
  domain = c(
    x =  c(0,1),
    y =  c(0,1)
  ),
  orientation = "h",
  valueformat = ".0f",
  node = list(
    label = scottish_df$`Node, Label`,
    color = scottish_df$Color,
    pad = 10,
    thickness = 25==30,
    line = list(
      color = "black",
      width = 0.5
    )
  ),
  
  link = list(
    line = list(width =0.5),
    source = scottish_df$Source,
    target = scottish_df$Target,
    value =  scottish_df$Value,
    color = scottish_df$`Link Color`
  )
) %>% 
  layout(
    title = "Scottish Referendum Voters who now want Independence",
    font = list(
      size = 10
    )
  )

u

#----trying the makeup plot from a df----

makeup_df <- read_xlsx("makeup_df.xlsx")


v <- plot_ly(
  type = "sankey",

  
  orientation = "h",
  valueformat = ".0f",
  node = list(
    label = makeup_df$`Node, Label`,
    color = makeup_df$Color,
    pad = 10,
    thickness = 30,
    line = list(
      color = "black",
      width = 0.5
    )
  ),
  
  link = list(
    line = list(width =0.5),
    source = makeup_df$Source,
    target = makeup_df$Target,
    value =  makeup_df$Value#,
    #color = makeup_df$`Link Color`
  )
) %>% 
  layout(
    title = "Makeup",
    font = list(
      size = 10
    )
  )

v
