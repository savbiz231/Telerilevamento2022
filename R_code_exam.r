#Hello! this is the script for my R project
#we are going to see how the area around of Alqueva Dam (Portugal) changed from 1999 to 2022
#using NDVI products

#Data from: https://earthexplorer.usgs.gov/
#Project key points:
# 1.Import of Landsat 7 ETM+ and 8 OLI images
# 2.Changing of vegetation and NDVI values in the area of Alqueva Dam in Portugal

library(raster) 
setwd("C:/Users/xave9/Desktop/FilePC/Università/Lauree/Magistrale/Primo anno/Corsi/Telerilevamento geo-ecologico/Esame/immagini_landsat/2013")
library(raster)    #analyzing and modeling of spatial data
library(RStoolbox) #toolbox for remote sensing image processing 
library(ggplot2)   #for creating graphics
library(patchwork) #combine separate ggplots into the same graphic
#install.packages("viridis")
library(viridis)   #color scales

#1. Landsat7_1999: Natural color (RGB: bands 3,2,1)
setwd("C:/Users/xave9/Desktop/FilePC/Università/Lauree/Magistrale/Primo anno/Corsi/Telerilevamento geo-ecologico/Esame/immagini_landsat/1999")
#creation of three different rasters with three different bands:
blue_1999 = raster("LE07_L2SP_203033_19990818_20211204_02_T1_SR_B1.TIF")
green_1999 = raster("LE07_L2SP_203033_19990818_20211204_02_T1_SR_B2.TIF")
red_1999 = raster("LE07_L2SP_203033_19990818_20211204_02_T1_SR_B3.TIF")
# combination of the three rasters into a single raster
rgb_1999 = stack(red_1999, green_1999, blue_1999)
plotRGB(rgb_1999, scale=65535) #"scale" define the maximum possible value in the three channels
#plotting of RGB combinations with stretching of the values to increase the contrast between elements in the image
plotRGB(rgb_1999, stretch="lin") # linear streching
plotRGB(rgb_1999, stretch="hist") # Histogram equalization
#rgb_1999 Caracteristics of the image
#hist(rgb_1999) #histogram of the values of the image

#Landsat7_1999: cropping of the area around the dam
boundary_1999 = raster(ymx=4315000, xmn=600000, ymn=4100000, xmx=697500) #defining of the area's edges
champaign_1999 = crop(rgb_1999, boundary_1999)
plotRGB(champaign_1999, stretch="lin", main="RGB_1999") # linear streching
plotRGB(champaign_1999, stretch="hist", main="RGB_1999") # Histogram equalization

#Landsat7_1999: NDVI
red_1999 = raster("LE07_L2SP_203033_19990818_20211204_02_T1_SR_B3.TIF")
near.infrared_1999 = raster("LE07_L2SP_203033_19990818_20211204_02_T1_SR_B4.TIF")
# calculation of the spectral index NDVI
ndvi_1999= (near.infrared_1999 - red_1999) / (near.infrared_1999 + red_1999)
ndvi_cropped_1999= crop(ndvi_1999, boundary_1999)
colors = colorRampPalette(c("red3", "white", "darkcyan"))(255)
plot(ndvi_cropped_1999, zlim=c(-0.5, 1), col=cl, main="NDVI_1999")

#Landsat7_1999: ColorInfrared
Infrared_1999= stack(near.infrared_1999, red_1999, green_1999)
Infrared_cropped_1999= crop(Infrared_1999, boundary_1999)
plotRGB(Infrared_cropped_1999, stretch="lin")

