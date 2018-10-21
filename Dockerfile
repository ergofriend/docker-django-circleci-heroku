FROM python:3.6-alpine
ENV PYTHONUNBUFFERED 1
# Creating working directory
RUN mkdir /application
WORKDIR /application
# Copying requirements
ADD requirements.txt /application
COPY ./application/ .
RUN apk add --no-cache --virtual .build-deps \
    ca-certificates gcc postgresql-dev linux-headers musl-dev \
    libffi-dev jpeg-dev zlib-dev \
    && pip install -r requirements.txt

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku
#CMD [ "python", "./manage.py", "runserver", "0.0.0.0:8000"]
CMD gunicorn --bind 0.0.0.0:$PORT application.wsgi