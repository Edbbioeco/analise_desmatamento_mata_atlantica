# Pacotes ----

library(sf)

library(tidyverse)

# Dados ----

## importando ----

des_gpk <- sf::st_read("prodes_mata_atlantica_nb.gpkg")

## Visualizando ----

des_gpk

ggplot() +
  geom_sf(data = des_gpk) +
  theme_minimal()