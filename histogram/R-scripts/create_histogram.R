# This script is designed to create a histogram. It can be easily adapted to differnt data sets. 
# Author: Sam Huguet  
# E-mail: samhuguet1@gmail.com  
# Date created: 13<sup>th</sup> December 2020

# Loading in the necessary packages_________________________________
  
  library(ggplot2)
  library(dplyr)
  library(grid)

# Viewing a file of our choice______________________________________
  
  datatable = file.choose()
  df = read.csv(datatable)  # To view the data, paste 'View(df)' into the console. 
  column_Name = sample(colnames(df),1)

# Here are the variables to change__________________________________
  
  binWidth = 0.5
  axis_label_font_size = 25
  min_x = 1
  max_x = 5
  min_y = 0
  max_y = 30

# Plotting data_____________________________________________________
  
  n_number = nrow(df)
  n_number = toString(n_number)
  text1 = "n ="
  n_number_text = paste(text1, n_number, sep = " ", collapse = NULL)
  
  grob <- grobTree(textGrob(n_number_text, x=0.75,  y=0.9, hjust=0,
                            gp=gpar(col="black", fontsize=axis_label_font_size, fontface="italic")))
  
  ggplot() + 
    geom_histogram(data=df, aes_string(x=column_Name), color="black", fill="lightblue", breaks=seq(min_x, max_x, by = binWidth))+
    scale_x_continuous(limits = c(min_x, max_x),
                       breaks = c(seq(min_x, max_x, by=binWidth)))+
    scale_y_continuous(limits = c(min_y,max_y), breaks = c(seq(min_y, max_y, by=5)))+
    ggtitle("Title")+
    ylab("Number of occurrences")+
    xlab("Condition")+
    annotation_custom(grob)+
    theme_bw()+
    theme(plot.title = element_text(size = axis_label_font_size, family = "Tahoma", face = "bold",
                                    margin = margin(t = 0, r = 0, b = 20, l = 0)),
          text = element_text(size = axis_label_font_size, colour="Black"),
          axis.text.x = element_text(colour = "black", angle = 45, hjust = 1),
          axis.text.y = element_text(colour = "black"),
          axis.title = element_text(face="bold"),
          axis.line = element_line(colour = "black"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.title.y = element_text(size = axis_label_font_size, margin = margin(t = 0, r = 20, b = 0, l = 0)),
          axis.title.x = element_text(size = axis_label_font_size, margin = margin(t = 20, r = 0, b = 0, l = 0)),
          panel.border = element_rect(colour = "black", fill=NA, size=2))