#2. Landsat7_2002: Natural color (RGB: bands 3,2,1)
setwd("C:/Users/xave9/Desktop/FilePC/Università/Lauree/Magistrale/Primo anno/Corsi/Telerilevamento geo-ecologico/Esame/immagini_landsat/2002")
#creation of three different rasters with three different bands:
blue_2002 = raster("LE07_L2SP_203033_20020725_20211129_02_T1_SR_B1.TIF")
green_2002 = raster("LE07_L2SP_203033_20020725_20211129_02_T1_SR_B2.TIF")
red_2002 = raster("LE07_L2SP_203033_20020725_20211129_02_T1_SR_B3.TIF")
# combination of the three rasters into a single raster
rgb_2002 = stack(red_2002, green_2002, blue_2002)
plotRGB(rgb_2002, scale=65535) #"scale" define the maximum possible value in the three channels
#plotting of RGB combinations with stretching of the values to increase the contrast between elements in the image
plotRGB(rgb_2002, stretch="lin") # linear streching
plotRGB(rgb_2002, stretch="hist") # Histogram equalization
#rgb_2002 Caracteristics of the image 
#hist(rgb_2002) #histogram of the values of the image

#Landsat7_2002: cropping of the area around the dam
boundary_2002 = raster(ymx=4315000, xmn=600000, ymn=4100000, xmx=697500) #defining of the area's edges
champaign_2002 = crop(rgb_2002, boundary_2002)
plotRGB(champaign_2002, stretch="lin", main="RGB_2002") # linear streching
plotRGB(champaign_2002, stretch="hist", main="RGB_2002") # Histogram equalization

#Landsat7_2002: NDVI
red_2002 = raster("LE07_L2SP_203033_20020725_20211129_02_T1_SR_B3.TIF")
near.infrared_2002 = raster("LE07_L2SP_203033_20020725_20211129_02_T1_SR_B4.TIF")
# calculation of the spectral index NDVI
ndvi_2002 = (near.infrared_2002 - red_2002) / (near.infrared_2002 + red_2002)
ndvi_cropped_2002 = crop(ndvi_2002, boundary_2002)
colors = colorRampPalette(c("red3", "white", "darkcyan"))(255)
plot(ndvi_cropped_2002, zlim=c(-0.5, 1), col=colors, main="NDVI_2002")

#Landsat7_2002: ColorInfrared
Infrared_2002= stack(near.infrared_2002, red_2002, green_2002)
Infrared_cropped_2002= crop(Infrared_2002, boundary_2002)
plotRGB(Infrared_cropped_2002, stretch="lin")

#3. Landsat8_2013: Natural color (RGB: bands 4,3,2)
setwd("C:/Users/xave9/Desktop/FilePC/Università/Lauree/Magistrale/Primo anno/Corsi/Telerilevamento geo-ecologico/Esame/immagini_landsat/2013")
#creation of three different rasters with three different bands:
blue_2013 = raster("LC08_L2SP_203033_20130512_20200912_02_T1_SR_B2.TIF")
green_2013 = raster("LC08_L2SP_203033_20130512_20200912_02_T1_SR_B3.TIF")
red_2013 = raster("LC08_L2SP_203033_20130512_20200912_02_T1_SR_B4.TIF")
# combination of the three rasters into a single raster
rgb_2013 = stack(red_2013, green_2013, blue_2013)
plotRGB(rgb_2013, scale=65535) #"scale" define the maximum possible value in the three channels
#plotting of RGB combinations with stretching of the values to increase the contrast between elements in the image
plotRGB(rgb_2013, stretch="lin") # linear streching
plotRGB(rgb_2013, stretch="hist") # Histogram equalization
#rgb_2013 Caracteristics of the image
#hist(rgb_2013) #histogram of the values of the image

#Landsat8_2013: cropping of the area around the dam
boundary_2013 = raster(ymx=4315000, xmn=600000, ymn=4100000, xmx=697500) #defining of the area's edges
champaign_2013 = crop(rgb_2013, boundary_2013)
plotRGB(champaign_2013, scale=65535) #"scale" define the maximum possible value in the three channels
plotRGB(champaign_2013, stretch="lin", main="RGB_2013") # linear streching
plotRGB(champaign_2013, stretch="hist", main="RGB_2013") # Histogram equalization

