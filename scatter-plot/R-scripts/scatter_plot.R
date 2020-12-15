# PREAMBLE: LOAD IN NECESSARY PACKAGES_____________________________________________________________
  library(ggplot2)
  library(R)

# LOAD FIRST DATA SET______________________________________________________________________________ 
  #NB: in the example data set...
  #Dependant variable: First column. 
  #Independant variable: Second column. 
  
  # Viewing a file of our choice. 
  datatable = file.choose()
  df1 = read.csv(datatable)
  names(df1)[1] <- "dependant"
  names(df1)[2] <- "independant"

# GENERATE THE 95% CONFIDENCE INTERVALS____________________________________________________________
  # Calculating the mean red ratios and the confidence intervals (ci) of the 95 percentile. 
  df1_Errors <- summarySE(df1, measurevar="independant", groupvars = c("dependant"))
  
  # Generate the data for the upper and lower confidence intervals. 
  df1_Errors$lowerBound_ci <- (df1_Errors$independant - df1_Errors$ci)
  df1_Errors$upperBound_ci <- (df1_Errors$independant + df1_Errors$ci)
  
# GENERATE THE UPPER AND LOWER BOUNDS OF STANDARD DEVIATION FROM THE MEAN_________________________
  
  df1_Errors$lowerBound_sd <- (df1_Errors$independant - df1_Errors$sd)
  df1_Errors$upperBound_sd <- (df1_Errors$independant + df1_Errors$sd)

# PLOT THE DATA____________________________________________________________________________________
  ggplot() + 
    geom_point(data=df1, 
               aes(x=dependant, y=independant),
               size = 1.5, 
               color='grey60')+
    geom_line(data=df1_Errors, 
              aes(x=dependant, y=independant, colour="black"), 
              size = 1,
              color='black')+
    geom_ribbon(data=df1_Errors, 
                aes(x=dependant, ymin=lowerBound_ci, ymax=upperBound_ci), 
                alpha=0.2, 
                fill="black")+
    geom_ribbon(data=df1_Errors, 
                aes(x=dependant, ymin=lowerBound_sd, ymax=upperBound_sd), 
                alpha=0.2, 
                fill="red")+
    ylab("Randon forest assigned 
cell cycle wave grade")+
    xlab("Manually assigned cell cycle 
wave grade")+
    scale_x_continuous(limits = c(1, 4), breaks = c(seq(0, 4, by=1)))+
    scale_y_continuous(limits = c(1,4))+
    theme_bw()+
    theme(plot.title = element_text(size = 18, family = "Tahoma", face = "bold",
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
  
  
