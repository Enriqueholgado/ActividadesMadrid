#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  navbarPage(title = img(src='logo_madrid_dark.png', align = "left", height=30, style="display: block; margin-left: auto; margin-right: auto;"), #https://stackoverflow.com/questions/21996887/embedding-image-in-shiny-app Meter imagen
             tabPanel("Resumen de actividades geolocalizadas",
                      titlePanel(h2("Eventos geolocalizados")),#titlepanel
                      leafletOutput("mymap", height = 930),
                      absolutePanel(id = "controls", draggable = TRUE, top = 120, left = "auto", right = 20, bottom = "auto",
                                    width = 330, height = "auto",
                                    h3("Filtro de actividades"),
                                    pickerInput("Actividades", label = "Seleccionar actividades:",
                                                choices = list("Todas las actividades", 
                                                               `Artes escénicas` = c("Danza", "Cine", "Circo", "Teatro", "Música", "Cuentacuentos"),
                                                               `Aire libre` = c("Actividades deportivas", "Campamentos", "Actividades medioambientales", "Excursiones"),
                                                               `Culturales` = c("Exposiciones", "Club de Lectura", "Conferencias", "Agenda cultural"),
                                                               `Otras actividades` = c("Cursos Talleres", "Fiestas", "Otros")),
                                                options = list(`live-search` = TRUE),
                                                selected = "Todas las actividades",
                                                multiple = TRUE,
                                    ),
                                    dateRangeInput(
                                      "Fechas",
                                      label = "Con fecha de inicio entre: ",
                                      start = min(Contenidolimpio$Fecha_inicio),
                                      end = max(Contenidolimpio$Fecha_inicio),
                                      min = min(Contenidolimpio$Fecha_inicio),
                                      max = max(Contenidolimpio$Fecha_inicio),
                                      format = "dd-mm-yyyy",
                                      startview = "month",
                                      separator = " hasta ",
                                      language = "es",
                                    )
                                    
                      )
             ),
             tabPanel("Información gráfica resumida", 
                      titlePanel(h2("Distribución de eventos")),#titlepanel
                      
                      frow1 <- fluidRow(
                        column(4,statiCard(
                          Eventos, "Eventos en Madrid", icon("calendar"),
                          background = "#e5ecf6",
                          color = "black",
                          animate = TRUE,
                          id = "Eventos"
                        )),
                        column(4,statiCard(
                          max(BarriosTOP$n), BarrioTOP, icon("city"),
                          background = "#e5ecf6",
                          color = "black",
                          animate = TRUE,
                          id = "Barriomaseventos"
                        )),                             
                        column(4,statiCard(
                          TotalGratuitos, "Eventos gratuitos", icon("euro-sign"),
                          background = "#e5ecf6",
                          color = "black",
                          animate = TRUE,
                          id = "EventosNoTOP"
                        )),
                      ),
                      br(),
                      hr(),
                      frow2 <- fluidRow(
                        column(6,plotlyOutput("graphbar")),
                        column(6,plotlyOutput("graphpie"))
                        #plotlyOutput("Graph")
                      ),
                      hr(),
             ),#tabpanel,
             tabPanel("Explorador de datos", 
                      fluidRow(
                        column(3,
                               selectInput("Tipodeactividad", "Tipo de actividad", c("Seleccionar actividad"="", Contenidolimpio$TipoEventResumen), multiple=TRUE)
                        ),
                        column(3,
                               conditionalPanel("input.Tipodeactividad",
                                                selectInput("distrito", "Distrito", c("Todos los distritos"=""),  multiple=TRUE)
                               )
                        ),
                        column(3,
                               conditionalPanel("input.distrito",
                                                selectInput("barrio", "Barrio", c("Todos los barrios"=""), multiple=TRUE)
                               )
                        )
                      ),#FluidRow
                      fluidRow(
                        column(1,
                               checkboxGroupInput("Gratis", "Gratuito", choices = c("Sí", "No"), "Sí")
                        ),
                      ), #FluidRow
                      h2('Información de las actividades'),
                      hr(),
                      DT::dataTableOutput("Contenidolimpio")
             ),#tabPanel
             # Acerca de la aplicación -----------------------------------------------
             tabPanel(
               title = "Sobre esta aplicación",
               fluidRow(
                 column(
                   width = 10, offset = 2,
                   descriptivo_aplicacion()
                 )#column
               )#fluidRow
             ),#tabPanel,
             
  )#navbarpage
  
  
) #fluidPage
)#shiniyUI