#Landsat8_2013: NDVI
red_2013 = raster("LC08_L2SP_203033_20130512_20200912_02_T1_SR_B4.TIF")
near.infrared_2013 = raster("LC08_L2SP_203033_20130512_20200912_02_T1_SR_B5.TIF")
# calculation of the spectral index NDVI
ndvi_2013 = (near.infrared_2013 - red_2013) / (near.infrared_2013 + red_2013)
ndvi_cropped_2013 = crop(ndvi_2013, boundary_2013)
colors = colorRampPalette(c("red3", "white", "darkcyan"))(255)
plot(ndvi_cropped_2013, zlim=c(-0.5, 1), col=colors, main="NDVI_2013")

#Landsat8_2013: ColorInfrared
Infrared_2013= stack(near.infrared_2013, red_2013, green_2013)
Infrared_cropped_2013= crop(Infrared_2013, boundary_2013)
plotRGB(Infrared_cropped_2013, stretch="lin")

#4. Landsat8_2018: Natural color (RGB: bands 4,3,2)
setwd("C:/Users/xave9/Desktop/FilePC/Università/Lauree/Magistrale/Primo anno/Corsi/Telerilevamento geo-ecologico/Esame/immagini_landsat/2018")
#creation of three different rasters with three different bands:
blue_2018 = raster("LC08_L2SP_203033_20180219_20200902_02_T1_SR_B2.TIF")
green_2018 = raster("LC08_L2SP_203033_20180219_20200902_02_T1_SR_B3.TIF")
red_2018 = raster("LC08_L2SP_203033_20180219_20200902_02_T1_SR_B4.TIF")
# combination of the three rasters into a single raster
rgb_2018 = stack(red_2018, green_2018, blue_2018)
plotRGB(rgb_2018, scale=65535) #"scale" define the maximum possible value in the three channels
#plotting of RGB combinations with stretching of the values to increase the contrast between elements in the image
plotRGB(rgb_2018, stretch="lin", main="RGB_2018") # linear streching
plotRGB(rgb_2018, stretch="hist", main="RGB_2018") # Histogram equalization
#rgb_2018 Caracteristics of the image
#hist(rgb_2018) #histogram of the values of the image

#Landsat8_2018: cropping of the area around the dam
boundary_2018 = raster(ymx=4315000, xmn=600000, ymn=4100000, xmx=697500) #defining of the area's edges
champaign_2018 = crop(rgb_2018, boundary_2018)
plotRGB(champaign_2018, scale=65535) #"scale" define the maximum possible value in the three channels
plotRGB(champaign_2018, stretch="lin") # linear streching
plotRGB(champaign_2018, stretch="hist") # Histogram equalization

#Landsat8_2018: NDVI
red_2018 = raster("LC08_L2SP_203033_20180219_20200902_02_T1_SR_B4.TIF")
near.infrared_2018 = raster("LC08_L2SP_203033_20180219_20200902_02_T1_SR_B5.TIF")
# calculation of the spectral index NDVI
ndvi_2018 = (near.infrared_2018 - red_2018) / (near.infrared_2018 + red_2018)
ndvi_cropped_2018 = crop(ndvi_2018, boundary_2018)
colors = colorRampPalette(c("red3", "white", "darkcyan"))(255)
plot(ndvi_cropped_2018, zlim=c(-0.5, 1), col=colors, main="NDVI_2018")

#Landsat8_2018: ColorInfrared
Infrared_2018= stack(near.infrared_2018, red_2018, green_2018)
Infrared_cropped_2018= crop(Infrared_2018, boundary_2018)
plotRGB(Infrared_cropped_2018, stretch="lin")

