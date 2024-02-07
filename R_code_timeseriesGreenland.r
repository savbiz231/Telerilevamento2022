#Time series analysis of Greenland LST data
setwd("C:/lab/greenland_data")
library(raster)

lst2000 <- raster("lst_2000.tif")
lst2000
plot(lst2000)

#import all the data 
lst2005 <- raster("lst_2005.tif")
lst2010 <- raster("lst_2010.tif")
lst2015 <- raster("lst_2015.tif")
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)

#multiframe of greenland data 

par(mfrow=c(2,2))
plot(lst2000, col=cl)
plot(lst2005, col=cl)
plot(lst2010, col=cl)
plot(lst2015, col=cl)

# import the whole set altogether

rlist <- list.files(pattern = "lst")
rlist

lapply(rlist, raster)
import <- lapply(rlist, raster)
tgr <- stack(import)

plot(tgr, col=cl)
plot(tgr[[1]], col=cl)

plotRGB(tgr, r=1, g=2, b=3, stretch="lin")


#time series of NO2 change in Europe during the lockdown
library(raster)
setwd("C:/lab/EN")

en01 <- raster("EN_0001.png")
en01
cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot(en01, col=cl)

en13 <- raster("EN_0013.png")
en13
plot(en13, col=cl)

#Let's import the whole set altogether

#Import the whole set as in the Greenland example 
# by the folloowing steps: 1. list.files, 2. lapply, 3. stack

#1 List the files in a directory/folder
rlist <- list.files(pattern = "EN")
rlist

#2 Apply a Function over a list of rasters
lapply(rlist, raster)

rimp <- lapply(rlist, raster)
rimp

#3 Stack vectors from a data frame or list 
EN_stack <- stack(rimp)
EN_stack

cl <- colorRampPalette(c('red','orange','yellow'))(100) 

#plot everything
plot(EN_stack, col=cl)

# Plot EN01 besides EN13
par(mfrow=c(1,2))
plot(EN[[01]], col=cl)
plot(EN[[13]], col=cl)

#or
en113 <- stack(EN[[01]], EN[[13]])
plot(en113, col=cl)

#make the difference
difen <- EN[[01]] - EN[[13]]
cldif <- colorRampPalette(c('blue','white','red'))(100)
plot(difen,col=cldif)
# plotRGB of three files together
plotRGB(en, r=1, g=7, b=13, stretch="lin")
plotRGB(en, r=1, g=7, b=13, stretch="hist")
