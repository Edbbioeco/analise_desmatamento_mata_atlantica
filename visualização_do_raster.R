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
  scale_fill_viridis_c(option = "turbo",
                       na.value = NA)

# Carcateristicas do raster ----

## Resolução ----

des_tif |> terra::res()

## CRS ----

des_tif |> terra::crs()