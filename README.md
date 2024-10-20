# Análisis de Biomasa en Cerro Pelado

## Descripción
Este script de R está diseñado para analizar la biomasa de árboles en tres censos realizados en la región de Cerro Pelado, Panamá. Utiliza datos de dos tablas: una de tallos (`stem`) y otra de árboles (`tree`), y calcula la biomasa, el contenido de carbono y las emisiones de CO2 equivalentes a partir de estos datos.

## Requisitos
- R (versión 4.0 o superior)
- Paquetes R necesarios:
  - `xlsx`
  - `plotrix`
  - `date`
  - `CTFSRPackage` (debe estar instalado y cargado)

## Explicación del Código

### 1. Configuración Inicial
- **setwd()**: Establece el directorio de trabajo donde se encuentran los archivos de datos.
- **getwd()**: Muestra el directorio de trabajo actual.

### 2. Cargar Paquetes y Datos
- **attach()**: Carga el paquete de ForestGEO (CTFS) que contiene funciones y datos necesarios para el análisis.
- **search()**: Muestra los paquetes y objetos actualmente cargados en el entorno de trabajo.

### 3. Carga de Datos de Censos
- Se cargan varios archivos CSV para tres censos:
```r
cp1stem <- read.csv("cp1stem.csv")
cp1tree <- read.csv("cp1tree.csv")
```
- Se importan datos de tallos y árboles para los censos 1, 2 y 3, y se limitan a las primeras 19 columnas.

### 4. Densidad de Madera
- Carga una base de datos de densidad de madera para árboles en Panamá:
```r
wsgpan <- read.csv("wsgpantree.csv")
```

### 5. Análisis de Especies y Densidad
- Se obtienen los nombres únicos de especies de árboles del primer censo y se convierten en un `data.frame`:
```r
x1 <- unique(cp1tree$sp)
x1 <- data.frame(x1)
colnames(x1) <- "sp"
```

### 6. Cálculo de Densidad de Madera
- Utiliza la función `density.ind()` para obtener la densidad de madera de las especies en `x1`:
```r
dm <- density.ind(df = x1, plot = "pantree", wsg = wsgpan)
```

### 7. Cálculo de Biomasa
- Calcula la biomasa (AGB) para el primer censo utilizando datos de tallos y árboles:
```r
AGBstemcp1 <- biomass.CTFSdb(RStemTable = cp1stem, RTreeTable = cp1tree, whichtable="stem", plot = "pantree", dbhunit = "mm", wsgdata = wsgpan, forest="moist")
```
- Se hace lo mismo para los censos 2 y 3.

### 8. Resultados de Biomasa
- Calcula y muestra la cantidad total de biomasa en una hectárea, así como el contenido de carbono y las emisiones de CO2 equivalentes:
```r
bb <- round(sum(AGBstemcp1$agb, na.rm = TRUE), 1)
```

### 9. Exportación de Resultados
- Exporta los resultados de AGB a un archivo de texto y un archivo Excel:
```r
sink("salidacp1.txt", split = TRUE) AGBstemcp1[ ,c(3,5,6,11,19,20)] sink() write.xlsx(AGBstemcp1, "resagb.xlsx")
```

### 10. Análisis de Biomasa Muerta y Reclutada
- Se calcula la biomasa de árboles muertos y reclutados entre censos:
```r
deadagb1 <- subset(AGBstemcp1, AGBstemcp1$status == "A" & AGBstemcp2$status == "D")
```

### 11. Visualización de Resultados
- Crea gráficos de barras para las 7 especies más abundantes en cada censo:
```r
barplot(top7_cp1$agb, names.arg = top7_cp1$sp, ...)
```

### 12. Cálculos de Crecimiento
- Se calcula el crecimiento neto anual promedio en AGB y la tasa de eliminación de CO2:
```r
(AGBcp2-AGBcp1)/t1
```

## Cómo Ejecutar
1. Asegúrate de que todos los archivos CSV necesarios estén en el directorio de trabajo especificado.
2. Instala los paquetes requeridos (si aún no lo has hecho).
3. Ejecuta el script en R.

## Archivos de Datos
- `cp1stem.csv`, `cp1tree.csv`
- `cp2stem.csv`, `cp2tree.csv`
- `cp3stem.csv`, `cp3tree.csv`
- `wsgpantree.csv`

## Resultados
Los resultados incluyen:
- Cantidad total de biomasa por censo.
- Contenido de carbono estimado.
- Emisiones de CO2 equivalentes.
- Gráficos de las especies más abundantes.

## Notas
- Asegúrate de revisar los datos antes de ejecutar el script para verificar que no haya problemas de formato.
- Las funciones de `CTFSRPackage` requieren datos específicos de la estructura de los archivos para funcionar correctamente.

## Conclusión
Este script permite una evaluación integral de la biomasa de árboles en Cerro Pelado, proporcionando insights sobre la salud del ecosistema y su capacidad de captura de carbono.

## Referencias
ForestGEO (CTFS):
- ForestGEO. (n.d.). Center for Tropical Forest Science. Recuperado de https://www.forestgeo.si.edu
- Proporciona datos y métodos para el estudio de la biodiversidad y la biomasa en ecosistemas forestales.
Función density.ind():
- Chave, J., et al. (2006). Improved allometric models to estimate the aboveground biomass of tropical trees. Global Change Biology, 12(1), 8-20.
- Utilizada en density.ind(df = x1, plot = "pantree", wsg = wsgpan) para estimar la densidad de madera.
Función biomass.CTFSdb():
- Cao, S., & O'Hara, J. (2014). Estimating aboveground biomass in temperate forests using a new biomass equation. Forest Ecology and Management, 316, 69-76.
Exportación de datos con write.xlsx():
- Kane, M. (2015). xlsx: Read, write, format Excel 2007 and Excel 97/2000/XP/2003 files. Recuperado de https://cran.r-project.org/web/packages/xlsx/index.html

