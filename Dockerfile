FROM nginx:latest

COPY ./mkdocs.conf /etc/nginx/conf.d/mkdocs.conf
COPY ./mkdocs/site /site

ARG MKDOCS_SERVER=localhost
RUN envsubst '$MKDOCS_SERVER' < /etc/nginx/conf.d/mkdocs.conf > /etc/nginx/conf.d/mkdocs.conf

RUN mkdir /etc/nginx/passwd
ARG BASIC_PASS
RUN echo $BASIC_PASS > /etc/nginx/passwd/tfdocs

CMD sed -e "/ listen / s/80/$PORT/" -i /etc/nginx/conf.d/default.conf && \
    envsubst '$PORT' < /etc/nginx/conf.d/mkdocs.conf > /etc/nginx/conf.d/mkdocs.conf && \
    nginx -g 'daemon off;'