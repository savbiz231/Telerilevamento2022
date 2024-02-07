# R code variability
setwd("C:/lab/")
library(raster)
library(ggplot2)
library(RStoolbox)
library(viridisLite)
library(patchwork)

#import the Simulaun image
sen <- brick ("sentinel.png")
sen

#plot the image by the ggRGB function
ggRGB (sen, r =3, g = 2, b = 1, stretch = "lin")

# hence:
ggRGB (sen, r =2, g = 1, b = 3)

#plot the two graphs one beside the other
g1 <- ggRGB (sen, 1, 2, 3)
g2 <- ggRGB (sen, 2, 1, 3)
g1+g2

#calculation of variability over NIR
nir <- sen[[1]]
sd3 <- focal(nir,matrix(1/9, 3, 3), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #))
plot(sd3, col=clsd)

#plotting with ggplot
ggplot() + geom_raster(sd3, mapping = aes (x=x, y=y, fill=layer))

#plotting with viridis
ggplot() + geom_raster(sd3, mapping = aes (x=x, y=y, fill=layer))
+ scale_fill_viridis() + ggtitle("standard deviation by viridis")

#cividis
ggplot() + geom_raster(sd3, mapping = aes (x=x, y=y, fill=layer))
+ scale_fill_viridis(option = "cividis") + ggtitle("standard deviation by viridis")

#magma
ggplot() + geom_raster(sd3, mapping = aes (x=x, y=y, fill=layer))
+ scale_fill_viridis(option = "magma") + ggtitle("standard deviation by viridis")

#Make the same calculation with a 7x7 window
sd7 <- focal(nir,matrix(1/49, 7, 7), fun=sd)
