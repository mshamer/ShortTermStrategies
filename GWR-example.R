# Example for GWR code


install.packages("GWmodel")   #for first time use only
library(GWmodel)              #obtain library

#basic model format
GWR.Fit <- gwr.basic(formula = PM25 ~ HPBL+RH+TEMP+WIND_SPEED+FOREST_COVER+MODIS_AOD, 
                     data = pm.data.frame)