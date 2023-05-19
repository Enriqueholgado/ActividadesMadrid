

descriptivo_aplicacion <- function() {
  options(encoding = 'UTF-8')
  tags$div(
    class = "EnriqueHolgado",
    tags$b("Información :"), #tags%b
    
    tags$ul(
      tags$li("La aplicación descrita en este dashboard tiene por objeto aglutinar y representar gráficamente 
      todas las actividades que el ayuntamiento de Madrid organiza en sus diferentes centros en los próximos 100 días"),
      tags$li("Se han hecho ciertos ajustes para poder aglutinar de manera más sencilla la información por tipo de evento"),
      tags$li("Se ha intentado hacer algo diferente y que aporte valor."),
      tags$li("Los datos se cargan utilizando la API que el ayuntamiento de Madrid pone a disposición del ciudadano 
              cargano la información disponible en su base de datos a través de la carga del JSON que se descarga
              de la URL que se puede encontrar en el archivo global.R")
    ),#tags$ul
    
    tags$b("Datos:"), #tags$B
    
    tags$ul(
      tags$li(
        "Se ha utilizado esta base de datos: ", 
        tags$a("Datos actividades Ayuntamiento de Madrid en los próximos 100 días", 
               href = "https://datos.madrid.es/portal/site/egob")
      ),
    ),#tags#ul
    
    tags$b("Paquetes utilizados: "),
    tags$ul(
      tags$li(tags$a("shiny", href = "https://shiny.rstudio.com/"), ": para la aplicación"),
      tags$li(tags$a("shinyWidgets", href = "https://github.com/dreamRs/shinyWidgets"), ", ",
              tags$a("shinythemes", href = "https://rstudio.github.io/shinythemes/"), " y ",
      tags$li(tags$a("leaflet", href = "https://rstudio.github.io/leaflet/"), 
              ": para crear el mapa")),
      tags$li(tags$a("leaflet.extras", href = "https://github.com/bhaskarvk/leaflet.extras"), 
              ": para buscar una dirección en el mapa"),
      tags$li(tags$a("dplyr", href = "https://github.com/tidyverse/dplyr"),
              ": para manipular los datos"),
      tags$li(tags$a("Plotly", href = "https://plotly.com/r/"), "por su capacidad para hacer gráficos
              interactivos a pesar de la dificultad adicional que tiene hacer gráficas correlacionadas."),
      tags$li("Se han utilizado otros paquetes para pequeñas funcionalidades")
    ),#tags$ul

        tags$b("Autor: "), # tags$b : título
    tags$div("Esta aplicación ha sido realizada por Enrique Holgado de Frutos",
             tags$a(class = "btn btn-default", icon("github"), " @EnriqueHolgado", 
                    href = "https://github.com/Enriqueholgado", style = "background-color: #000000; color: #FFFFFF"
             )#tags$a
             ),#tags$div
      )#tags$div
}#function

