FROM rocker/shiny:latest

# Copiar todo el contenido del repo al contenedor
COPY . /srv/shiny-server/

# Exponer el puerto
EXPOSE 3838

# Comando de inicio
CMD ["/usr/bin/shiny-server"]
