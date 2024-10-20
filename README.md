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

## Estructura del Código

### 1. Configuración del Entorno
- Se establece el directorio de trabajo.
- Se carga el paquete de ForestGEO y los conjuntos de datos.

### 2. Carga de Datos
- Se importan datos de tallos y árboles para tres censos (Cerro Pelado 1, 2 y 3).
- Se carga una base de datos de densidad de madera para árboles en Panamá.

### 3. Análisis de Datos
- Se obtienen nombres únicos de especies de árboles y se calculan las densidades de madera.
- Se calcula la biomasa (AGB) usando la función `biomass.CTFSdb` para cada censo.
- Se generan resúmenes de biomasa, contenido de carbono y emisiones de CO2.

### 4. Visualización
- Se crean gráficos de barras para las 7 especies más abundantes en cada censo.
- Se realiza un análisis de la biomasa de árboles muertos y reclutados entre censos.

### 5. Cálculos Adicionales
- Se calcula el crecimiento neto anual promedio de AGB y la tasa de eliminación de CO2.

### 6. Salida de Datos
- Resultados de la biomasa se exportan a un archivo Excel (`resagb.xlsx`).
- Resultados de AGB se guardan en un archivo de texto (`salidacp1.txt`).

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