#5. Landsat8_2022: Natural color (RGB: bands 4,3,2)
setwd("C:/Users/xave9/Desktop/FilePC/Università/Lauree/Magistrale/Primo anno/Corsi/Telerilevamento geo-ecologico/Esame/immagini_landsat/2022")
#creation of three different rasters with three different bands:
blue_2022 = raster("LC08_L2SP_203033_20221012_20221020_02_T1_SR_B2.TIF")
green_2022 = raster("LC08_L2SP_203033_20221012_20221020_02_T1_SR_B3.TIF")
red_2022 = raster("LC08_L2SP_203033_20221012_20221020_02_T1_SR_B4.TIF")
# combination of the three rasters into a single raster
rgb_2022 = stack(red_2022, green_2022, blue_2022)
plotRGB(rgb_2022, scale=65535) #"scale" define the maximum possible value in the three channels
#plotting of RGB combinations with stretching of the values to increase the contrast between elements in the image
plotRGB(rgb_2022, stretch="lin") # linear streching
plotRGB(rgb_2022, stretch="hist") # Histogram equalization
#rgb_2022 Caracteristics of the image
#hist(rgb_2022) #histogram of the values of the image

#Landsat8_2022: cropping of the area around the dam
boundary_2022 = raster(ymx=4315000, xmn=600000, ymn=4100000, xmx=697500) #defining of the area's edges
champaign_2022 = crop(rgb_2022, boundary_2022)
plotRGB(champaign_2022, stretch="lin", main="RGB_2022") # linear streching
plotRGB(champaign_2022, stretch="hist", main="RGB_2022") # Histogram equalization

#Landsat8_2022: NDVI
red_2022 = raster("LC08_L2SP_203033_20221012_20221020_02_T1_SR_B4.TIF")
near.infrared_2022 = raster("LC08_L2SP_203033_20221012_20221020_02_T1_SR_B5.TIF")
# calculation of the spectral index NDVI
ndvi_2022 = (near.infrared_2022 - red_2022) / (near.infrared_2022 + red_2022)
ndvi_cropped_2022 = crop(ndvi_2022, boundary_2022)
colors = colorRampPalette(c("red3", "white", "darkcyan"))(255)
plot(ndvi_cropped_2022, zlim=c(-0.5, 1), col=colors, main="NDVI_2022")

#Landsat8_2022: ColorInfrared
Infrared_2022= stack(near.infrared_2022, red_2022, green_2022)
Infrared_cropped_2022= crop(Infrared_2022, boundary_2022)
plotRGB(Infrared_cropped_2022, stretch="lin")

#plots of all RGB images
par(mfrow=c(2,3))
RGB_land7_1999<-plotRGB(champaign_1999, stretch="lin", main="RGB_1999") # linear streching
RGB_land7_2002<-plotRGB(champaign_2002, stretch="lin", main="RGB_2002") # linear streching
RGB_land8_2013<-plotRGB(champaign_2013, stretch="lin", main="RGB_2013") # linear streching
RGB_land8_2018<-plotRGB(champaign_2018, stretch="lin", main="RGB_2018") # linear streching
RGB_land8_2022<-plotRGB(champaign_2022, stretch="lin", main="RGB_2022") # linear streching
dev.off()

#plots of all NDVI images
par(mfrow=c(2,3))
NDVI_land7_1999<-plot(ndvi_cropped_1999, zlim=c(-0.5, 1), col=colors, main="NDVI_1999")
NDVI_land7_2002<-plot(ndvi_cropped_2002, zlim=c(-0.5, 1), col=colors, main="NDVI_2002")
NDVI_land8_2013<-plot(ndvi_cropped_2013, zlim=c(-0.5, 1), col=colors, main="NDVI_2013")
NDVI_land8_2018<-plot(ndvi_cropped_2018, zlim=c(-0.5, 1), col=colors, main="NDVI_2018")
NDVI_land8_2022<-plot(ndvi_cropped_2022, zlim=c(-0.5, 1), col=colors, main="NDVI_2022")
dev.off()

