# PREAMBLE: LOAD IN NECESSARY PACKAGES_____________________________________________________________
  library(ggplot2)
  library(ggsignif)
  library(grid)

# LOAD CONTROL DATA SET______________________________________________________________________________ 
  datatable1 = file.choose()
  df1 = read.csv(datatable1)
  df1 <- df1[,6] # Select period 1 column.
  df1 <- as.data.frame(df1) # Convert the matrix to a data frame.
  colnames(df1)[1] <- "Period" # Rename the column. 
  df1$Control <- 'Control'
  
# LOAD SOLVENT CONTROL DATA SET______________________________________________________________________________ 
  datatable2 = file.choose()
  df2 = read.csv(datatable2)
  df2 <- df2[,6] # Select period 1 column.
  df2 <- as.data.frame(df2) # Convert the matrix to a data frame.
  colnames(df2)[1] <- "Period" # Rename the column. 
  df2$Control <- 'Solvent Control'
  
# LOAD TEST CONDITION DATA SET______________________________________________________________________________ 
  datatable3 = file.choose()
  df3 = read.csv(datatable3)
  df3 <- df3[,6] # Select period 1 column.
  df3 <- as.data.frame(df3) # Convert the matrix to a data frame.
  colnames(df3)[1] <- "Period" # Rename the column. 
  df3$Control <- 'Drug'

# VERTICALLY CONCATENATE ALL THE DATA SETS_________________________________________________________________
  df <- rbind(df1, df2, df3)
  colnames(df)[2] <- "Condition" # Rename the column. 

# ORDER THE CONDITIONS MANUALLY____________________________________________________________________________
  df$Condition <- factor(df$Condition, levels = c("Control", "Solvent Control", "Drug"))
  
# CALCULATE SIGNIFICANCE WITH MAN WHITNEY U TEST___________________________________________________________
  
  p1 <- wilcox.test(df1[,1], df2[,1])
  p1 <- p1$p.value
  p1 <- format(round(p1, 3), nsmall = 3)
  CvSC <- paste ("p = ", p1, sep = " ", collapse = NULL)
  
  p1 <- wilcox.test(df2[,1], df3[,1])
  p1 <- p1$p.value
  p1 <- format(round(p1, 3), nsmall = 3)
  SCvDT <- paste ("p = ", p1, sep = " ", collapse = NULL)
  
  p1 <- wilcox.test(df1[,1], df3[,1])
  p1 <- p1$p.value
  p1 <- format(round(p1, 3), nsmall = 3)
  C_DT <- paste ("p = ", p1, sep = " ", collapse = NULL)
  
# PLOT THE DATA____________________________________________________________________________________________
  
  grob <- grobTree(textGrob("Mann-Whitney U test", x=0.54,  y=0.95, hjust=0,
                            gp=gpar(col="black", fontsize=15, fontface="italic")))
  
  
  ggplot(df, aes(Condition, Period)) + 
    geom_boxplot(aes(fill=Condition))+
    geom_signif(y_position = c(25, 25, 28), 
                xmin = c(1, 2.01, 1), 
                xmax = c(1.99, 3, 3), 
                annotation = c(CvSC, SCvDT, C_DT),
                tip_length = 0.01, 
                textsize = 6, 
                vjust = -0.2)+
    ylab("Y variable
(unit)")+
    xlab("Experimental condition")+
    scale_y_continuous(limits = c(5,32))+
    annotation_custom(grob)+
    theme_bw()+
    theme(plot.title = element_text(size = 18, 
                                    family = "Tahoma", 
                                    face = "bold",
                                    margin = margin(t = 0, r = 0, b = 20, l = 0)),
          text = element_text(size = 28, colour="Black"),
          axis.text = element_text(colour = "black"),
          axis.text.x = element_text(angle = 20, hjust = 1),
          axis.title = element_text(face="bold"),
          axis.line = element_line(colour = "black"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.title.y = element_text(size = 22, margin = margin(t = 0, r = 20, b = 0, l = 0)),
          axis.title.x = element_text(size = 22, margin = margin(t = 10, r = 0, b = 0, l = 0)),
          panel.border = element_rect(colour = "black", fill=NA, size=2))+
    scale_color_identity(guide = "legend")
  

