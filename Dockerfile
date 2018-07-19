#------ запуск на прямую flask-a -------
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

#-----   добавили пользователя от которого запустим uWSGI, -----
#-----   объявим порты явно                                -----
#FROM python:3.4
#RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi
#RUN pip install Flask==0.10.1 uWSGI==2.0.13
#WORKDIR /app
#COPY app /app
#EXPOSE 9090 9191 
#USER uwsgi 
#CMD ["uwsgi", \
#	"--http", "0.0.0.0:9090", \
#	"--wsgi-file", "/app/identidock.py", \
#	"--callable", "app", \
#	"--stats", "0.0.0.0:9191"]


#-(1)----  Свести к минимуму различия в среде для разработки и продакшина -----
#-----  создайте файл cmd.sh со следующим содержимым                   -----
FROM python:3.4
RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi
RUN pip install Flask==0.10.1 uWSGI==2.0.13 requests==2.5.1 redis==2.10.3
WORKDIR /app
COPY app /app
COPY cmd.sh /
EXPOSE 9090 9191 
USER uwsgi 
CMD ["/cmd.sh"]

# ----- запуск докера (1) -----
#$ chmod +x cmd.sh
#$ docker build -t identidock .
#...
#$ docker run -it --rm -p 5000:5000 -e "ENV=DEV" identidock
#$ docker run -it --rm -P                        identidock



