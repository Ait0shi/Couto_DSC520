# Using either the same dataset(s) you used in the previous weeks’ 
# exercise or a brand-new dataset of your choosing, 
# perform the following transformations:

#load housing data
setwd("C:/Users/ait0s/OneDrive/Documents/GitHub/dsc520/data")
library("readxl")
wk_5_housingdf <-read_excel("week-7-housing.xlsx")
wk_5_housingdf

# Using the dplyr package, use the 6 different operations 
# to analyze/transform the data - 

library(dplyr)
wk_5_housingdf <- wk_5_housingdf %>% rename_at(1,~'sale_date')
wk_5_housingdf <- wk_5_housingdf %>% rename_at(2,~'sale_price')
wk_5_housingdf

# GroupBy

housing_group <-  wk_5_housingdf %>% group_by(year_built) %>%
  count(year_built)

housing_group


# Summarise Cases

housing_summary <- wk_5_housingdf %>% group_by(bedrooms) %>%
  summarise(total_amt = median(sale_price))
housing_summary

housing_summary2 <- summarise(wk_5_housingdf,
                              avg_size = mean(sq_ft_lot),
                              sd4price = sd(sale_price),
                              cheapest = min(sale_price),
                              priciest = max (sale_price))
                              

housing_summary2

# Mutate

housing_mutate <- mutate(wk_5_housingdf, 
                         price_per_sq_ft = sale_price/sq_ft_lot,
                         std_dv_price = sale_price - 
                           mean(sale_price)/sd(sale_price))

# select

housing_mutate %>% select(sale_price,sq_ft_lot,price_per_sq_ft,std_dv_price)

# Filter

housing_filter <- filter(wk_5_housingdf,bedrooms > 5)

housing_filter %>% select(sale_date,sale_price,bedrooms)

# Arrange

housing_arrange <- arrange(wk_5_housingdf,desc(sale_date),desc(year_built))
housing_arrange %>% select(sale_date,year_built,sale_price)

housing_arrange_by_group <- arrange(group_by(wk_5_housingdf,year_built),
                                    desc(sale_price),.by_group = T)
housing_arrange_by_group %>% select(year_built,sale_price)

# Using the purrr package – perform 2 functions on your dataset.  
# You could use zip_n, keep, discard, compact, etc.

library(tidyverse)
housing_map <- map(wk_5_housingdf,class)
housing_map

housing_map2 <- wk_5_housingdf %>% map_dbl(n_distinct)
housing_map2

housing_map3 <- wk_5_housingdf %>% map_df(~(data.frame(class = class(.x),
                                                    distinct = n_distinct(.x))),
                                          .id = "column_name")
housing_map3

# Use the cbind and rbind function on your dataset

housing_built_renov <- cbind(wk_5_housingdf$year_built,
                             wk_5_housingdf$year_renovated)
housing_built_renov <- as_tibble(housing_built_renov)
housing_built_renov

housing_rbind <-rbind(housing_map,housing_map2)
housing_rbind

# Split a string, then concatenate the results back together

housing_split <- wk_5_housingdf %>%
  separate(addr_full,c("add1","add2","add3","add4","add5","add6"))
housing_split

housing_split2 <-wk_5_housingdf %>%
  mutate(add_split = strsplit(addr_full," "))

housing_split2

housing_concat <- housing_split %>%
  mutate(addr_full = map(add1,add2,add3,add4,add5,add6,~str(.x,collapse = " ")))

housing_concat %>% select(sale_date,sale_price,addr_full)

housing_concat2 <- housing_split2 %>%
  mutate(addr_full2 = map(add_split, ~str_c(.x,collapse = " ")))

housing_concat2 %>% select(addr_full,addr_full2)
