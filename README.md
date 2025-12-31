# Analise de desmatamento da Mata Atlântica

> Análise geoespacial do desmatamento da Mata Atlântica, segundo dados
> do [Terrabrasilis](https://terrabrasilis.dpi.inpe.br/downloads/)

# Pacotes

``` r
library(geobr)

library(tidyverse)

library(magrittr)

library(sf)

library(terra)

library(tidyterra)
```

# Dados

## Shapefile da Mata Atlântica

### Importando

``` r
ma <- geobr::read_biomes(year = 2019) |> 
  dplyr::filter(name_biome == "Mata Atlântica")
```

    ## Using year/date 2019

### Visualizando

``` r
ma
```

    ## Simple feature collection with 1 feature and 3 fields
    ## Geometry type: MULTIPOLYGON
    ## Dimension:     XY
    ## Bounding box:  xmin: -55.33475 ymin: -29.98127 xmax: -28.84785 ymax: 0.9178799
    ## Geodetic CRS:  SIRGAS 2000
    ##       name_biome code_biome year                           geom
    ## 1 Mata Atlântica          4 2019 MULTIPOLYGON (((-48.70814 -...

``` r
ggplot() +
  geom_sf(data = ma, color = "darkgreen", fill = "forestgreen", alpha = 0.3)
```

![](README_files/figure-gfm/unnamed-chunk-73-1.png)<!-- -->

## Shapefile dos estados do Mata Atlântica

### Importando

``` r
estados <- geobr::read_state(year = 2019)
```

    ## Using year/date 2019

### Visualizando

``` r
estados
```

    ## Simple feature collection with 27 features and 5 fields
    ## Geometry type: MULTIPOLYGON
    ## Dimension:     XY
    ## Bounding box:  xmin: -73.99045 ymin: -33.75118 xmax: -28.84784 ymax: 5.271841
    ## Geodetic CRS:  SIRGAS 2000
    ## First 10 features:
    ##    code_state abbrev_state name_state code_region name_region
    ## 1          11           RO   Rondônia           1       Norte
    ## 2          12           AC       Acre           1       Norte
    ## 3          13           AM   Amazônas           1       Norte
    ## 4          14           RR    Roraima           1       Norte
    ## 5          15           PA       Pará           1       Norte
    ## 6          16           AP      Amapá           1       Norte
    ## 7          17           TO  Tocantins           1       Norte
    ## 8          21           MA   Maranhão           2    Nordeste
    ## 9          22           PI      Piauí           2    Nordeste
    ## 10         23           CE      Ceará           2    Nordeste
    ##                              geom
    ## 1  MULTIPOLYGON (((-65.3815 -1...
    ## 2  MULTIPOLYGON (((-71.07772 -...
    ## 3  MULTIPOLYGON (((-69.83766 -...
    ## 4  MULTIPOLYGON (((-63.96008 2...
    ## 5  MULTIPOLYGON (((-51.43248 -...
    ## 6  MULTIPOLYGON (((-50.45011 2...
    ## 7  MULTIPOLYGON (((-48.23163 -...
    ## 8  MULTIPOLYGON (((-44.5383 -2...
    ## 9  MULTIPOLYGON (((-42.91539 -...
    ## 10 MULTIPOLYGON (((-41.18292 -...

``` r
ggplot() +
  geom_sf(data = estados, color = "darkgreen", fill = "forestgreen", alpha = 0.3)
```

![](README_files/figure-gfm/unnamed-chunk-75-1.png)<!-- -->

### Tratando

``` r
estados_ma <- estados |> 
  sf::st_intersection(ma)
```

    ## Warning: attribute variables are assumed to be spatially constant throughout all
    ## geometries

``` r
estados_ma
```

    ## Simple feature collection with 15 features and 8 fields
    ## Geometry type: GEOMETRY
    ## Dimension:     XY
    ## Bounding box:  xmin: -55.33475 ymin: -29.98127 xmax: -28.84824 ymax: -3.804938
    ## Geodetic CRS:  SIRGAS 2000
    ## First 10 features:
    ##    code_state abbrev_state          name_state code_region name_region
    ## 11         24           RN Rio Grande Do Norte           2    Nordeste
    ## 12         25           PB             Paraíba           2    Nordeste
    ## 13         26           PE          Pernambuco           2    Nordeste
    ## 14         27           AL             Alagoas           2    Nordeste
    ## 15         28           SE             Sergipe           2    Nordeste
    ## 16         29           BA               Bahia           2    Nordeste
    ## 17         31           MG        Minas Gerais           3     Sudeste
    ## 18         32           ES      Espírito Santo           3     Sudeste
    ## 19         33           RJ      Rio De Janeiro           3     Sudeste
    ## 20         35           SP           São Paulo           3     Sudeste
    ##        name_biome code_biome year                           geom
    ## 11 Mata Atlântica          4 2019 MULTIPOLYGON (((-35.23148 -...
    ## 12 Mata Atlântica          4 2019 MULTIPOLYGON (((-34.96617 -...
    ## 13 Mata Atlântica          4 2019 MULTIPOLYGON (((-32.39288 -...
    ## 14 Mata Atlântica          4 2019 MULTIPOLYGON (((-36.73955 -...
    ## 15 Mata Atlântica          4 2019 POLYGON ((-36.40824 -10.510...
    ## 16 Mata Atlântica          4 2019 MULTIPOLYGON (((-38.71065 -...
    ## 17 Mata Atlântica          4 2019 MULTIPOLYGON (((-51.00015 -...
    ## 18 Mata Atlântica          4 2019 MULTIPOLYGON (((-29.29958 -...
    ## 19 Mata Atlântica          4 2019 MULTIPOLYGON (((-41.82918 -...
    ## 20 Mata Atlântica          4 2019 MULTIPOLYGON (((-47.85009 -...

``` r
ggplot() +
  geom_sf(data = estados, color = "black") +
  geom_sf(data = estados_ma, color = "darkgreen", fill = "forestgreen", alpha = 0.3)
```

![](README_files/figure-gfm/unnamed-chunk-76-1.png)<!-- -->

## Shapefile das Unidades de Conservação na Mata Atlântica

### Importando

``` r
uc <- geobr::read_conservation_units()
```

    ## Using year/date 201909

### Visuslizando

``` r
uc
```

    ## Simple feature collection with 1934 features and 14 fields
    ## Geometry type: MULTIPOLYGON
    ## Dimension:     XY
    ## Bounding box:  xmin: -73.99068 ymin: -32.92342 xmax: -25.2909 ymax: 5.272257
    ## Geodetic CRS:  SIRGAS 2000
    ## First 10 features:
    ##    code_conservation_unit
    ## 1                    2350
    ## 2                    3787
    ## 3                    3445
    ## 4                     145
    ## 5                    1754
    ## 6                    2092
    ## 7                    3178
    ## 8                     821
    ## 9                    1879
    ## 10                   3471
    ##                                             name_conservation_unit id_wcm
    ## 1       RESERVA PARTICULAR DO PATRIMÔNIO NATURAL BUGIO E COMPANHIA   <NA>
    ## 2      AREA DE PROTECAO AMBIENTAL DA BACIA DO CORREGO CAPAO GRANDE   <NA>
    ## 3                   RESERVA PARTICULAR DO PATRIMÔNIO NATURAL PILAR   <NA>
    ## 4                             PARQUE NACIONAL DA SERRA DA CAPIVARA     64
    ## 5                                    FLORESTA ESTADUAL DO ARAGUAIA   <NA>
    ## 6  RESERVA PARTICULAR DO PATRIMÔNIO NATURAL DA CABECEIRA DO CAFÔFO   <NA>
    ## 7                                 PARQUE DISTRITAL SALTO DO TORORÓ   <NA>
    ## 8                                        ESTAÇÃO ECOLÓGICA ITABERÁ  81049
    ## 9                             ÀREA DE PROTEÇÃO AMBIENTAL DE TINGUÁ   <NA>
    ## 10             ÁREA DE RELEVANTE INTERESSE ECOLóGICO DO CITRóPOLIS   <NA>
    ##                                    category group government_level creation_year
    ## 1  Reserva Particular do Patrimônio Natural    US         estadual          2010
    ## 2                Área de Proteção Ambiental    US        municipal          2018
    ## 3  Reserva Particular do Patrimônio Natural    US         estadual          2013
    ## 4                                    Parque    PI          federal          1979
    ## 5                                  Floresta    US         estadual          2002
    ## 6  Reserva Particular do Patrimônio Natural    US          federal          2007
    ## 7                                    Parque    PI         estadual          2015
    ## 8                         Estação Ecológica    PI         estadual          1957
    ## 9                Área de Proteção Ambiental    US        municipal          2004
    ## 10    Área de Relevante Interesse Ecológico    US        municipal          2016
    ##     gid7
    ## 1   6101
    ## 2  15289
    ## 3  13500
    ## 4   6506
    ## 5   2983
    ## 6   9436
    ## 7  11660
    ## 8   2909
    ## 9   3619
    ## 10 13135
    ##                                                                             quality
    ## 1         Aproximado (O poligono representa uma estimativa dos limites da unidade).
    ## 2  Correto (O poligono corresponde ao memorial descritivo do ato legal de criação).
    ## 3  Correto (O poligono corresponde ao memorial descritivo do ato legal de criação).
    ## 4         Aproximado (O poligono representa uma estimativa dos limites da unidade).
    ## 5  Correto (O poligono corresponde ao memorial descritivo do ato legal de criação).
    ## 6  Correto (O poligono corresponde ao memorial descritivo do ato legal de criação).
    ## 7  Correto (O poligono corresponde ao memorial descritivo do ato legal de criação).
    ## 8         Aproximado (O poligono representa uma estimativa dos limites da unidade).
    ## 9  Correto (O poligono corresponde ao memorial descritivo do ato legal de criação).
    ## 10 Esquemático (O poligono é uma representação esquemática da dimensão da unidade).
    ##                               legislation dt_ultim10    code_u111
    ## 1            Outros nº 74-S de 22/02/2010 31/08/2012 0000.32.2350
    ## 2       Decreto nº 051/2018 de 20/09/2018 20/09/2018 1480.52.3787
    ## 3           Portaria nº 466 de 27/06/2013 10/07/2017 0000.33.3445
    ## 4          Decreto nº 83548 de 05/06/1979 27/09/2007 0000.00.0145
    ## 5          Decreto nº 5.630 de 07/08/2002 06/08/2009 0000.52.1754
    ## 6            Portaria nº 25 de 11/12/2007 26/08/2011 0000.00.2092
    ## 7          Decreto nº 36472 de 04/05/2015 04/07/2019 0000.53.3178
    ## 8          Decreto nº 29881 de 12/10/1957 13/09/2019 0000.35.0821
    ## 9  Lei complementar nº 3587 de 09/07/2004 15/08/2019 0350.33.1879
    ## 10         Decreto nº 2.587 de 07/10/2016 27/03/2017 0227.33.3471
    ##                                                                                              name_organization
    ## 1                                    Instituto Estadual de Meio Ambiente e Recursos Hídricos do Espírito Santo
    ## 2                                                    Secretaria Municipal de Meio Ambiente de Nova Aurora - GO
    ## 3                                                             Instituto Estadual do Ambiente do Rio de Janeiro
    ## 4                                                      Instituto Chico Mendes de Conservação da Biodiversidade
    ## 5                                        Secretaria Estadual do Meio Ambiente e dos Recursos Hídricos de Goiás
    ## 6                                                      Instituto Chico Mendes de Conservação da Biodiversidade
    ## 7             Instituto do Meio Ambiente e dos Recursos Hídricos do Distrito Federal - Brasília Ambiental - DF
    ## 8                                      Fundação para Conservação e a Produção Florestal do Estado de São Paulo
    ## 9  Secretaria Municipal de Meio Ambiente, Agricultura, Desenvolvimento Econômico e Turismo de Nova Iguaçu - RJ
    ## 10                               Secretaria Municipal do Ambiente e Desenvolvimento Sustentável de Japeri - RJ
    ##      date                           geom
    ## 1  201909 MULTIPOLYGON (((-40.96875 -...
    ## 2  201909 MULTIPOLYGON (((-48.25389 -...
    ## 3  201909 MULTIPOLYGON (((-42.79637 -...
    ## 4  201909 MULTIPOLYGON (((-42.57484 -...
    ## 5  201909 MULTIPOLYGON (((-50.58059 -...
    ## 6  201909 MULTIPOLYGON (((-42.02135 -...
    ## 7  201909 MULTIPOLYGON (((-47.8319 -1...
    ## 8  201909 MULTIPOLYGON (((-49.13593 -...
    ## 9  201909 MULTIPOLYGON (((-43.38872 -...
    ## 10 201909 MULTIPOLYGON (((-43.6024 -2...

``` r
ggplot() +
  geom_sf(data = uc, color = "darkgreen", fill = "forestgreen", alpha = 0.3)
```

![](README_files/figure-gfm/unnamed-chunk-78-1.png)<!-- -->

## Tratando

``` r
uc %<>%
  sf::st_make_valid() %<>%
  sf::st_intersection(ma)
```

    ## Warning: attribute variables are assumed to be spatially constant throughout all
    ## geometries

``` r
uc
```

    ## Simple feature collection with 1161 features and 17 fields
    ## Geometry type: GEOMETRY
    ## Dimension:     XY
    ## Bounding box:  xmin: -54.79835 ymin: -29.92864 xmax: -28.84785 ymax: 0.9178799
    ## Geodetic CRS:  SIRGAS 2000
    ## First 10 features:
    ##    code_conservation_unit
    ## 1                    2350
    ## 3                    3445
    ## 6                    2092
    ## 8                     821
    ## 9                    1879
    ## 10                   3471
    ## 12                   1965
    ## 14                     73
    ## 17                   1686
    ## 18                   1766
    ##                                             name_conservation_unit id_wcm
    ## 1       RESERVA PARTICULAR DO PATRIMÔNIO NATURAL BUGIO E COMPANHIA   <NA>
    ## 3                   RESERVA PARTICULAR DO PATRIMÔNIO NATURAL PILAR   <NA>
    ## 6  RESERVA PARTICULAR DO PATRIMÔNIO NATURAL DA CABECEIRA DO CAFÔFO   <NA>
    ## 8                                        ESTAÇÃO ECOLÓGICA ITABERÁ  81049
    ## 9                             ÀREA DE PROTEÇÃO AMBIENTAL DE TINGUÁ   <NA>
    ## 10             ÁREA DE RELEVANTE INTERESSE ECOLóGICO DO CITRóPOLIS   <NA>
    ## 12                                   PARQUE ESTADUAL DE ITAPETINGA   <NA>
    ## 14                               ESTAÇÃO ECOLÓGICA MICO LEÃO PRETO 351728
    ## 17                                    RESERVA EXTRATIVISTA TAQUARI   <NA>
    ## 18                                        APA DO MORRO DO SILVéRIO   <NA>
    ##                                    category group government_level creation_year
    ## 1  Reserva Particular do Patrimônio Natural    US         estadual          2010
    ## 3  Reserva Particular do Patrimônio Natural    US         estadual          2013
    ## 6  Reserva Particular do Patrimônio Natural    US          federal          2007
    ## 8                         Estação Ecológica    PI         estadual          1957
    ## 9                Área de Proteção Ambiental    US        municipal          2004
    ## 10    Área de Relevante Interesse Ecológico    US        municipal          2016
    ## 12                                   Parque    PI         estadual          2010
    ## 14                        Estação Ecológica    PI          federal          2002
    ## 17                     Reserva Extrativista    US         estadual          2008
    ## 18               Área de Proteção Ambiental    US        municipal          1999
    ##     gid7
    ## 1   6101
    ## 3  13500
    ## 6   9436
    ## 8   2909
    ## 9   3619
    ## 10 13135
    ## 12  4479
    ## 14  5262
    ## 17  4589
    ## 18  4331
    ##                                                                             quality
    ## 1         Aproximado (O poligono representa uma estimativa dos limites da unidade).
    ## 3  Correto (O poligono corresponde ao memorial descritivo do ato legal de criação).
    ## 6  Correto (O poligono corresponde ao memorial descritivo do ato legal de criação).
    ## 8         Aproximado (O poligono representa uma estimativa dos limites da unidade).
    ## 9  Correto (O poligono corresponde ao memorial descritivo do ato legal de criação).
    ## 10 Esquemático (O poligono é uma representação esquemática da dimensão da unidade).
    ## 12 Correto (O poligono corresponde ao memorial descritivo do ato legal de criação).
    ## 14 Correto (O poligono corresponde ao memorial descritivo do ato legal de criação).
    ## 17        Aproximado (O poligono representa uma estimativa dos limites da unidade).
    ## 18 Correto (O poligono corresponde ao memorial descritivo do ato legal de criação).
    ##                               legislation dt_ultim10    code_u111
    ## 1            Outros nº 74-S de 22/02/2010 31/08/2012 0000.32.2350
    ## 3           Portaria nº 466 de 27/06/2013 10/07/2017 0000.33.3445
    ## 6            Portaria nº 25 de 11/12/2007 26/08/2011 0000.00.2092
    ## 8          Decreto nº 29881 de 12/10/1957 13/09/2019 0000.35.0821
    ## 9  Lei complementar nº 3587 de 09/07/2004 15/08/2019 0350.33.1879
    ## 10         Decreto nº 2.587 de 07/10/2016 27/03/2017 0227.33.3471
    ## 12        Decreto nº 55.662 de 31/12/2010 10/01/2019 0000.35.1965
    ## 14           Decreto nº S/N de 17/07/2002 27/04/2011 0000.00.0073
    ## 17   Lei ordinária nº 12810 de 21/02/2008 30/09/2015 0000.35.1686
    ## 18    Lei ordinária nº 2836 de 14/07/1999 15/03/2011 0455.33.1766
    ##                                                                                              name_organization
    ## 1                                    Instituto Estadual de Meio Ambiente e Recursos Hídricos do Espírito Santo
    ## 3                                                             Instituto Estadual do Ambiente do Rio de Janeiro
    ## 6                                                      Instituto Chico Mendes de Conservação da Biodiversidade
    ## 8                                      Fundação para Conservação e a Produção Florestal do Estado de São Paulo
    ## 9  Secretaria Municipal de Meio Ambiente, Agricultura, Desenvolvimento Econômico e Turismo de Nova Iguaçu - RJ
    ## 10                               Secretaria Municipal do Ambiente e Desenvolvimento Sustentável de Japeri - RJ
    ## 12                                     Fundação para Conservação e a Produção Florestal do Estado de São Paulo
    ## 14                                                     Instituto Chico Mendes de Conservação da Biodiversidade
    ## 17                                     Fundação para Conservação e a Produção Florestal do Estado de São Paulo
    ## 18                                  Secretaria Municipal de Conservação e Meio Ambiente do Rio de Janeiro - RJ
    ##      date     name_biome code_biome year                           geom
    ## 1  201909 Mata Atlântica          4 2019 POLYGON ((-40.9703 -20.0617...
    ## 3  201909 Mata Atlântica          4 2019 MULTIPOLYGON (((-42.80029 -...
    ## 6  201909 Mata Atlântica          4 2019 POLYGON ((-42.01531 -22.113...
    ## 8  201909 Mata Atlântica          4 2019 POLYGON ((-49.13893 -23.836...
    ## 9  201909 Mata Atlântica          4 2019 POLYGON ((-43.39249 -22.571...
    ## 10 201909 Mata Atlântica          4 2019 POLYGON ((-43.60316 -22.682...
    ## 12 201909 Mata Atlântica          4 2019 POLYGON ((-46.46684 -23.188...
    ## 14 201909 Mata Atlântica          4 2019 MULTIPOLYGON (((-52.47203 -...
    ## 17 201909 Mata Atlântica          4 2019 POLYGON ((-48.0226 -25.0839...
    ## 18 201909 Mata Atlântica          4 2019 POLYGON ((-43.63734 -22.990...

``` r
ggplot() +
  geom_sf(data = uc, color = "darkgreen", fill = "forestgreen", alpha = 0.3)
```

![](README_files/figure-gfm/unnamed-chunk-79-1.png)<!-- -->

## Raster de desmatamento

### Importnado

``` r
des_tif <- terra::rast("prodes_mata_atlantica_2024.tif")
```

### Visualizando

``` r
des_tif
```

    ## class       : SpatRaster 
    ## size        : 114909, 98501, 1  (nrow, ncol, nlyr)
    ## resolution  : 0.0002689, 0.0002689  (x, y)
    ## extent      : -55.33482, -28.8479, -29.98113, 0.9179008  (xmin, xmax, ymin, ymax)
    ## coord. ref. : lon/lat SIRGAS 2000 (EPSG:4674) 
    ## source      : prodes_mata_atlantica_2024.tif 
    ## name        : prodes_mata_atlantica_2024

``` r
ggplot() +
  tidyterra::geom_spatraster(data = des_tif) +
  scale_fill_viridis_c(na.value = NA) +
  geom_sf(data = uc, color = "red", fill = NA) +
  theme_minimal()
```

    ## <SpatRaster> resampled to 500420 cells.

![](README_files/figure-gfm/unnamed-chunk-81-1.png)<!-- -->

# Reamostrando o raster de desmatamento para 1km²

## Criando o raster

``` r
raster_modelo <- rast(res = (30 / 3600), 
                      crs = "EPSG:4326",
                      ext = des_tif |> terra::ext())

raster_modelo
```

    ## class       : SpatRaster 
    ## size        : 3708, 3178, 1  (nrow, ncol, nlyr)
    ## resolution  : 0.008333333, 0.008333333  (x, y)
    ## extent      : -55.33482, -28.85149, -29.98113, 0.9188707  (xmin, xmax, ymin, ymax)
    ## coord. ref. : lon/lat WGS 84 (EPSG:4326)

## Reamostrando

``` r
des_tif
```

    ## class       : SpatRaster 
    ## size        : 114909, 98501, 1  (nrow, ncol, nlyr)
    ## resolution  : 0.0002689, 0.0002689  (x, y)
    ## extent      : -55.33482, -28.8479, -29.98113, 0.9179008  (xmin, xmax, ymin, ymax)
    ## coord. ref. : lon/lat SIRGAS 2000 (EPSG:4674) 
    ## source      : prodes_mata_atlantica_2024.tif 
    ## name        : prodes_mata_atlantica_2024

``` r
des_tif_rea <- des_tif |> 
  terra::resample(raster_modelo)
  
des_tif_rea
```

    ## class       : SpatRaster 
    ## size        : 3708, 3178, 1  (nrow, ncol, nlyr)
    ## resolution  : 0.008333333, 0.008333333  (x, y)
    ## extent      : -55.33482, -28.85149, -29.98113, 0.9188707  (xmin, xmax, ymin, ymax)
    ## coord. ref. : lon/lat SIRGAS 2000 (EPSG:4674) 
    ## source(s)   : memory
    ## name        : prodes_mata_atlantica_2024 
    ## min value   :                          0 
    ## max value   :                        100

``` r
terra::res(des_tif_rea) == terra::res(des_tif)
```

    ## [1] FALSE FALSE

## Visualizando o raster reamostrado

``` r
des_tif_rea
```

    ## class       : SpatRaster 
    ## size        : 3708, 3178, 1  (nrow, ncol, nlyr)
    ## resolution  : 0.008333333, 0.008333333  (x, y)
    ## extent      : -55.33482, -28.85149, -29.98113, 0.9188707  (xmin, xmax, ymin, ymax)
    ## coord. ref. : lon/lat SIRGAS 2000 (EPSG:4674) 
    ## source(s)   : memory
    ## name        : prodes_mata_atlantica_2024 
    ## min value   :                          0 
    ## max value   :                        100

``` r
ggplot() +
  tidyterra::geom_spatraster(data = des_tif_rea) +
  scale_fill_viridis_c(na.value = NA) +
  geom_sf(data = uc, color = "red", fill = NA) +
  theme_minimal()
```

    ## <SpatRaster> resampled to 500420 cells.

![](README_files/figure-gfm/unnamed-chunk-84-1.png)<!-- -->

# Comparação da área de desmatamento por estados

## Área dos estados

``` r
area_estados <- estados_ma |> 
  sf::st_transform(crs = 32725) |> 
  sf::st_area() / 1e6 |> 
  as.numeric()

area_estados
```

    ## Units: [m^2]
    ##  [1]   2050.040   4107.735  15485.420  14640.369   9830.588 111223.705 243890.690
    ##  [8]  46778.934  44782.021 215797.211 214325.784 102642.240  95710.275  42034.495
    ## [15]   5972.690

## Área desmatada

``` r
area_raster <- c()

area_desmatada <- function(id){
  
  raster_recortado <- des_tif_rea |>
    terra::crop(estados_ma[id, ]) |> 
    terra::mask(estados_ma[id, ]) |> 
    tidyterra::filter(prodes_mata_atlantica_2024 < 50)
  
  area <- raster_recortado |> terra::expanse(unit = "km")
  
  area_raster <<- c(area_raster, area[1, 2]) 
  
}

n_estados <- estados_ma |> nrow()

n_estados
```

    ## [1] 15

``` r
purrr::walk(1:n_estados, area_desmatada)

area_raster
```

    ##  [1]   1381.980   3412.330  14256.365  13403.530   8272.519  79542.533 188566.695
    ##  [8]  38729.391  31615.304 171971.418 167535.027  63588.997  67541.935  32578.251
    ## [15]   5540.468

## Incorporando os dados ao shapefile

``` r
estados_area <- estados_ma |> 
  dplyr::mutate(`Área desmatada` = area_raster,
                `% de área desmatada do estado` = area_raster / area_estados |>
                  as.numeric())

estados_area
```

    ## Simple feature collection with 15 features and 10 fields
    ## Geometry type: GEOMETRY
    ## Dimension:     XY
    ## Bounding box:  xmin: -55.33475 ymin: -29.98127 xmax: -28.84824 ymax: -3.804938
    ## Geodetic CRS:  SIRGAS 2000
    ## First 10 features:
    ##    code_state abbrev_state          name_state code_region name_region
    ## 11         24           RN Rio Grande Do Norte           2    Nordeste
    ## 12         25           PB             Paraíba           2    Nordeste
    ## 13         26           PE          Pernambuco           2    Nordeste
    ## 14         27           AL             Alagoas           2    Nordeste
    ## 15         28           SE             Sergipe           2    Nordeste
    ## 16         29           BA               Bahia           2    Nordeste
    ## 17         31           MG        Minas Gerais           3     Sudeste
    ## 18         32           ES      Espírito Santo           3     Sudeste
    ## 19         33           RJ      Rio De Janeiro           3     Sudeste
    ## 20         35           SP           São Paulo           3     Sudeste
    ##        name_biome code_biome year                           geom Área desmatada
    ## 11 Mata Atlântica          4 2019 MULTIPOLYGON (((-35.23148 -...       1381.980
    ## 12 Mata Atlântica          4 2019 MULTIPOLYGON (((-34.96617 -...       3412.330
    ## 13 Mata Atlântica          4 2019 MULTIPOLYGON (((-32.39288 -...      14256.365
    ## 14 Mata Atlântica          4 2019 MULTIPOLYGON (((-36.73955 -...      13403.530
    ## 15 Mata Atlântica          4 2019 POLYGON ((-36.40824 -10.510...       8272.519
    ## 16 Mata Atlântica          4 2019 MULTIPOLYGON (((-38.71065 -...      79542.533
    ## 17 Mata Atlântica          4 2019 MULTIPOLYGON (((-51.00015 -...     188566.695
    ## 18 Mata Atlântica          4 2019 MULTIPOLYGON (((-29.29958 -...      38729.391
    ## 19 Mata Atlântica          4 2019 MULTIPOLYGON (((-41.82918 -...      31615.304
    ## 20 Mata Atlântica          4 2019 MULTIPOLYGON (((-47.85009 -...     171971.418
    ##    % de área desmatada do estado
    ## 11                     0.6741233
    ## 12                     0.8307083
    ## 13                     0.9206314
    ## 14                     0.9155186
    ## 15                     0.8415080
    ## 16                     0.7151581
    ## 17                     0.7731607
    ## 18                     0.8279238
    ## 19                     0.7059821
    ## 20                     0.7969121

## Visualizando

``` r
ggplot() +
  geom_sf(data = estados, color = "black") +
  geom_sf(data = estados_area, 
          color = "black", aes(fill = `Área desmatada`)) +
  scale_fill_viridis_c(na.value = NA) +
  theme_minimal()
```

![](README_files/figure-gfm/unnamed-chunk-88-1.png)<!-- -->

``` r
ggplot() +
  geom_sf(data = estados, color = "black") +
  geom_sf(data = estados_area, 
          color = "black", aes(fill = `% de área desmatada do estado`)) +
  scale_fill_viridis_c(na.value = NA) +
  theme_minimal()
```

![](README_files/figure-gfm/unnamed-chunk-88-2.png)<!-- -->

# Comparação do desmatamento dentro e fora de unidades de conservação
