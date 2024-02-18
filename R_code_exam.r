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

#1. Landsat7_1999: Natural color
setwd("C:/Users/xave9/Desktop/FilePC/Università/Lauree/Magistrale/Primo anno/Corsi/Telerilevamento geo-ecologico/Esame/immagini_landsat/1999")
blue_1999 = raster("LE07_L2SP_203033_19990818_20211204_02_T1_SR_B1.TIF")
green_1999 = raster("LE07_L2SP_203033_19990818_20211204_02_T1_SR_B2.TIF")
red_1999 = raster("LE07_L2SP_203033_19990818_20211204_02_T1_SR_B3.TIF")
rgb_1999 = stack(red_1999, green_1999, blue_1999)
plotRGB(rgb_1999, scale=65535)
plotRGB(rgb_1999, stretch="lin")
plotRGB(rgb_1999, stretch="hist")
#rgb_1999 Caracteristics of the image
#hist(rgb_1999)

#Landsat7_1999: cropping
boundary_1999 = raster(ymx=4315000, xmn=600000, ymn=4100000, xmx=697500)
champaign_1999 = crop(rgb_1999, boundary_1999)
#plotRGB(champaign_1999, scale=111703)
plotRGB(champaign_1999, stretch="lin", main="RGB_1999")
plotRGB(champaign_1999, stretch="hist", main="RGB_1999")

#Landsat7_1999: NDVI
red_1999 = raster("LE07_L2SP_203033_19990818_20211204_02_T1_SR_B3.TIF")
near.infrared_1999 = raster("LE07_L2SP_203033_19990818_20211204_02_T1_SR_B4.TIF")
ndvi_1999= (near.infrared_1999 - red_1999) / (near.infrared_1999 + red_1999)
ndvi_cropped_1999= crop(ndvi_1999, boundary_1999)
colors = colorRampPalette(c("red3", "white", "darkcyan"))(255)
plot(ndvi_cropped_1999, zlim=c(0, 0.6), col=colors, main="NDVI_1999")


#2. Landsat7_2002: Natural color
setwd("C:/Users/xave9/Desktop/FilePC/Università/Lauree/Magistrale/Primo anno/Corsi/Telerilevamento geo-ecologico/Esame/immagini_landsat/2002")
blue_2002 = raster("LE07_L2SP_203033_20020725_20211129_02_T1_SR_B1.TIF")
green_2002 = raster("LE07_L2SP_203033_20020725_20211129_02_T1_SR_B2.TIF")
red_2002 = raster("LE07_L2SP_203033_20020725_20211129_02_T1_SR_B3.TIF")
rgb_2002 = stack(red_2002, green_2002, blue_2002)
plotRGB(rgb_2002, scale=65535)
plotRGB(rgb_2002, stretch="lin")
plotRGB(rgb_2002, stretch="hist")
#rgb_2002 Caracteristics of the image

#Landsat7_2002: cropping
boundary_2002 = raster(ymx=4315000, xmn=600000, ymn=4100000, xmx=697500)
champaign_2002 = crop(rgb_2002, boundary_2002)
plotRGB(champaign_2002, stretch="lin", main="RGB_2002")
plotRGB(champaign_2002, stretch="hist", main="RGB_2002")

#Landsat7_2002: NDVI
red_2002 = raster("LE07_L2SP_203033_20020725_20211129_02_T1_SR_B3.TIF")
near.infrared_2002 = raster("LE07_L2SP_203033_20020725_20211129_02_T1_SR_B4.TIF")
ndvi_2002 = (near.infrared_2002 - red_2002) / (near.infrared_2002 + red_2002)
ndvi_cropped_2002 = crop(ndvi_2002, boundary_2002)
colors = colorRampPalette(c("red3", "white", "darkcyan"))(255)
plot(ndvi_cropped_2002, zlim=c(0, 0.6), col=colors, main="NDVI_2002")

