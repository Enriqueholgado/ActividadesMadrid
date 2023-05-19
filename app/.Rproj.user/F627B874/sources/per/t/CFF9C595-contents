#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



# Funciones y paquetes --------------------------------------------------------------------

#Carga de paquetes necesarios
source("src/packages.R")

#Descriptivo de la aplicación
source("src/descriptivo_aplicacion.R")



# Datos -----------------------------------------------------------------------------------


## Cargamos la información, en este caso vamos a cargar los datos de los eventos de los próximos 100 días organizados en Madrid
## lo vamos a hacer utilizando la API que el ayuntamiento pone a disposición de los ciudadanos en su página web: 
## https://datos.madrid.es/portal/site/egob

# CARGAMOS EL DATASET
## URL de los datos en abierto en formato Json para que se pueda actualizar solo
## Para entender como leer una API en R he utilizado este link: https://www.dataquest.io/blog/r-api-tutorial/
## Aunque para solucionar el problema de Encoding, he usado esta otra: https://stackoverflow.com/questions/48002071/encoding-json-in-r
liveish_data <- reactive({
  invalidateLater(1000)
  
  
  compute_data()
})

#Carga de datos
source("src/Carga_datos.R")


pal <- colorFactor(
  palette = 'Paired',
  domain = Contenidolimpio$TipoEventResumen
)




# Desarrollo de aplicación -----------------------------------------------------------------


# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  options(encoding = 'UTF-8')
  filteredData <- reactive({
    if (input$Actividades == "Todas las actividades") {
      filter(Contenidolimpio, between(Fecha_inicio, input$Fechas[1],input$Fechas[2]))
    } else {
      filter(filter(Contenidolimpio, between(Fecha_inicio, input$Fechas[1],input$Fechas[2])), TipoEventResumen == input$Actividades)
      
    }
  })
  
  
  
  output$mymap <- renderLeaflet({
    leaflet(filteredData()) %>%
      setView(lng = -3.71509, lat = 40.44674, zoom = 12) %>%
      addResetMapButton() %>%
      addLegend(position = "bottomleft", pal=pal, values = ~TipoEventResumen, title = "Tipo de actividad") %>%
      addProviderTiles("CartoDB.Positron") %>%
      addCircleMarkers(~Longitud, ~Latitud, 
                       label = ~Titulo,
                       color = ~pal(TipoEventResumen),
                       popup = paste0("<center>",
                                      "<b>", "<h3>", htmlEscape(filteredData()$Titulo), "</h3> </b> <br>",
                                      "</center>",
                                      "<left>",
                                      filteredData()$`Descripción`, "<br>",
                                      "<b>"," ","</b><br>",
                                      "<b>", "Centro organizador: ", "</b>", filteredData()$Organizador, "<br>",
                                      "<b>", "Ubicación: ", "</b>", filteredData()$Calle, "<br>",
                                      "<b>"," ","</b><br>",
                                      "<b>", "Fechas: ", "</b>","Desde el ", filteredData()$Fecha_inicio , " hasta el ", filteredData()$Fecha_fin, "<br>",
                                      "<b>", "Fechas de cierre: ", "</b>", filteredData()$`Fechas excluidas`,"<br>",
                                      "<b>"," ","</b><br>",
                                      "<b>", "Hora: ", "</b>", filteredData()$Hora,"<br>",
                                      "<b>"," ","</b><br>",
                                      "</left>",
                                      "<b>"," ","</b><br>",
                                      "<center>",
                                      '<a href="', # note the use of single quotes - to make a single " a legit piece of code
                                      filteredData()$link,
                                      '"target="_blank">Más información</a>.'), #POPUP campo creado, si fuera necesarion en Global.R #creación del campo en global.R
                       labelOptions = labelOptions(textsize = "16px"),
                       clusterOptions = markerClusterOptions()
      ) 
  })
  
  
  #Gráficos ------------------------------------------------------------------
  
  
  
  filteredData_1 <- reactive({
    EventosTOP
  })
  
  d <- reactive({ highlight_key(EventosTOP)})
  
  
  output$graphbar <- renderPlotly({
    fig <- plot_ly(d(), x = ~Distrito, y = ~n,  type = 'bar', 
                   hoverinfo= "text", hovertext = ~paste("Barrio: ", Barrio,"<br>" ,
                                                    "Tipo de evento: ", TipoEventResumen,"<br>",
                                                    "Número de eventos: ",n),
                   textposition="auto") %>%
      highlight("plotly_click")
    fig <- fig %>% layout(
      title = 'Número de eventos por barrio y distrito',
      plot_bgcolor='#e5ecf6',
      xaxis = list(
        zerolinecolor = '#ffff',
        zerolinewidth = 2,
        categoryorder = "total descending",
        gridcolor = 'ffff'),
      yaxis = list(
        title = 'Número de eventos',
        zerolinecolor = '#ffff',
        zerolinewidth = 2,
        gridcolor = 'ffff'),
      showlegend = FALSE)%>%
      highlight(on = "plotly_selected", dynamic =  TRUE, persistent = TRUE)
    
  })
  
  output$graphpie <- renderPlotly({
    fig_1 <- plot_ly(d(), labels = ~TipoEventResumen, values = ~n,  type = 'pie',
                     textposition = 'inside',
                     textinfo = 'label+percent',
                     insidetextfont = list(color = '#FFFFFF'),
                     hoverinfo = 'text',
                     text = ~paste('Número de eventos', n),
                     marker = list(colors = colors,
                                   line = list(color = '#FFFFFF', width = 1))) %>%
      highlight("plotly_click")
    fig_1 <- fig_1 %>% layout(
      title = 'Número de eventos por tipología',
      plot_bgcolor='#e5ecf6',
      xaxis = list(
        zerolinecolor = '#ffff',
        zerolinewidth = 2,
        categoryorder = "total descending",
        gridcolor = 'ffff',
        showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
      yaxis = list(
        title = 'Número de eventos',
        zerolinecolor = '#ffff',
        zerolinewidth = 2,
        gridcolor = 'ffff'),
      showlegend = TRUE,
      showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
    
    
  })
  
  #Tabla de datos ------------------------------------------------------------------
  
  observe({
    distrito <- if (is.null(input$Tipodeactividad)) {character(0)} 
    else {
      filter(Contenidolimpio, TipoEventResumen %in% input$Tipodeactividad) %>%
        `$`('Distrito') %>%
        unique() %>%
        sort()
    }
    stillSelected <- isolate(input$distrito[input$distrito %in% distrito])
    updateSelectizeInput(session, "distrito", choices = distrito,
                         selected = stillSelected, server = TRUE)
  })
  
  observe({
    barrio <- if (is.null(input$Tipodeactividad)) {character(0)}  else {
      Contenidolimpio %>%
        filter(TipoEventResumen %in% input$Tipodeactividad,
               is.null(input$distrito) | Distrito %in% input$distrito) %>%
        `$`('Barrio') %>%
        unique() %>%
        sort()
    }
    stillSelected <- isolate(input$barrio[input$barrio %in% barrio])
    updateSelectizeInput(session, "barrio", choices = barrio,
                         selected = stillSelected, server = TRUE)
  })
  
  
  
  output$Contenidolimpio <- DT::renderDataTable({
    df <- Contenidolimpio %>%
      filter(
        is.null(input$Tipodeactividad) | TipoEventResumen %in% input$Tipodeactividad,
        is.null(input$distrito) | Distrito %in% input$distrito,
        is.null(input$barrio) | Barrio %in% input$barrio,
        is.null(input$Gratis) | Gratuito %in% input$Gratis,
      )
  })#renderDataTable
  
  
  
}#function
)#shiniyServer

