library(raster)
setwd("C:/lab/")

#import the first file -> defor1_.jpg -> give it the name l1992

l1992 <- brick("defor1_.png")
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")

#import the second file and give it the name l2006
l2006 <- brick("defor2_.png")
l2006
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

#plot in multiframe the 2 images
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

#DVI Difference Vegetation Index
dvi1992 = l1992[[1]] - l1992[[2]]
dvi1992

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1992, col=cl)

dvi2006 = l2006[[1]] - l1992[[2]]
dvi2006

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2006, col=cl)
plot(dvi2006, col=cl)

#DVI difference in time 
dvi_dif = dvi1992 - dvi2006
cld <- colorRampPalette(c('blue','white','red'))(100) 
dev.off()

#Range NDVI (8 bit): -255 a 255
#Range NDVI (8 bit): -1 a 1
#Range DVI (16 bit): -65535 a 65535
#Range NDVI (16 bit): -1 a 1

library(raster)
setwd("C:/lab/")
l1992 <- brick("defor1_.png")
l2006 <- brick("defor2_.png")

#NDVI 1992
dvi1992 = l1992[[1]] - l1992[[2]]
ndvi1992= dvi1992 / (l1992[[1]] + l1992[[2]])
ndvi1992
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(ndvi1992, col=cl)

#multiframe plot RGB on top of the ndvi image
par(mfrow = c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plot(ndvi1992, col=cl)
plot(dvi_dif,col=cld)

#NDVI 2006
dvi2006 = l2006[[1]] - l2006[[2]]
ndvi2006 = dvi2006 / (l2006[[1]] + l2006[[2]])
ndvi2006
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(ndvi2006, col=cl)

# multiframe plot with NDI1992 on top of the NDVI2006 image
par(mfrow = c(2,1))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

#Automatic spectral indices 
install.packages("RStoolbox")
library(RStoolbox)
si1992 <- spectralIndices(l1992, green=3, red=2, nir=1)
plot(si1992, col=cl)

si2006 <- spectralIndices(l2006, green=3, red=2, nir=1)
plot(si2006, col=cl)

install.packages("rasterdiv")
library(rasterdiv)

### rasterdiv 
plot(copNDVI)