#3. Landsat8_2013: Natural color
setwd("C:/Users/xave9/Desktop/FilePC/Università/Lauree/Magistrale/Primo anno/Corsi/Telerilevamento geo-ecologico/Esame/immagini_landsat/2013")
blue_2013 = raster("LC08_L2SP_203033_20130512_20200912_02_T1_SR_B2.TIF")
green_2013 = raster("LC08_L2SP_203033_20130512_20200912_02_T1_SR_B3.TIF")
red_2013 = raster("LC08_L2SP_203033_20130512_20200912_02_T1_SR_B4.TIF")
rgb_2013 = stack(red_2013, green_2013, blue_2013)
plotRGB(rgb_2013, scale=65535)
plotRGB(rgb_2013, stretch="lin")
plotRGB(rgb_2013, stretch="hist")
#rgb_2013 Caracteristics of the image

#Landsat8_2013: cropping
boundary_2013 = raster(ymx=4315000, xmn=600000, ymn=4100000, xmx=697500)
champaign_2013 = crop(rgb_2013, boundary_2013)
plotRGB(champaign_2013, scale=65535)
plotRGB(champaign_2013, stretch="lin", main="RGB_2013")
plotRGB(champaign_2013, stretch="hist", main="RGB_2013")

#Landsat8_2013: NDVI
red_2013 = raster("LC08_L2SP_203033_20130512_20200912_02_T1_SR_B4.TIF")
near.infrared_2013 = raster("LC08_L2SP_203033_20130512_20200912_02_T1_SR_B5.TIF")
ndvi_2013 = (near.infrared_2013 - red_2013) / (near.infrared_2013 + red_2013)
ndvi_cropped_2013 = crop(ndvi_2013, boundary_2013)
colors = colorRampPalette(c("red3", "white", "darkcyan"))(255)
plot(ndvi_cropped_2013, zlim=c(0, 0.6), col=colors, main="NDVI_2013")

#4. Landsat8_2018: Natural color
setwd("C:/Users/xave9/Desktop/FilePC/Università/Lauree/Magistrale/Primo anno/Corsi/Telerilevamento geo-ecologico/Esame/immagini_landsat/2018")
blue_2018 = raster("LC08_L2SP_203033_20180219_20200902_02_T1_SR_B2.TIF")
green_2018 = raster("LC08_L2SP_203033_20180219_20200902_02_T1_SR_B3.TIF")
red_2018 = raster("LC08_L2SP_203033_20180219_20200902_02_T1_SR_B4.TIF")
rgb_2018 = stack(red_2018, green_2018, blue_2018)
plotRGB(rgb_2018, scale=65535)
plotRGB(rgb_2018, stretch="lin", main="RGB_2018")
plotRGB(rgb_2018, stretch="hist", main="RGB_2018")
#rgb_2018 Caracteristics of the image

#Landsat8_2018: cropping
boundary_2018 = raster(ymx=4315000, xmn=600000, ymn=4100000, xmx=697500)
champaign_2018 = crop(rgb_2018, boundary_2018)
plotRGB(champaign_2018, scale=65535)
plotRGB(champaign_2018, stretch="lin")
plotRGB(champaign_2018, stretch="hist")

#Landsat8_2018: NDVI
red_2018 = raster("LC08_L2SP_203033_20180219_20200902_02_T1_SR_B4.TIF")
near.infrared_2018 = raster("LC08_L2SP_203033_20180219_20200902_02_T1_SR_B5.TIF")
ndvi_2018 = (near.infrared_2018 - red_2018) / (near.infrared_2018 + red_2018)
ndvi_cropped_2018 = crop(ndvi_2018, boundary_2018)
colors = colorRampPalette(c("red3", "white", "darkcyan"))(255)
plot(ndvi_cropped_2018, zlim=c(0, 0.6), col=colors, main="NDVI_2018")

