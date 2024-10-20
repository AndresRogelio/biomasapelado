## ------------------------------------------------------------------------------
setwd("E:/carbono")
getwd()
# Cargar el paquete de ForestGEO (CTFS).
attach("CTFSRPackage.rdata")
# Ver los paquetes cargados 
search()
## ------------------------------------------------------------------------------
# Cargar los conjuntos de datos
# hay argumentos dentro de las funciones
# los ajusta según la necesidad

# Cerro Pelado 1 -----------------------
cp1stem <- read.csv("cp1stem.csv")
View(cp1stem) # ver los datos
cp1stem <- cp1stem[ ,1:19]

cp1tree <- read.csv("cp1tree.csv")
cp1tree <- cp1tree[ ,1:19]

# Cerro Pelado 2
cp2stem <- read.csv("cp2stem.csv")
cp2stem <- cp2stem[ ,1:19]

cp2tree <- read.csv("cp2tree.csv")
cp2tree <- cp2tree[ ,1:19]

# Cerro Pelado 3
cp3stem <- read.csv("cp3stem.csv")
cp3stem <- cp3stem[ ,1:19]

cp3tree <- read.csv("cp3tree.csv")
cp3tree <- cp3tree[ ,1:19]

## ------------------------------------------------------------------------------
# base de datos de densidad de madera de los árboles para Panamá
wsgpan <- read.csv("wsgpantree.csv")

## ------------------------------------------------------------------------------
ls() # me devuelve los objetos del ambiente de trabajo
# los nombres de las variables
# funciones colnames() o names()
colnames(cp1tree)
names(wsgpan)

## ------------------------------------------------------------------------------
# Obtengo los nombres únicos de las especies de árboles
# Creé un vector con los códigos de los nombres
x1 <- unique(cp1tree$sp)
# veo que es un vector
str(x1)
# lo convierto en "dataframe"
x1 <- data.frame(x1)
# reviso la estructura
str(x1)
# otra forma de revisar
head(x1, 10)
# cambiar el nombre de la variable a "sp"
colnames(x1) <- "sp"

# Obtener la densidad de madera para los árboles
# usa la función density.ind()

args(density.ind)
density.ind(df = x1, plot = "pantree", wsg = wsgpan)
dm <- density.ind(df = x1, plot = "pantree", wsg = wsgpan)
dm
# Unir los valores
spdm <- data.frame(x1, dm)
head(spdm)
# Ordenar por densidad de madera
spdm[order(dm, decreasing = TRUE), ]

spdm[order(dm, decreasing = T), ]

Rankspdm <- spdm[order(dm, decreasing = T), ]
head(Rankspdm,10)

## ------------------------------------------------------------------------------
apropos("biomass")

args(biomass.CTFSdb)

#censo1 la torre Cerro Pelado tabla stem
AGBstemcp1 <- biomass.CTFSdb(RStemTable = cp1stem,
RTreeTable = cp1tree,
whichtable="stem", plot = "pantree",
dbhunit = "mm", wsgdata = wsgpan, forest="moist")

bb <- round(sum(AGBstemcp1$agb, na.rm = TRUE), 1)
cat("Cantidad de biomasa en una parcela de una hectarea: ", bb, "Mg")

cat("Contenido de carbono (C): ", bb/2, "Mg.")

cat("Cantidad de CO2 eq: ", round((bb/2) * 3.6667,1), "Mg.")

options(max.print=99999)

sink("salidacp1.txt", split = TRUE)
AGBstemcp1[ ,c(3,5,6,11,19,20)]
sink()

help.search("write xlsx")

library(xlsx)

write.xlsx(AGBstemcp1, "resagb.xlsx")

## ------------------------------------------------------------------------------
#censo2 la torre Cerro Pelado tabla stem
AGBstemcp2 <- biomass.CTFSdb(RStemTable = cp2stem,
RTreeTable = cp2tree,
whichtable = "stem", plot = "pantree",
dbhunit = "mm",
wsgdata = wsgpan, forest = "moist")


## ------------------------------------------------------------------------------
#censo3 la torre Cerro Pelado tabla stem
AGBstemcp3 <- biomass.CTFSdb(RStemTable = cp3stem,
RTreeTable = cp3tree,
whichtable = "stem", plot = "pantree",
dbhunit = "mm",
wsgdata = wsgpan, forest = "moist")


