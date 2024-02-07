# R code for multivariate analysis
library(raster)
library(RStoolbox)
library(ggplot2)
library(patchwork)
library(viridis)
setwd("C:/lab/")

p224r63_2011 <- brick("p224r63_2011_masked.grd")

plot(p224r63_2011)

p224r63_2011

plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)
plot(p224r63_2011$B2_sre, p224r63_2011$B1_sre, col="red", pch=19, cex=2)

pairs(p224r63_2011)

# aggregate cells: resampling (ricampionamento)
p224r63_2011res <- aggregate(p224r63_2011, fact=10)

g1 <- ggRGB(p224r63_2011, 4,3,2)
g2 <- ggRGB(p224r63_2011res, 4,3,2)

g1+g2

# aggressive resampling 
p224r63_2011res100 <- aggregate(p224r63_2011, fact=100)

g1 <- ggRGB(p224r63_2011, 4,3,2)
g2 <- ggRGB(p224r63_2011res, 4,3,2)
g3 <- ggRGB(p224r63_2011res100, 4,3,2)

g1+g2+g3

# PCA analysis
p224r63_2011respca <- rasterPCA(p224r63_2011res)

# $call
# $model
# $map

summary(p224r63_2011respca$model)

plot(p224r63_2011respca$map)

g1 <- ggplot() + 
geom_raster(p224r63_2011respca$map, mapping=aes(x=x, y=y, fill=PC1)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("PC1")

g2 <- ggplot() + 
geom_raster(p224r63_2011respca$map, mapping=aes(x=x, y=y, fill=PC7)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("PC7")

g1+g2

g3 <- ggplot() + 
geom_raster(p224r63_2011res, mapping=aes(x=x, y=y, fill=B4_sre)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("NIR")

g1+g3

g4 <- ggRGB(p224r63_2011, 2, 3, 4, stretch="hist")

g1+g4

plotRGB(p224r63_2011respca$map, 1, 2, 3, stretch="lin")
plotRGB(p224r63_2011respca$map, 5, 6, 7, stretch="lin")