#plots of all ColorInfrared images
par(mfrow=c(2,3))
ColInfrared_land7_1999<-plotRGB(Infrared_cropped_1999, stretch="lin", main="ColorInfrared_1999") # linear streching
ColInfrared_land7_2002<-plotRGB(Infrared_cropped_2002, stretch="lin", main="ColorInfrared_2002") # linear streching
ColInfrared_land8_2013<-plotRGB(Infrared_cropped_2013, stretch="lin", main="ColorInfrared_2013") # linear streching
ColInfrared_land8_2018<-plotRGB(Infrared_cropped_2018, stretch="lin", main="ColorInfrared_2018") # linear streching
ColInfrared_land8_2022<-plotRGB(Infrared_cropped_2022, stretch="lin", main="ColorInfrared_2022") # linear streching
dev.off()

#Analysis the change of NDVI values (1999-2022)
ndvi_cropped_1999= crop(ndvi_1999, boundary_1999)
ndvi_cropped_2022 = crop(ndvi_2022, boundary_2022)
ndvi_differenceTOT = ndvi_cropped_2022 - ndvi_cropped_1999
colors = colorRampPalette(c("red3", "white", "darkcyan"))(255)
plot(ndvi_differenceTOT, col=colors, zlim=c(-1, 1))

#Analysis the change of NDVI values (1999-2002)
ndvi_cropped_1999= crop(ndvi_1999, boundary_1999)
ndvi_cropped_2002 = crop(ndvi_2002, boundary_2002)
ndvi_difference1 = ndvi_cropped_2002 - ndvi_cropped_1999
colors = colorRampPalette(c("red3", "white", "darkcyan"))(255)
plot(ndvi_difference1, col=colors, zlim=c(-1, 1))

#Analysis the change of NDVI values (2002-2013)
ndvi_cropped_2002= crop(ndvi_2002, boundary_2002)
ndvi_cropped_2013 = crop(ndvi_2013, boundary_2013)
ndvi_difference2 = ndvi_cropped_2013 - ndvi_cropped_2002
colors = colorRampPalette(c("red3", "white", "darkcyan"))(255)
plot(ndvi_difference2, col=colors, zlim=c(-1, 1))

#Analysis the change of NDVI values (2013-2018)
ndvi_cropped_2013= crop(ndvi_2013, boundary_2013)
ndvi_cropped_2018 = crop(ndvi_2018, boundary_2018)
ndvi_difference3 = ndvi_cropped_2018 - ndvi_cropped_2013
colors = colorRampPalette(c("red3", "white", "darkcyan"))(255)
plot(ndvi_difference3, col=colors, zlim=c(-1, 1))

#Analysis the change of NDVI values (2018-2022)
ndvi_cropped_2018= crop(ndvi_2018, boundary_2018)
ndvi_cropped_2022 = crop(ndvi_2022, boundary_2022)
ndvi_difference4 = ndvi_cropped_2022 - ndvi_cropped_2018
colors = colorRampPalette(c("red3", "white", "darkcyan"))(255)
plot(ndvi_difference4, col=colors, zlim=c(-1, 1))

summary(ndvi_cropped_2022)

#plots all the changes of NDVI values
par(mfrow=c(2,3))
DIFF_NDVI_TOT<-plot(ndvi_differenceTOT, zlim=c(-1, 1), col=colors, main="NDVI_difference: 1999-2022")
DIFF_NDVI_1<-plot(ndvi_difference1, zlim=c(-1, 1), col=colors, main="NDVI_difference: 1999-2002")
DIFF_NDVI_2<-plot(ndvi_difference2, zlim=c(-1, 1), col=colors, main="NDVI_difference: 2002-2013")
DIFF_NDVI_3<-plot(ndvi_difference3, zlim=c(-1, 1), col=colors, main="NDVI_difference: 2013-2018")
DIFF_NDVI_4<-plot(ndvi_difference4, zlim=c(-1, 1), col=colors, main="NDVI_difference: 2018-2022")
