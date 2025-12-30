# Pacotes ----

library(terra)

library(tidyverse)

library(tidyterra)

# Dados ----

## importando ----

des_tif <- terra::rast("prodes_mata_atlantica_2024.tif")

## Visualizando ----

des_tif

ggplot() +
  tidyterra::geom_spatraster(data = des_tif) +
  scale_fill_viridis_c(na.value = NA) +
  theme_minimal()

# Carcateristicas do raster ----

## Resolução ----

des_tif |> terra::res()

## Extensão ----

des_tif |> terra::ext()

## CRS ----

des_tif |> terra::crs()