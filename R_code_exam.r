#Hello! this is the script for my R project
#we are going to see how the area around of Alqueva Dam changed from 1999 to 2021
#and the volume of water stored after the construction of the dam

#Data from: https://earthobservatory.nasa.gov/images/149775/losing-a-long-watched-glacier
#Project key points:
# 1.principal components analysis calculation (pca) 
# 2.variability of vegetation and the espansion of the lake of Alqueva Dam
# 3.standard deviation calculation to show area with highest heterogeneity

#first things first
#set the working directory

setwd("C:/lab/telerilevamento_esame")

#import and install all the packaged needed for the project

library(raster)    #analyzing and modeling of spatial data
library(RStoolbox) #toolbox for remote sensing image processing 
library(ggplot2)   #for creating graphics
library(patchwork) #combine separate ggplots into the same graphic
install.packages("viridis")
library(viridis)   #color scales

#import the images of the area of Alqueva Dam in Portogallo

P1999 <- brick("peyto_etm_1999236_lrg.jpg")
P1999

#let's see the avaiable informations
#> P1999
#class      : RasterLayer 
#band       : 1  (of  3  bands)
#dimensions : 1446, 1571, 2271666  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 1571, 0, 1446  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : peyto_etm_1999236_lrg.jpg 
#names      : peyto_etm_1999236_lrg 
#values     : 0, 255  (min, max)

# image from 2021
P2021 <- brick("peyto_oli_2021224_lrg.jpg")
P2021

#let's see the avaiable informations
#> P2021
#class      : RasterLayer 
#band       : 1  (of  3  bands)
#dimensions : 1446, 1571, 2271666  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 1571, 0, 1446  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : peyto_oli_2021224_lrg.jpg 
#names      : peyto_oli_2021224_lrg 
#values     : 0, 255  (min, max)


# plotting the images with a color palette to have a first look 
cl <- colorRampPalette(c("#FFFFCC","#C7E9B4","#7FCDBB","#40B6C4","#2C7FB8" ,"#253494")) (100)
plot(P1999, col=cl, main="Peyto glacier 1999")
plot(P2021, col=cl, main="Peyto glacier 2021")
#to close the window
dev.off()

#save plots
jpeg("P1999_peyto.jpg", 900, 900)
plot(P1999, col=cl)
dev.off()

jpeg("P2021_peyto.jpg", 900, 900)
plot(P2021, col=cl, main="Peyto glacier 2021")
dev.off()

#multiframe of the images to visualize them both in the same plot 

cl <- colorRampPalette(c("#FFFFCC","#C7E9B4","#7FCDBB","#40B6C4","#2C7FB8" ,"#253494")) (100)
par(mfrow=c(1,2))
plot(P1999, main="Peyto glacier 1999")
plot(P2021, main="Peyto glacier 2021")
dev.off()

#visualize the images with RGB colors using ggRGB
# red = band1
# green = band2 
# blue= band3

g1 <- ggRGB (P1999, r =1, g = 2, b = 3, stretch = "lin")

g2 <- ggRGB (P2021, r =1, g = 2, b = 3, stretch = "lin")

#plot both in the same page 
g1+g2
dev.off()

#save plot
jpeg("g1+g2.jpg", 900, 900)
plot(g1+g2, col=cl, main="RGB")
dev.off()

#######Principal component analysis to extract data with many variables
#and create visualizations to display that data (PCA) for 1999 image#######
P1999_pca <- rasterPCA(P1999)

#Visualize the importance of components 
summary(P1999_pca$model)

#Importance of components:
                          #Comp.1      Comp.2      Comp.3
#Standard deviation     112.849604 15.52086859 3.920285709
#Proportion of Variance   0.980274  0.01854298 0.001182995
#Cumulative Proportion    0.980274  0.99881701 1.000000000

#plot a pca map (the PC1 component has 98,02% of variance)
plot(P1999_pca$map)
dev.off()

#assign a name for all the pca components
pc1_1999 <- P1999_pca$map$PC1
pc2_1999 <- P1999_pca$map$PC2
pc3_1999 <- P1999_pca$map$PC3

#plot of the components with viridis 
g1 <- ggplot() + 
  geom_raster(P1999_pca$map, mapping=aes(x=x, y=y, fill=PC1)) + 
  scale_fill_viridis(option = "mako") +
  ggtitle("PC1")


g2 <- ggplot() + 
  geom_raster(P1999_pca$map, mapping=aes(x=x, y=y, fill=PC2)) + 
  scale_fill_viridis(option = "mako") +
  ggtitle("PC2")

g3 <- ggplot() + 
  geom_raster(P1999_pca$map, mapping=aes(x=x, y=y, fill=PC3)) + 
  scale_fill_viridis(option = "mako") +
  ggtitle("PC3")

#all the components in the same plot 
g1+g2+g3
dev.off()

#save plot
jpeg("PC_1999.jpg", 900, 300)
plot(g1+g2+g3, col=cl, main="Principal component analysis")
dev.off()

#Principal component analysis to extract data with many 
#variables and create visualizations to display that data (PCA)
#for 2021 image 
P2021_pca <- rasterPCA(P2021)

#Visualize the importance of components 
summary(P2021_pca$model)
#Importance of components:
                         #Comp.1      Comp.2      Comp.3
#Standard deviation     95.1994343 16.48198595 3.859144962
#Proportion of Variance  0.9693514  0.02905572 0.001592923
#Cumulative Proportion   0.9693514  0.99840708 1.000000000

#plot a pca map (the PC1 component has 96,93% of variance)
plot(P2021_pca$map)
dev.off()
#assign a name for all the pca components
pc1_2021 <- P2021_pca$map$PC1
pc2_2021 <- P2021_pca$map$PC2
pc3_2021 <- P2021_pca$map$PC3

#plot of the components with viridis
im1 <- ggplot() + 
  geom_raster(P2021_pca$map, mapping=aes(x=x, y=y, fill=PC1)) + 
  scale_fill_viridis(option = "mako") +
  ggtitle("PC1")

im2 <- ggplot() + 
  geom_raster(P2021_pca$map, mapping=aes(x=x, y=y, fill=PC2)) + 
  scale_fill_viridis(option = "mako") +
  ggtitle("PC2")

im3 <- ggplot() + 
  geom_raster(P2021_pca$map, mapping=aes(x=x, y=y, fill=PC3)) + 
  scale_fill_viridis(option = "mako") +
  ggtitle("PC3")

#all the components in the same plot
im1+im2+im3
dev.off()

#save plot
jpeg("PC_2021.jpg", 900, 300)
plot(im1+im2+im3, col=cl, main="Principal component analysis")
dev.off()

#######calculate the difference between the first components#######
diff <- pc1_1999 - pc1_2021

#assign a color palette 
cl <- colorRampPalette(c("purple", "yellow","orange","red")) (100)
#plot the difference between the first and the second component
plot(diff, col=cl, main = "Ice mass variation")
dev.off()

#save plot
jpeg("difference.jpg", 900, 900)
plot(diff, col=cl, main="Difference")
dev.off()

########standard deviation of the difference####### 
#calculate heterogeneity in a 3x3 window for more definition
sd3 <- focal(diff, matrix(1/9, 3, 3), fun=sd)
sd3

#plot a map so we can see all the areas with the highest heterogeneity
cl <- colorRampPalette(c("magenta", "yellow", "green", "blue")) (100)
plot(sd3, col=cl, main = "Standard deviation")
dev.off()

#save plot
jpeg("sd3.jpg", 900, 900)
plot(sd3, col=cl, main="Standard deviation")
dev.off()
