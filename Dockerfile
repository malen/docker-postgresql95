FROM malen/docker-centos72:latest
RUN apt-get -y update && apt-get install -y fortunes
RUN apt-get -y update
CMD /usr/games/fortune -a | cowsay
