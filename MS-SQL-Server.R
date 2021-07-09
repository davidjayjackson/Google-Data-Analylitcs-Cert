rm(list = ls())
### SQL Server Code

library(DBI)
library(odbc)
library(lubridate)
library(ggplot2)
library(scales)
library(dplyr)
library(tidyr)

## https://db.rstudio.com/databases/microsoft-sql-server/
con <- DBI::dbConnect(odbc::odbc(), 
                      Driver = "SQL Server", 
                      Server = "localhost\\SQLEXPRESS", 
                      Database = "google", 
                      Trusted_Connection = "True")

dbListTables(con)

### Import Products Data
products <- read.csv(file = "./Products.csv")
dbWriteTable(con, "P",products ,overwrite=TRUE)
dbListFields(con,"P")

### Import Inventory Data
inventory <- read.csv(file = "./Inventory.csv")
dbWriteTable(con, "I",inventory ,overwrite=TRUE)
dbListFields(con,"I")

### Import Sales Data
sales <- read.csv(file = "./Sales.csv")
sales$Date <- as.Date(sales$Date)
dbWriteTable(con, "S",sales ,overwrite=TRUE)
dbListFields(con,"S")

### Import Sales Summary Data

result <- read.csv(file = "./Results.csv")
dbWriteTable(con, "R",result ,overwrite=TRUE)
dbListFields(con,"R")

### List Tables

head(dbListTables(con),4)





dbDisconnect(con)





