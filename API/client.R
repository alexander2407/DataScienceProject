library(rjson)
library(httr)

# Item_Outlet_Sales needs to be set to avoid an error. Changing its value does not change the outcome of the predict function
test = data.frame(Item_Weight=9.300,
                  Item_Visibility=0.75,
                  Item_Type="Non-Vegan-Food",
                  Item_MRP=250,
                  Outlet_Establishment_Year=2000,
                  Outlet_Size="Medium",
                  Outlet_Location_Type="Tier 2",
                  Item_Fat_Content="Low Fat",
                  Outlet_Type="Supermarket Type1",
                  Item_Outlet_Sales=0)

str = toJSON(test)

content(POST("http://127.0.0.1:8080/sales",body = str,encode = "json"))
