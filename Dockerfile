## Pasos a realizar en la imagen del docker
## Usar la version de phyton
## Quien realiza el mantenimiento
## Ambiente en que se esta trabajando y evita retrazos en las respuestas
## Copia lo que esta en el archivo de requerimientos
## Copia lo que esta en el archivo app
## Directorio por defecto en el cual se esta trabajando (donde esta el proyecto Django)
## El puerto que se va a exponer
## Comandos que va a correr de forma automatica (si esta en entorno de desarollo corra el archivo requirements.dev.txt)
## Ruta de archivo de variables de entorno
## Usuario


FROM python:3.9-alpine3.13  
LABEL maintainer="phoenixsoftwaredesigns.com"

ENV PHYTONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r requirements.dev.txt ; \
    fi && \    
    rm -rf /tmp && \
    adduser \
    --disabled-password \
    --no-create-home \
    django-user

ENV PATH="/py/bin:$PATH"

USER django-user