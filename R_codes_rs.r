# Questo è il primo script che useremo a lezione di Telerilevamento Geo-Ecologico A.A.2021/2022

# install.packages("raster")
library(raster)

#occorre ricaricare i dati ogni volta con un comando, settaggio cartella di lavoro
setwd("C:/Users/xave9/Desktop/Università/Magistrale/Corsi/Telerilevamento geo-ecologico/lab")

# funzioni per importare dati raster
brick("p224r63_2011.gdr")
l2011 <- brick("p224r63_2011.grd")
l2011
plot(l2011)
#creo una palette personalizzata, e le assegno un nome - riflettanze più basse sono scure e viceversa
colorRampPalette(c("black","grey","light grey")) (100)
# 100 indica il "passo" dei dati all'interno della matrice
cl <- colorRampPalette(c("black","grey","light grey")) (100)
plot(l2011, col=cl)
