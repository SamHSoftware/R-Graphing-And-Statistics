# README for package: box-plot

## Author details: 
Name: Sam Huguet  
E-mail: samhuguet1@gmail.com
Date created: 12<sup>th</sup> December 2020

## Description: 
- This package was originally designed to handle data relevant to my PhD, but it can be easily repurposed to handle other data. 
- The R code allows a user to plot a bar graph from three different data sets, here provided by three seperate .csv files. Usually, R will plot from an individual .csv file with grouping variables, but the design of my MATLAB/Python experimental pipeline means that three files are outputted and analysed. 

## How to use the R code: 

(1) Open the ```box-plot.R``` script. 

(2) Load in the necessary packages. Here, we use ggplot2, ggsignif and grid. 
```
# PREAMBLE: LOAD IN NECESSARY PACKAGES______________________________________________________________________________ 
  library(ggplot2)
  library(ggsignif)
  library(grid)
```
(3) Next, we sequentially load in the .csv files. This is explained within the code itself, but you will see a number of file selection GUIs appear, looking like this: 

<img src="https://github.com/SamHSoftware/R-Graphing-And-Statistics/blob/master/box-plot/img/File%20selection.PNG?raw=true" alt="File selection GUI" width="500"/>  

This is achieved using the following code: 
```
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
```

(4) There's now a step which is needed so that you can control the order in which conditions appear within the graph. Notice that in the previous code block, the conditions are manually labelled as 'Control', 'Solvent Control' and 'Drug'. Now, with this piece of code, you can manually order the conditions as you choose: 
```
# ORDER THE CONDITIONS MANUALLY____________________________________________________________________________
  df$Condition <- factor(df$Condition, levels = c("Control", "Solvent Control", "Drug"))
```

(5) The rest of the code is designed to calculate levels of statistical significance between conditions, and to plot the graph itself. Here's an example of  the ouput. 

<img src="https://github.com/SamHSoftware/R-Graphing-And-Statistics/blob/master/box-plot/img/Example_box_plot.png?raw=true" alt="The bar graph" width="500"/>  