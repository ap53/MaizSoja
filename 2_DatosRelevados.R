
## @knitr readDepartamentos
departamentos <- readOGR(dsn = "./Departamentos shapefiles", layer = "deptos_f5", verbose = FALSE)
#plot(departamentos)



## @knitr ubicarDptos
dptos <- 
  departamentos[departamentos$PROV == '82' & 
                  departamentos$NOMDEP %in% c('BELGRANO', 'IRIONDO', 'SAN JERONIMO', 'SAN MARTIN'), ]

# No sé todavía cómo los voy a usar, los guardo a mano en proyecciones de Google Earth y de Google Maps
dptos.earth <- spTransform(dptos, CRS("+init=epsg:4326"))
dptos.maps <- spTransform(dptos, CRS("+init=epsg:3857"))

# dptos.maps@bbox




## @knitr verRegionGrande
centros <- cbind(coordinates(dptos.earth), dptos.earth@data)
names(centros)[1:2] <- c('lon', 'lat')

dptos.earth.df <- fortify(dptos.earth)


dptos.ggmap <- get_map(dptos.earth@bbox, zoom = 7, maptype = "terrain", source = "google")
dptos.mapa <- ggmap(dptos.ggmap)
dptos.mapa <- dptos.mapa + geom_polygon(aes(x=long, y=lat, group=group), 
                                        fill='yellow',color='red', 
                                        data=dptos.earth.df, alpha=0.2)
dptos.mapa



## @knitr verRegionPrep
# Expando la región de interés
dptos.ggmap <- get_map(dptos.earth@bbox, maptype = "terrain", source = "google")
dptos.mapa <- ggmap(dptos.ggmap)
dptos.mapa <- dptos.mapa + geom_polygon(aes(x=long, y=lat, group=group), 
                                        fill='yellow', size=.2,color='red', 
                                        data=dptos.earth.df, alpha=0.2)
dptos.mapa <- dptos.mapa + geom_text(aes(x = lon, y = lat, label = NOMDEP1),
                                     data= centros, alpha = 1, color = "red", cex = 7)
dptos.mapa




## @knitr pathRows

# Path/Rows de las imágenes Landsat
path.rows.all <- readOGR(dsn = "./wrs2_asc_desc", layer = "wrs2_asc_desc", verbose = FALSE)

# Es gigante, lo recorto (ya espié en http://earthexplorer.usgs.gov/ cuales son los paths relevantes)
path.rows <- 
  path.rows.all[path.rows.all$PATH %in% c('225', '226', '227', '228') & 
                  path.rows.all$ROW %in% c('81', '82', '83', '84'), ]

path.rows.df <- fortify(path.rows)
rm(path.rows.all)

p.r.centros <- cbind(coordinates(path.rows), path.rows@data)
names(p.r.centros)[1:2] <- c('lon', 'lat')

p.r.ggmap <- get_map(path.rows@bbox, zoom = 6, maptype = "terrain", source = "google")
p.r.mapa <- ggmap(p.r.ggmap)
p.r.mapa <- p.r.mapa + geom_polygon(aes(x=long, y=lat, group=group), 
                                    fill='green', size=.2,color='blue', 
                                    data=path.rows.df, alpha=0.2)
p.r.mapa <- p.r.mapa + geom_text(aes(x = lon, y = lat, label = as.character(PR)),
                                 data= p.r.centros, alpha = 1, color = "red", cex = 3)
p.r.mapa




## @knitr pathRows_Deptos
# Agrego los departamentos
p.r.mapa2 <- p.r.mapa + geom_polygon(aes(x=long, y=lat, group=group), 
                                     fill='yellow',color='red', 
                                     data=dptos.earth.df, alpha=0.2)
p.r.mapa2


## @knitr pathRows_ampliado
path.rows.zoom <- 
  path.rows[path.rows$PATH %in% c( '227', '228') & 
              path.rows$ROW %in% c('82', '83'), ]

path.rows.zoom.df <- fortify(path.rows.zoom)

p.r.centros <- cbind(coordinates(path.rows.zoom), path.rows.zoom@data)
names(p.r.centros)[1:2] <- c('lon', 'lat')

p.r.ggmap <- get_map(path.rows.zoom@bbox, zoom = 7, maptype = "terrain", source = "google")
p.r.mapa <- ggmap(p.r.ggmap)
p.r.mapa <- p.r.mapa + geom_polygon(aes(x=long, y=lat, group=group), 
                                    fill='green', size=.2,color='blue', 
                                    data=path.rows.zoom.df, alpha=0.2)
p.r.mapa <- p.r.mapa + geom_text(aes(x = lon, y = lat, label = as.character(PR)),
                                 data= p.r.centros, alpha = 1, color = "red", cex = 3)
# p.r.mapa

# Agrego los departamentos
p.r.mapa2 <- p.r.mapa + geom_polygon(aes(x=long, y=lat, group=group), 
                                     fill='yellow',color='red', 
                                     data=dptos.earth.df, alpha=0.2)
p.r.mapa2




