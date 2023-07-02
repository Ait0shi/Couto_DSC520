# Assignment Week4_02
# Couto, Maria
# 07/01/2023

setwd("C:/Users/ait0s/OneDrive/Documents/Github/dsc520/data")

# Load Housing Dataset
library(readxl)
housedf <- read_excel("week-6-housing.xlsx")

# Use the apply function on a variable in your dataset
library(plyr)
library(dplyr)

apply(housedf,2,length)

# Use the aggregate function on a variable in your dataset

housedf <- housedf %>% rename_at(1,~'sale_date')
housedf <- housedf %>% rename_at(2,~'sale_price')

aggregate(sale_price~ctyname,housedf,mean)
aggregate(sale_price~ctyname + bedrooms, housedf, median)
aggregate(sale_price~year_built,housedf,median)

distinct(housedf,ctyname)

# Use the plyr function on a variable in your dataset – 
# more specifically, I want to see you split some data, 
# perform a modification to the data, and then bring it back together

distinct(housedf,ctyname)

housedf_v2 <-mutate(housedf,ctyname = if_else(is.na(ctyname),
                                              "City_Unkown",ctyname))
distinct(housedf_v2,ctyname)

housedf_v2 <- mutate(housedf_v2,Price_per_sqft = 
                       sale_price/square_feet_total_living)
colnames(housedf_v2)

# Check distributions of the data
library(ggplot2)
theme_set(theme_minimal())

aggregate(Price_per_sqft~ctyname,housedf_v2,median)

ggplot(housedf_v2, aes(Price_per_sqft)) + 
  geom_histogram(bins = 100,color = "black", fill = "yellow") +
  ggtitle("Housing Data") + 
  labs(x ="Price Per Square Feet", y="Count of Homes Sold")

# Identify if there are any outliers

ggplot(housedf_v2, aes(x=sale_price,y=square_feet_total_living,
                       colour=ctyname)) +
  geom_point(size = 2) +
  xlab("Sales Price")

# Create at least 2 new variables
# Variable/column 1 (Property_Size)
housedf_v2 <- mutate(housedf_v2,Property_size = 
                       cut(sq_ft_lot,
                       breaks = c(0,10000,50000,Inf),
                       labels = c("Small","Medium","Large"),
                                                    right = FALSE))
colnames(housedf_v2)
distinct(housedf_v2,Property_size)
housedf_v2 %>% select(ctyname,sq_ft_lot,Property_size)

# Variable/Column 2

housedf_v2 <- mutate(housedf_v2, Price_Range = 
                       cut(sale_price,
                           breaks = c(0,300000,600000,Inf),
                           labels = c("Low_Priced","Medium_Priced",
                                      "High_Priced"),right = FALSE))
colnames(housedf_v2)
distinct(housedf_v2,Price_Range)
housedf_v2 %>% select(ctyname,sq_ft_lot,Property_size,Price_Range)

