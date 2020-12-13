# README for package: histogram

## Author details: 
Name: Sam Huguet  
E-mail: samhuguet1@gmail.com
Date created: 13<sup>th</sup> December 2020

## Description: 
- This package was originally designed to handle data relevant to my PhD, but it can be easily repurposed to handle other data. 
- The R code allows a user to plot a histogram from data held within a .csv files. 

## How to use the R code: 

(1) Open the ```create_histogram.R``` script. 

(2) Load in the necessary packages. Here, we use ggplot2, dplyr and grid. 
```
# Loading in the necessary packages_________________________________
  
  library(ggplot2)
  library(dplyr)
  library(grid)
```
(3) Next, we load in the .csv file. You will see a file selection GUI appear, looking like this: 

<img src="" alt="File selection GUI" width="500"/>  

Using the GUI, select the .csv file containing the individual column of data you wish to analyse. 

This is achieved using the following code: 
```
# Viewing a file of our choice______________________________________
  
  datatable = file.choose()
  df = read.csv(datatable)  # To view the data, paste 'View(df)' into the console. 
  column_Name = sample(colnames(df),1)
```

(4) Now, you may alter the variables which control the font size, the x and y axis limits and the size of the histogram bins. 
```
# Here are the variables to change__________________________________
  
  binWidth = 0.5
  axis_label_font_size = 25
  min_x = 1
  max_x = 5
  min_y = 0
  max_y = 30
```

(5) The rest of the code is designed to plot the histogram and display the n number associated with the dataset. You can see an example of the plot below: 

<img src="" alt="The histogram" width="500"/>  