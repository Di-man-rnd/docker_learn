# docker_learn
Learn docker 
----------------------------

*****Автоматизация с  использованием Compose*****
инструкции по установке Compose
http://docs.docker.com/compose/install/

$ docker-compose build
$ docker-compose up -d

********************************
EXPOSE 9090 9191 

docker run -P -сам проставит соответствие портов для 9090 ....
docker port .....
---------------------------------
стр. 90

docker build -t identidock .
docker run -d -p 5000:5000 identidock
docker run -d -p 5000:5000 -v "$(pwd)"/app:/app identidock
------------------------------------
docker build -t identidock .
docker run -d --name dnmonster amouat/dnmonster:1.0
docker run -d -p 5000:5000 -e "ENV=DEV" --link dnmonster:dnmonster identidock





------------------------------------------------
# docker help 

- logs -> выводит лог |  172.17.0.1 - - [19/Jul/2018 09:49:26] "GET / HTTP/1.1" 200 -


