# This script is designed to create violin plots. 
# It is designed to handle data from three seperate .csv files, containing information regarding each condition.
# Normally, R handles one individual file. This alteration is due to the architecture of my experimental pipeline.
# However, this script can be easily modified to handle an individual .csv file. 

# Author: Sam Huguet  
# E-mail: samhuguet1@gmail.com  
# Date created: 13th December 2020

# PREAMBLE: LOAD IN NECESSARY PACKAGES_______________________________________________________________________
library(ggplot2)
library(ggsignif)
library(grid)

# LOAD CONTROL DATA SET_____________________________________________________________________________________
datatable1 = file.choose()
df1 = read.csv(datatable1)
df1 <- df1[,6] # Select period 1 column.
df1 <- as.data.frame(df1) # Convert the matrix to a data frame.
colnames(df1)[1] <- "Measurement" # Rename the column. 
df1$Condition <- 'Control'

# LOAD SOLVENT CONTROL DATA SET______________________________________________________________________________ 
datatable2 = file.choose()
df2 = read.csv(datatable2)
df2 <- df2[,6] # Select period 1 column.
df2 <- as.data.frame(df2) # Convert the matrix to a data frame.
colnames(df2)[1] <- "Measurement" # Rename the column. 
df2$Condition <- 'Solvent Control'

# LOAD TEST CONDITION DATA SET______________________________________________________________________________ 
datatable3 = file.choose()
df3 = read.csv(datatable3)
df3 <- df3[,6] # Select period 1 column.
df3 <- as.data.frame(df3) # Convert the matrix to a data frame.
colnames(df3)[1] <- "Measurement" # Rename the column. 
df3$Condition <- 'Drug'

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

axis_label_font_size = 20

ggplot(data=df, aes(x=Condition, y=Measurement))+
geom_violin(aes(fill=Condition), position=position_dodge(width = 1), draw_quantiles = c(0.25, 0.5, 0.75))+
  geom_jitter(width=0.1, height=0.5)+
  geom_signif(y_position = c(25, 25, 28), 
            xmin = c(1, 2.01, 1), 
            xmax = c(1.99, 3, 3), 
            annotation = c(CvSC, SCvDT, C_DT),
            tip_length = 0.01, 
            textsize = 5, 
            vjust = -0.2)+
  annotation_custom(grob)+
scale_y_continuous(limits = c(4, 32),
                   breaks = c(seq(5, 30, by=5)))+ 
ggtitle("Title")+
ylab("Measurement")+
xlab("Condition")+
theme_bw()+
theme(plot.title = element_text(size = axis_label_font_size, family = "Tahoma", face = "bold",
                                margin = margin(t = 0, r = 0, b = 20, l = 0)),
      text = element_text(size = axis_label_font_size, colour="Black"),
      axis.text.x = element_text(colour = "black", angle = 0, hjust = 0.5),
      axis.text.y = element_text(colour = "black"),
      axis.title = element_text(face="bold"),
      axis.line = element_line(colour = "black"),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.position = "none",
      axis.title.y = element_text(size = axis_label_font_size, margin = margin(t = 0, r = 20, b = 0, l = 0)),
      axis.title.x = element_text(size = axis_label_font_size, margin = margin(t = 20, r = 0, b = 0, l = 0)),
      panel.border = element_rect(colour = "black", fill=NA, size=2))

