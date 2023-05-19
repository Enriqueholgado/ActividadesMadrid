
## Cargamos la información, en este caso vamos a cargar los datos de los eventos de los próximos 100 días organizados en Madrid
## lo vamos a hacer utilizando la API que el ayuntamiento pone a disposición de los ciudadanos en su página web: 
## https://datos.madrid.es/portal/site/egob

# CARGAMOS EL DATASET
## URL de los datos en abierto en formato Json para que se pueda actualizar solo
## Para entender como leer una API en R he utilizado este link: https://www.dataquest.io/blog/r-api-tutorial/
## Aunque para solucionar el problema de Encoding, he usado esta otra: https://stackoverflow.com/questions/48002071/encoding-json-in-r
  req <- GET("https://datos.madrid.es/egob/catalogo/206974-0-agenda-eventos-culturales-100.json")
  text <- httr::content(req, "text", encoding="UTF-8")
  
  data <- fromJSON(text)
  
  names(data)
  
  contenido <- data$`@graph`
  Recurrencia <- contenido$recurrence
  Referencia <- contenido$references
  Relacion <- contenido$relation
  Direccion <- contenido$address
  Distrito <- Direccion$district
  Area <- Direccion$area
  Localizacion <- contenido$location
  Organizacion <- contenido$organization
  
  borrar <- c("@id", "recurrence", "references","relation","address", "location", "organization" )
  Contenidolimpio <- contenido[,!names(contenido) %in% borrar]
  
  names(Contenidolimpio) = c("Tipo de evento", "ID number", "Titulo", "Descripción", "Gratuito", "Precio",
                             "Fecha_inicio", "Fecha_fin", "Hora", "Fechas excluidas", "ID único" , "link",
                             "Localización", "Audiencia")
  
  Contenidolimpio$`Tipo de evento` <- str_replace(Contenidolimpio$`Tipo de evento`, "https://datos.madrid.es/egob/kos/actividades/", "")
  Distrito$`@id` <- str_replace(Distrito$`@id`, "https://datos.madrid.es/egob/kos/Provincia/Madrid/Municipio/Madrid/Distrito/", "")
  Distrito$`@id` <- str_replace(Distrito$`@id`, "https://datos.madrid.es/egob/kos/Provincia/Madrid/Municipio/Madrid/Distrito/", "")
  Contenidolimpio$Distrito <- Distrito$`@id`
  
  Area$Barrio <- str_extract(Area$`@id`, "\\/Barrio\\/[a-zA-Z]+")
  Area$Barrio <- str_replace(Area$Barrio,"/Barrio/","")
  
  Contenidolimpio$Localidad <- Area$locality
  Contenidolimpio$Codigo_Postal <- Area$`postal-code`
  Contenidolimpio$Barrio <- Area$Barrio
  Contenidolimpio$Calle <- Area$`street-address`
  Contenidolimpio$Latitud <- Localizacion$latitude
  Contenidolimpio$Longitud <- Localizacion$longitude
  Contenidolimpio$Organizador <- Organizacion$`organization-name`
  Contenidolimpio$Accesibilidad <- Organizacion$accesibility
  Contenidolimpio$Recurrencia <- Recurrencia$frequency
  Contenidolimpio$DiasRecurrencia <- Recurrencia$days
  Contenidolimpio$Fecha_inicio <- str_replace(Contenidolimpio$Fecha_inicio, " [0-9][0-9]:[0-9][0-9]:[0-9][0-9].[0-9]" , "")
  Contenidolimpio$Fecha_fin <- str_replace(Contenidolimpio$Fecha_fin, " [0-9][0-9]:[0-9][0-9]:[0-9][0-9].[0-9]" , "")
  Contenidolimpio$Fecha_inicio <- str_replace(Contenidolimpio$Fecha_inicio, " [0-9][0-9]:[0-9][0-9]:[0-9][0-9].[0-9]" , "")
  #Contenidolimpio$Fecha_fin <- as.Date(format(Contenidolimpio$Fecha_fin,"%d/%m/%Y"))
  Contenidolimpio$Intervalo <- Recurrencia$interval
  Contenidolimpio$`Fechas excluidas`[Contenidolimpio$`Fechas excluidas` == ""] <- "No hay fechas excluídas"
  Contenidolimpio$`Fechas excluidas`[Contenidolimpio$`Fechas excluidas` == ""] <- "Hora no definida"
  Contenidolimpio$Gratuito <- ifelse((grepl(1, Contenidolimpio$Gratuito, fixed=TRUE)),"Sí", "No")
  Contenidolimpio$Accesibilidad <- ifelse((grepl(1, Contenidolimpio$Accesibilidad, fixed=TRUE)),"Sí",
                                          Contenidolimpio$Accesibilidad <- ifelse((grepl(0, Contenidolimpio$Accesibilidad, fixed=TRUE)),"No","No Aplica"))
  
  Contenidolimpio$TipoEventResumen <- ifelse((grepl("Danza", Contenidolimpio$`Tipo de evento`, fixed=TRUE)),"Danza",
                                             ifelse((grepl("Exposiciones", Contenidolimpio$`Tipo de evento`, fixed=TRUE)),"Exposiciones",
                                                    ifelse((grepl("Cine", Contenidolimpio$`Tipo de evento`, fixed=TRUE)),"Cine",
                                                           ifelse((grepl("Cuentacuentos", Contenidolimpio$`Tipo de evento`, fixed=TRUE)),"Cuentacuentos",
                                                                  ifelse((grepl("Circo", Contenidolimpio$`Tipo de evento`, fixed=TRUE)),"Circo",
                                                                         ifelse((grepl("Musica", Contenidolimpio$`Tipo de evento`, fixed=TRUE)),"Música",
                                                                                ifelse((grepl("Teatro", Contenidolimpio$`Tipo de evento`, fixed=TRUE)),"Teatro",
                                                                                       ifelse((grepl("Lectura", Contenidolimpio$`Tipo de evento`, fixed=TRUE)),"Club de Lectura",
                                                                                              ifelse((grepl("CursosTalleres", Contenidolimpio$`Tipo de evento`, fixed=TRUE)),"Cursos Talleres",
                                                                                                     ifelse((grepl("Ambientales", Contenidolimpio$`Tipo de evento`, fixed=TRUE)),"Actividades medioambientales",
                                                                                                            ifelse((grepl("Agenda", Contenidolimpio$`Tipo de evento`, fixed=TRUE)),"Agenda cultural",
                                                                                                                   ifelse((grepl("Conferencia", Contenidolimpio$`Tipo de evento`, fixed=TRUE)),"Conferencias",
                                                                                                                          ifelse((grepl("Excursiones", Contenidolimpio$`Tipo de evento`, fixed=TRUE)),"Excursiones",
                                                                                                                                 ifelse((grepl("Deportivas", Contenidolimpio$`Tipo de evento`, fixed=TRUE)),"Actividades deportivas",
                                                                                                                                        ifelse((grepl("Campamentos", Contenidolimpio$`Tipo de evento`, fixed=TRUE)),"Campamentos",
                                                                                                                                               ifelse((grepl("Fiestas", Contenidolimpio$`Tipo de evento`, fixed=TRUE)),"Fiestas","Otros"))))))))))))))))
  
  
  
  
  
  
  
  Contenidolimpio$Fecha_inicio <- as.Date(Contenidolimpio$Fecha_inicio)
  Contenidolimpio$Fecha_fin <- as.Date(Contenidolimpio$Fecha_fin)
  
  
  Eventos <- nrow(Contenidolimpio) - sum(is.na(Contenidolimpio$Latitud))
  
  
  
  BarriosTOP <- Contenidolimpio %>%
    count(Barrio)
  BarriosTOP =na.omit(BarriosTOP)
  BarriosTOP <- BarriosTOP[with(BarriosTOP,order(-BarriosTOP$n)),]
  BarriosDistrito <- unique(Contenidolimpio[c("Distrito","Barrio")])
  BarriosTOP <- merge(BarriosTOP, BarriosDistrito,by="Barrio", all.x=TRUE)
  
  DistritosTOP  <- BarriosTOP %>%
    count(Distrito)
  
  BarrioTOP = BarriosTOP$Barrio[which.max(BarriosTOP$n)]
  EventosTOP <- Contenidolimpio %>%
    count(Distrito, Barrio, TipoEventResumen)
  
  
  
  
  
  TotalGratuitos = nrow(subset(Contenidolimpio,Contenidolimpio$Gratuito=="Sí"))
  #
  #
  # Contenidolimpio <- Contenidolimpio %>%  #https://www.jla-data.net/eng/leaflet-in-r-tips-and-tricks/
  #   dplyr::mutate(POPUP = paste0("<center>",
  #                                "<b>", "<h4>", htmlEscape(Contenidolimpio$Titulo), "</h4> </b> <br>",
  #                                "<b>"," ","</b><br>",
  #                                "</center>",
  #                                "<left>",
  #                                Contenidolimpio$`Descripción`, "<br>",
  #                                "<b>"," ","</b><br>",
  #                                "<b>", "Centro organizador: ", "</b>", Contenidolimpio$Organizador, "<br>",
  #                                "<b>", "Ubicación: ", "</b>", Contenidolimpio$Calle, "<br>",
  #                                "<b>"," ","</b><br>",
  #                                "<b>", "Fechas: ", "</b>","Desde el ", Contenidolimpio$Fecha_inicio , " hasta el ", Contenidolimpio$Fecha_fin, "<br>",
  #                                "<b>", "Fechas de cierre:", "</b>", Contenidolimpio$`Fechas excluidas`,"<br>",
  #                                "<b>"," ","</b><br>",
  #                                "<b>", "Hora: ", Contenidolimpio$Hora,"<br>",
  #                                "<b>"," ","</b><br>",
  #                                "</left>",
  #                                "<b>"," ","</b><br>",
  #                                "<center>",
  #                                '<a href="', # note the use of single quotes - to make a single " a legit piece of code
  #                                Contenidolimpio$link,
  #                                '"target="_blank">Más información</a>.')) # again note the combination of single & double quotes
  # 
  # 
  
  
