FROM python:3.6.4-alpine3.7

COPY ./requirements.txt /
RUN pip install -r /requirements.txt
