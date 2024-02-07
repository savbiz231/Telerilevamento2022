#Questo è il primo script che useremo a lezione

#install.packages("raster")
library(raster)

#settaggio cartella
setwd("C:/lab/")

#import
l2011 <- brick("p224r63_2011.grd")
l2011

#plot function
plot(l2011)

#ColorRampPalette, decido una serie di colori e adatto un'immagine, ('c' indica una serie di dati)
cl <- colorRampPalette(c("black","grey","light grey")) (100)
plot(l2011, col=cl)

#landsat EMT+
#b1 = blue
#b2 = verde
#b3 = rosso
#b4 = infrarosso NIR

#plot della banda del blu - b1_sre
plot(l2011$B1_sre)

#plot 2
plot(l2011[[1]])
cl <- colorRampPalette(c("black","grey","light grey")) (100)
plot(l2011$B1_sre, col=cl)

#plot b1 from blue to blue to light blue
clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(l2011[[1]], col=clb)

# let's export the image and let iT appear in the lab folder
pdf("banda1.pdf")
plot(l2011[[1]], col=cl)
#dev.off() chiude i grafici appena aperti 
dev.off()

#png format
png("banda1.png")
plot(l2011[[1]], col=cl)
dev.off()

#plot b2 from dark green to green to light green
clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(l2011$B2_sre, col=clg)
dev.off()


#export multiframe
pdf("multiframe.pdf")
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=cl)
plot(l2011$B2_sre, col=clg)
dev.off()

#revert multiframe
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=cl)
plot(l2011$B2_sre, col=clg)
dev.off()

#plot first four bands
par(mfrow=c(2,2))
#blue
plot(l2011$B1_sre, col=cl)
#green
plot(l2011$B2_sre, col=clg)
#red
clr <- colorRampPalette(c("violet","red","pink")) (100)
plot(l2011$B3_sre, col=clr)
#NIR
clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(l2011$B4_sre, col=clnir)
dev.off()

setwd("C:/lab/")
library(raster)
l2011 <- brick("p224r63_2011.grd")
l2011
clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(l2011$B4_sre, col=clnir)

#DAY 3 plot RGB 
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="lin")
#stretch
plotRGB(l2011, r=4, g=3, b=2, stretch="hist")

#build a multiframe with visible RGB 
# (linear stretch) on top of false colors
# (histogram stretch)
par(mfrow=c(1,2))
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=3, g=4, b=1, stretch="hist")

#upload the image from 1988
l1988 <- brick("p224r63_1988.grd")
l1988
par(mfrow=c(1,2))
plotRGB(l1988, r=4, g=3, b=2, stretch="lin")
plotRGB(l1988, r=4, g=3, b=2, stretch="hist")
