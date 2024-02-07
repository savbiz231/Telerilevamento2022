setwd("C:/lab/")
library(raster)
library(RStoolbox)
library(ggplot2)
library(patchwork)
library(viridisLite)
#R code variability 2 - using PC components
 
sen <- brick("sentinel.png")
# NIR= band1
# red = band2 
# green = band3 

ggRGB(sen, r=1, g=2, b=3)
#visualize the image such as vegetation becomes
#green fluo

ggRGB(sen, 1, 2, 3)

#multivariate analysis
sen_pca <- rasterPCA(sen)

summary(sen_pca$model)

plot(sen_pca$map)

pc1 <- sen_pca$map$PC1
pc2 <- sen_pca$map$PC2
pc3 <- sen_pca$map$PC3

g1 <- ggplot() + 
  geom_raster(pc1, mapping=aes(x=x, y=y, fill=PC1))

g2 <- ggplot() + 
  geom_raster(pc2, mapping=aes(x=x, y=y, fill=PC2))

g3 <- ggplot() + 
  geom_raster(pc3, mapping=aes(x=x, y=y, fill=PC2))

g1+g2+g3

#standard deviation of PC1
sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
sd3

#map by ggplot the standard deviation of the first
#principal component

ggplot()+
  geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer))

#viridis

ggplot() + geom_raster(sd3, mapping = aes (x=x, y=y, fill=layer))
+ scale_fill_viridis(option= "cividis")

#images altogether

im1 <- ggRGB(sen, 2, 1, 3)

g1 <- ggplot() + 
  geom_raster(pc1, mapping=aes(x=x, y=y, fill=PC1))

im3 <- ggplot() + geom_raster(sd3, mapping = aes (x=x, y=y, fill=layer))
+ scale_fill_viridis(option= "cividis")

im1+g1+im3

#calculate heterogeneity in a 5x5 window
sd5 <- focal(pc1, matrix(1/25, 5, 5), fun=sd)

im4 <- ggplot() + geom_raster(sd5, mapping = aes (x=x, y=y, fill=layer))
+ scale_fill_viridis(option= "inferno")

im3+im4

sd5 <- focal(pc1, matrix(1/49, 7, 7), fun=sd
im5 <- ggplot() + geom_raster(sd7, mapping = aes (x=x, y=y, fill=layer))
+ scale_fill_viridis(option= "inferno")

im3+im4+im5
