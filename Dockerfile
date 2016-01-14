FROM docker/whalesay:latest
RUN apt-get -y update && apt-get install -y fortunes
RUN apt-get -y update
CMD /usr/games/fortune -a | cowsay
