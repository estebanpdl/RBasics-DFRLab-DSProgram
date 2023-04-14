# R Basics / DFRLab - Digitalsherlocks Program

Welcome to our R Basics workshop repository! This repository is part of DFRLab's digitalsherlocks program and is designed to help you get started with R programming. Here you'll find a collection of code snippets that cover the basics of reading datasets, scraping websites, and working with APIs using R.

<br />

## How to use this repository

To get started, clone or download the repository to your local machine. Then, navigate to the folder where you've saved the repository and open the code snippets in your preferred text editor or R environment (R Studio)

<br />

#### **You can also run this command using RStudio**
<br />

```R
usethis::use_course("https://github.com/estebanpdl/360-Digitalsherlocks-R-Basics/archive/refs/heads/main.zip")
```

*This command will open another RStudio instance with the materials.*

<br >

### We recommend following these steps:

1. Start with the "EX1-Twitterdataset" folder. This will help you to understand how to read in data from a CSV file.
2. Move on to the "Ex2-Rvest" folder to learn how to scrape data from a website.
3. Move on to the "Ex3-CrowdTangle" folder. This folder includes a code snippet to pull data from CrowdTangle's API.
4. Move on to the "Ex4-ReadJSONResponse" folder. This folder includes exercises on how to read a json file and convert data into a data frame.

<br />

**Feel free to modify and experiment with the code snippets as you see fit. Don't hesitate to ask questions and seek help in our DFRLab's digitalsherlocks community.***


<br />

## Requirements

To use these code snippets, you'll need to have R and RStudio installed on your computer.

#### Getting started with R and RStudio

<br />

To **install R**, visit [https://www.r-project.org/](https://www.r-project.org/) and follow the instructions. You will have to choose your preferred **CRAN Mirror** (*a network of ftp and web servers around the world that store identical, up-to-date, versions of code and documentation for R*). **Choose the closest location to you**.

After you download R, you may also want to visit [https://www.rstudio.com/products/rstudio/](https://www.rstudio.com/products/rstudio/) to download **RStudio Desktop**. RStudio is a free Integrated Development Environment (IDE) that provides a convenient user interface for the R language, which would otherwise require work using command line prompts. The interface allows you to view graphs, data, and R code all at the same time, organized in separate windows, and also provides drop-down menus for tasks for which you would otherwise have to use the command line to complete in R. For beginners (and more advanced users as well) **RStudio makes R significantly more user-friendly**.

You can also visit this [link](https://posit.co/download/rstudio-desktop/) and follow the instructions to get RStudio ready!


We also recommend installing the following R packages:

- `tidyverse`
- `rvest`
- `httr`

You can install these packages by running the following commands in your R console:

```
install.packages("tidyverse")
install.packages("rvest")
install.packages("httr")
```
