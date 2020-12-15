# This script is designed to create a scatter plot with separate bounds representing 
# confidence intervals and the standard deviation from the mean. This script would 
# work well for the plotting of time series data. 

# It is designed to handle data from an individual .csv file, the first column of 
# which should be the dependent variable, while the second column should be the 
# independent variable. 

# Author: Sam Huguet  
# E-mail: samhuguet1@gmail.com  
# Date created: 13th December 2020

# PREAMBLE: LOAD IN NECESSARY PACKAGES_____________________________________________________________
  library(ggplot2)
  library(Rmisc)

# LOAD THE DATA SET______________________________________________________________________________ 
  
  # Viewing a file of our choice. 
  datatable = file.choose()
  df1 = read.csv(datatable)
  
  #Dependent variable: First column. 
  #Independent variable: Second column. 
  names(df1)[1] <- "Dependent"
  names(df1)[2] <- "Independent"

# GENERATE THE 95% CONFIDENCE INTERVALS____________________________________________________________
  
  # Calculating the mean red ratios and the confidence intervals (ci) of the 95 percentile. 
  df1_Errors <- summarySE(df1, measurevar="Independent", groupvars = c("Dependent"))
  
  # Generate the data for the upper and lower confidence intervals. 
  df1_Errors$lowerBound_ci <- (df1_Errors$Independent - df1_Errors$ci)
  df1_Errors$upperBound_ci <- (df1_Errors$Independent + df1_Errors$ci)
  
# GENERATE THE UPPER AND LOWER BOUNDS OF STANDARD DEVIATION FROM THE MEAN_________________________
  
  df1_Errors$lowerBound_sd <- (df1_Errors$Independent - df1_Errors$sd)
  df1_Errors$upperBound_sd <- (df1_Errors$Independent + df1_Errors$sd)

# PLOT THE DATA____________________________________________________________________________________
  ggplot() + 
    geom_point(data=df1, 
               aes(x=Dependent, y=Independent),
               size = 1.5, 
               color='grey60')+
    geom_line(data=df1_Errors, 
              aes(x=Dependent, y=Independent, colour="black"), 
              size = 1,
              color='black')+
    geom_ribbon(data=df1_Errors, 
                aes(x=Dependent, ymin=lowerBound_ci, ymax=upperBound_ci), 
                alpha=0.2, 
                fill="black")+
    geom_ribbon(data=df1_Errors, 
                aes(x=Dependent, ymin=lowerBound_sd, ymax=upperBound_sd), 
                alpha=0.2, 
                fill="red")+
    ylab("Independent vairable")+
    xlab("Dependent variable")+
    ggtitle('Title')+
    scale_x_continuous(limits = c(1, 4), breaks = c(seq(0, 4, by=1)))+
    scale_y_continuous(limits = c(1,4))+
    theme_bw()+
    theme(plot.title = element_text(size = 22, family = "Tahoma", face = "bold",
                                    margin = margin(t = 0, r = 0, b = 20, l = 0)),
          text = element_text(size = 28, colour="Black"),
          axis.text = element_text(colour = "black"),
          axis.title = element_text(face="bold"),
          axis.line = element_line(colour = "black"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.title.y = element_text(size = 22, margin = margin(t = 0, r = 20, b = 0, l = 0)),
          axis.title.x = element_text(size = 22, margin = margin(t = 10, r = 0, b = 0, l = 0)),
          panel.border = element_rect(colour = "black", fill=NA, size=2))+
    scale_color_identity(guide = "legend")+
    scale_color_identity(name = "Treatment Condition",
                         breaks = c("blue", "green3", "red"),
                         labels = c("Untreated Control", "Solvent Control", "Peptide 5 Treatment"),
                         guide = "legend")
  
  
