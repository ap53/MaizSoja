# PRUEBAS plotKML...  No anda...  
plotKML(dptos.earth[dptos.earth.names@data$NOMDEP1], alpha=0.3, LabelScale  = 1)

plotKML(dptos.earth, labels=as.character(dptos.earth$NOMDEP1), alpha=0.3, LabelScale  = 1)


kml(dptos.earth, labels=as.character(dptos.earth$NOMDEP1), alpha=0.3, LabelScale  = 1)
kml_View(file.name="dptos.earth.kml")
getwd()


kml_open(dptos.earth)
kml_aes(dptos.earth, labels=dptos.earth@data$NOMDEP1)
plotKML(dptos.earth, colour_scale=rep("#FFFF00", 2), #plot.labpt=TRUE, 
        alpha=0.3, LabelScale  = 1)

plotKML(dptos.earth, 
      colour, plot.labpt, labels, metadata = NULL, 
      kmz = get("kmz", envir = plotKML.opts), open.kml = TRUE, alpha=0.3, LabelScale  = 1)

str(dptos.earth.names@data[, 'NOMDEP1'])


dptos.earth@proj4string
dptos.maps@proj4string

dptos.earth@bbox
str(dptos.earth@bbox[5])
# qbbox(unlist(dptos.earth@bbox)[2,], unlist(dptos.earth@bbox)[1,], 
      # margin = list(m = c(1, 1, 1, 1), TYPE = "perc"))
colores <- colorRampPalette(c("red", "white", "blue"), space='Lab')

plot(dptos)

plot(dptos)
text(dptos, as.character(dptos$NOMDEP), cex=0.7)