## ------------------------------------------------------------------------------
str(AGBstemcp1)
head(AGBstemcp1)
head(AGBstemcp1[, c("sp", "dbh", "agb")],5)
head(AGBstemcp2[, c("sp", "dbh", "agb")],5)
head(AGBstemcp3[, c("sp", "dbh", "agb")],5)


## ------------------------------------------------------------------------------
AGBcp1 <- sum(AGBstemcp1$agb,na.rm=TRUE)
AGBcp2 <- sum(AGBstemcp2$agb,na.rm=TRUE)
AGBcp3 <- sum(AGBstemcp3$agb,na.rm=TRUE)
AGBcp1
AGBcp2
AGBcp3


## ------------------------------------------------------------------------------
table(subset(cp1stem, stemID == 1)$status)


## ------------------------------------------------------------------------------
table(subset(cp2stem, stemID == 1)$status)


## ------------------------------------------------------------------------------
table(subset(cp3stem, stemID == 1)$status)


## ------------------------------------------------------------------------------
cp1 <- aggregate(agb ~ sp, data = AGBstemcp1, FUN = sum, na.rm = TRUE)
cp2 <- aggregate(agb ~ sp, data = AGBstemcp2, FUN = sum, na.rm = TRUE)
cp3 <- aggregate(agb ~ sp, data = AGBstemcp3, FUN = sum, na.rm = TRUE)


## ------------------------------------------------------------------------------
Rankcp1 <- cp1[order(cp1$agb, decreasing = T), ]
Rankcp2 <- cp2[order(cp2$agb, decreasing = T), ]
Rankcp3 <- cp3[order(cp3$agb, decreasing = T), ]


## ------------------------------------------------------------------------------
top7_cp1 <- Rankcp1[1:7, ]
top7_cp2 <- Rankcp2[1:7, ]
top7_cp3 <- Rankcp3[1:7, ]
top7_cp3


## ------------------------------------------------------------------------------
par(las=2)
par(mfrow=c(1,3))
barplot(top7_cp1$agb, names.arg = top7_cp1$sp,
        ylim = c(0,70), main = "Censo 2008")
barplot(top7_cp2$agb, names.arg = top7_cp2$sp,
        ylim = c(0,70), main = "Censo 2012")
barplot(top7_cp3$agb, names.arg = top7_cp3$sp,
        ylim = c(0,70), main = "Censo 2015")

dev.off()

# Biomasa de árboles muertos, censo CP2
deadagb1 <- subset(AGBstemcp1, AGBstemcp1$status == "A" & AGBstemcp2$status == "D")
sum(deadagb1$agb, na.rm = T)

# Biomasa de árboles muertos, censo CP3
deadagb2 <- subset(AGBstemcp2, AGBstemcp2$status == "A" & AGBstemcp3$status == "D")
sum(deadagb2$agb, na.rm = T)

# Biomasa de los árboles reclutados, Censo CP2
reclutagb1 <- subset(AGBstemcp2, AGBstemcp1$status == "P" & AGBstemcp2$status == "A")
sum(reclutagb1$agb, na.rm = T)

reclutagb2 <- subset(AGBstemcp3, AGBstemcp2$status == "P" & AGBstemcp3$status == "A")
sum(reclutagb2$agb, na.rm = T)



library(plotrix)

sample_size <- c(193,-13.81,38.46,217.65)

totals <- c(TRUE,FALSE,FALSE,TRUE)

labels <- c("AGB 2008","AGB Árboles \n Muertos 2012",
"Crecimiento \n Bruto en AGB","AGB 2012")

staircase.plot(sample_size,totals, labels, cex = 0.7,
total.col = "gray", inc.col = 2:3, bg.col = "white", direction="s")


library(date)
date1 <- mean(AGBstemcp1$date)
date2 <- mean(AGBstemcp2$date)
date3 <- mean(AGBstemcp3$date)
t1 <- (date2-date1)/365.25
t2 <- (date3-date1)/365.25
t1
t2

# Crecimiento Neto Anual Promedio en AGB
(AGBcp2-AGBcp1)/t1

# Incremento Neto Anual Promedio de Carbono Nuevo en AGB
((AGBcp2-AGBcp1)/t1)*0.5

# Tasa de eliminación de CO2 de la atmósfera por el Crecimiento Neto en la AGB
(((AGBcp2-AGBcp1)/t1)*0.5)*3.667


## ------------------------------------------------------------------------------
sessionInfo()

