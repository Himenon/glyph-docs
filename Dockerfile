FROM python:3.6.4-alpine3.7 AS build-mkdocs

COPY ./requirements.txt /
RUN pip install -r /requirements.txt

RUN mkdir -p /src
COPY ./mkdocs /src

WORKDIR /src
RUN mkdocs build

# ------------------------------------------------------------

FROM nginx:latest

COPY --from=build-mkdocs /src/site /site
COPY ./nginx/mkdocs.conf /etc/nginx/conf.d/mkdocs.conf

ARG MKDOCS_SERVER=localhost
RUN envsubst '$MKDOCS_SERVER' < /etc/nginx/conf.d/mkdocs.conf > /etc/nginx/conf.d/mkdocs.conf

RUN mkdir /etc/nginx/passwd
ARG BASIC_PASS
RUN echo $BASIC_PASS > /etc/nginx/passwd/tfdocs

CMD sed -e "/ listen / s/80/$PORT/" -i /etc/nginx/conf.d/default.conf && \
    envsubst '$PORT' < /etc/nginx/conf.d/mkdocs.conf > /etc/nginx/conf.d/mkdocs.conf && \
    nginx -g 'daemon off;'