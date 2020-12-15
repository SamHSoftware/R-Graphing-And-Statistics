# README for package: scatter-plot

## Author details: 
Name: Sam Huguet  
E-mail: samhuguet1@gmail.com  
Date created: 15<sup>th</sup> December 2020

## Description: 
- This package was originally designed to handle data relevant to my PhD, but it can be easily repurposed to handle other data. 
- The R code allows a user to plot a bar graph from three different data sets, here provided by an individual .csv file. 

## How to use the R code: 

(1) Open the ```scatter_plot.R``` script. 

(2) Load in the necessary packages. Here, we use ggplot2, and Rmisc.
```
# PREAMBLE: LOAD IN NECESSARY PACKAGES_________________________________________
  library(ggplot2)
  library(Rmisc)
```
(3) Next, we load in the .csv file. 

Unless you modify this script, your data will need to be composed of two columns. The first column must contain the dependent variable data. The second column must contain the independent variable data. 

[You can find the example data here](https://github.com/SamHSoftware/R-Graphing-And-Statistics/tree/master/scatter-plot/data).  

When the code is run...
```
# LOAD THE DATA SET____________________________________________________________
  # Viewing a file of our choice. 
  datatable = file.choose()
  df1 = read.csv(datatable)
  
  #Dependent variable: First column. 
  #Independent variable: Second column. 
  names(df1)[1] <- "Dependent"
  names(df1)[2] <- "Independent"
```
... you will see a file selection GUI apppear. With this, select you file for analysis.

<img src="https://github.com/SamHSoftware/R-Graphing-And-Statistics/blob/master/scatter-plot/img/File%20selection.PNG?raw=true" alt="File selection GUI" width="500"/>  

(4) The rest of the code is designed to calculate the upper and lower bounds of 95% confidence intervals and standard deviations, and to plot the graph itself. Within the plotting code, there are may parameters which you may need to change to optimise the graph's appearance. Here's an example of the ouput. 

<img src="https://github.com/SamHSoftware/R-Graphing-And-Statistics/blob/master/scatter-plot/img/scatter_plot.PNG?raw=true" alt="The scatter plot" width="500"/>  