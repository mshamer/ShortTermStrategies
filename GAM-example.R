#Example code for Geberalized Additive Models (GAM)

#libraries
library(mgcv)         #GAM
library(data.table)

database <- fread("PATH TO DATA FILE")        #Read file
database$Date <- as.Date(database$Date)       #change format of Date variable to 'Date'
database$month <- month(database$Date)        #Extract month from date
database$Julian_Day <- julian(database$Date)  #Extract julian day from date

## Run model----
#Examples of two different models

#Model 1
model.gam1 <-gam(PM25~s(AOD_550,        #GAM formula (Y~x1+x2...) with a smooth function on AOD_550 
                        k=15),          #the dimension of the basis used to represent the smooth term
               data=train,              #A data frame or list containing the model response variable and covariates required by the formula
               method="ML")             #Maximum Likelihood smoothin parameter estimation method

#Model 2
model.gam2 <-gam(PM25~s(AOD_550, k=15)+
                        t2(Julian_Day,month       #GAM with tensor product on month and julian day variables
                           k=c(5,10),d=c(2,1),    #The dimension(s) of the bases used to represent the smooth term 
                           bs=c("cr"),            #"cr" for cubic regression spline
                           full=TRUE),            #There is a separate penalty for each combination of null space column and range space. This gives strict invariance.
                      data=train,
                      method="ML")


#Extract fitted values ----

fitted.gam1 <- model.gam1$fitted.values
fitted.gam2 <- model.gam2$fitted.values