#5. Landsat8_2022: Natural color
setwd("C:/Users/xave9/Desktop/FilePC/Università/Lauree/Magistrale/Primo anno/Corsi/Telerilevamento geo-ecologico/Esame/immagini_landsat/2022")
blue_2022 = raster("LC08_L2SP_203033_20221012_20221020_02_T1_SR_B2.TIF")
green_2022 = raster("LC08_L2SP_203033_20221012_20221020_02_T1_SR_B3.TIF")
red_2022 = raster("LC08_L2SP_203033_20221012_20221020_02_T1_SR_B4.TIF")
rgb_2022 = stack(red_2022, green_2022, blue_2022)
plotRGB(rgb_2022, scale=65535)
plotRGB(rgb_2022, stretch="lin")
plotRGB(rgb_2022, stretch="hist")
#rgb_2022 Caracteristics of the image

#Landsat8_2022: cropping
boundary_2022 = raster(ymx=4315000, xmn=600000, ymn=4100000, xmx=697500)
champaign_2022 = crop(rgb_2022, boundary_2022)
plotRGB(champaign_2022, stretch="lin", main="RGB_2022")
plotRGB(champaign_2022, stretch="hist", main="RGB_2022")

#Landsat8_2022: NDVI
red_2022 = raster("LC08_L2SP_203033_20221012_20221020_02_T1_SR_B4.TIF")
near.infrared_2022 = raster("LC08_L2SP_203033_20221012_20221020_02_T1_SR_B5.TIF")
ndvi_2022 = (near.infrared_2022 - red_2022) / (near.infrared_2022 + red_2022)
ndvi_cropped_2022 = crop(ndvi_2022, boundary_2022)
colors = colorRampPalette(c("red3", "white", "darkcyan"))(255)
plot(ndvi_cropped_2022, zlim=c(0, 0.6), col=colors, main="NDVI_2022")

#plots of all RGB images
par(mfrow=c(2,3))
RGB_land7_1999<-plotRGB(champaign_1999, stretch="lin", main="RGB_1999")
RGB_land7_2002<-plotRGB(champaign_2002, stretch="lin", main="RGB_2002")
RGB_land8_2013<-plotRGB(champaign_2013, stretch="lin", main="RGB_2013")
RGB_land8_2018<-plotRGB(champaign_2018, stretch="lin", main="RGB_2018")
RGB_land8_2022<-plotRGB(champaign_2022, stretch="lin", main="RGB_2022")
dev.off()

#plots of all NDVI images
par(mfrow=c(2,3))
NDVI_land7_1999<-plot(ndvi_cropped_1999, zlim=c(0, 0.6), col=colors, main="NDVI_1999")
NDVI_land7_2002<-plot(ndvi_cropped_2002, zlim=c(0, 0.6), col=colors, main="NDVI_2002")
NDVI_land8_2013<-plot(ndvi_cropped_2013, zlim=c(0, 0.6), col=colors, main="NDVI_2013")
NDVI_land8_2018<-plot(ndvi_cropped_2018, zlim=c(0, 0.6), col=colors, main="NDVI_2018")
NDVI_land8_2022<-plot(ndvi_cropped_2022, zlim=c(0, 0.6), col=colors, main="NDVI_2022")
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

#plots all the changes of NDVI values
par(mfrow=c(2,3))
DIFF_NDVI_TOT<-plot(ndvi_differenceTOT, zlim=c(-1, 1), col=colors, main="NDVI_difference: 1999-2022")
DIFF_NDVI_1<-plot(ndvi_difference1, zlim=c(-1, 1), col=colors, main="NDVI_difference: 1999-2002")
DIFF_NDVI_2<-plot(ndvi_difference2, zlim=c(-1, 1), col=colors, main="NDVI_difference: 2002-2013")
DIFF_NDVI_3<-plot(ndvi_difference3, zlim=c(-1, 1), col=colors, main="NDVI_difference: 2013-2018")
DIFF_NDVI_4<-plot(ndvi_difference4, zlim=c(-1, 1), col=colors, main="NDVI_difference: 2018-2022")
