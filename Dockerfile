#FROM rocker/tidyverse:latest
FROM rocker/shiny:latest

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libxml2 \
    libcairo2-dev \
    libsqlite3-dev \
    libmariadbd-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libcurl4-openssl-dev \
    libssl-dev

## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get -y install r-cran-curl && \
    apt-get clean

# copy necessary files


## app folder
COPY /app ./app

# install renv & restore packages
RUN R -e "install.packages(c('leaflet', 'dplyr', 'httr', 'jsonlite', 'shinyWidgets', 'shiny', 'stringr', 'tidyverse', 'htmltools', 'leaflet.extras', 'leaflet.extras2', 'raster', 'plotly', 'crosstalk', 'shinydashboard', 'later', 'htmlwidgets'), repos='https://cloud.r-project.org/')"

# expose port
EXPOSE 3838

# run app on container start
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]
