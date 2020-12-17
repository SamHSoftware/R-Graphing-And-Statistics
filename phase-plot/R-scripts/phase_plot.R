# This script is designed to create a graph representing phase differences 
# between control, solvent control and treatment conditions.

# It is designed to handle data from three separate .csv files. Normally, R
# handles data from individual .csv files. Here, three files are used as a
# reflection of my PhD image analysis pipeline, however, this can be easily 
# modified if needs be. 

# Author: Sam Huguet  
# E-mail: samhuguet1@gmail.com  
# Date created: 13th December 2020

# PREAMBLE: LOAD IN NECESSARY PACKAGES_____________________________________________________________
  library(ggplot2)
  library(grid)
  library(kuiper.2samp)

# LOAD CONTROL DATA SET______________________________________________________________________________ 
  datatable1 = file.choose()
  df1 = read.csv(datatable1)
  df1 <- df1[,16] # Select period 1 column.
  df1 <- as.data.frame(df1) # Convert the matrix to a data frame.
  colnames(df1)[1] <- "Phase" # Rename the column. 
  df1$Control <- 'Control'
  
# LOAD SOLVENT CONTROL DATA SET______________________________________________________________________________ 
  datatable2 = file.choose()
  df2 = read.csv(datatable2)
  df2 <- df2[,16] # Select period 1 column.
  df2 <- as.data.frame(df2) # Convert the matrix to a data frame.
  colnames(df2)[1] <- "Phase" # Rename the column. 
  df2$Control <- 'Solvent Control'
  
# LOAD TEST CONDITION DATA SET______________________________________________________________________________ 
  datatable3 = file.choose()
  df3 = read.csv(datatable3)
  df3 <- df3[,16] # Select period 1 column.
  df3 <- as.data.frame(df3) # Convert the matrix to a data frame.
  colnames(df3)[1] <- "Phase" # Rename the column. 
  df3$Control <- 'Dexamethasone'

# VERTICALLY CONCATENATE ALL THE DATA SETS_________________________________________________________________
  df <- rbind(df1, df2, df3)
  colnames(df)[2] <- "Condition" # Rename the column. 

# ORDER THE CONDITIONS MANUALLY____________________________________________________________________________
  df$Condition <- factor(df$Condition, levels = c("Control", "Solvent Control", "Dexamethasone"))
  
  
# PLOT THE DATA____________________________________________________________________________________________
  
  grob <- grobTree(textGrob("Mann-Whitney U test", x=0.54,  y=0.95, hjust=0,
                            gp=gpar(col="black", fontsize=15, fontface="italic")))
  
  xlabel <- paste('Cell cycle wave phase',expression(pi), sep = " ", collapse = NULL)
  textsize <- 25

  
  ggplot()+ 
    geom_histogram(data=df, 
                   aes(x=Phase, fill=Condition, group=Condition, y=..density..), # ..ncount.. normalises highest peak of each group to 1.
                                                                                 # ..density.. BEST METHOD: ensure that the area under each histogram is equal beterrn groups. 
                   alpha = 0.8,
                   binwidth=1,
                   position="dodge",
                   color="grey40", size = 0.2,
                   breaks=seq(-1, 1, by = 0.1))+
    coord_polar()+
    ylab("Phase density")+
    xlab(expression(paste("Cell cycle wave phases (", pi, ")")))+
    scale_x_continuous(breaks = c(seq(-0.8, 1, by=0.2)),
                       expand = c(.002,0))+
    scale_y_continuous(breaks = c(seq(0, 6, by=1)))+ # x labels.
    geom_hline(yintercept = c(seq(0, 6, by = 1)), # circular lines.
               colour = "black", alpha=0.2, size = 0.2) +
    theme_bw()+
    theme(text = element_text(size = textsize, colour="Black"),
          axis.text = element_text(colour = "black"),
          axis.text.x = element_text(hjust = 1),
          axis.line = element_line(colour = "black"),
          panel.grid.major.y  = element_blank(),
          axis.title.y = element_text(size = textsize, margin = margin(t = 0, r = 20, b = 0, l = 0)),
          axis.title.x = element_text(size = textsize, margin = margin(t = 10, r = 0, b = 0, l = 0)),
          panel.border = element_rect(colour = "black", fill=NA, size=2),
          axis.line.x.bottom  = element_line(colour = "grey90"))

 # Perform statistical analysis: Kuiper test. 
  df1 = read.csv(datatable1)
  df1 <- df1[,16] # Select period 1 column.
  
  df2 = read.csv(datatable2)
  df2 <- df2[,16] # Select period 1 column.
  
  df3 = read.csv(datatable3)
  df3 <- df3[,16] # Select period 1 column.
  
  #-----------------------------> Untreated v Solvent control
  kuiper.2samp(df1,df2)
  #-----------------------------> Untreated v Drug
  kuiper.2samp(df1,df3)
  #-----------------------------> Solvent control v Drug
  kuiper.2samp(df2,df3)

  print(length(df1))
  print(length(df2))
  print(length(df3))
