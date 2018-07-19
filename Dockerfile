###  запуск на прямую flask-a
#FROM python:3.4
#RUN pip install Flask==0.10.1
#WORKDIR /app
#COPY app /app
#CMD ["python", "identidock.py"]

###   запуск через uWSGI
#FROM python:3.4
#RUN pip install Flask==0.10.1 uWSGI==2.0.13
#WORKDIR /app
#COPY app /app
#CMD ["uwsgi", \
#	"--http", "0.0.0.0:9090", \
#	"--wsgi-file", "/app/identidock.py", \
#	"--callable", "app", \
#	"--stats", "0.0.0.0:9191"]

###   добавили пользователя от которого запустим uWSGI,
###   объявим порты явно 
FROM python:3.4

RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi
RUN pip install Flask==0.10.1 uWSGI==2.0.13
WORKDIR /app
COPY app /app
EXPOSE 9090 9191 
USER uwsgi 
CMD ["uwsgi", \
	"--http", "0.0.0.0:9090", \
	"--wsgi-file", "/app/identidock.py", \
	"--callable", "app", \
	"--stats", "0.0.0.0:9191"]