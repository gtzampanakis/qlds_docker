FROM ubuntu:17.10

RUN apt-get update && apt-get install -y lib32gcc1 curl 
RUN useradd -m steam

USER steam
WORKDIR /home/steam
RUN mkdir Steam
WORKDIR /home/steam/Steam
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

RUN ./steamcmd.sh +login anonymous +force_install_dir ./steamapps/common/qlds/ +app_update 349090 +quit

EXPOSE 27960/udp
EXPOSE 28960/tcp

WORKDIR /home/steam

ADD launch.sh .

RUN mkdir .quakelive
RUN mkdir .quakelive/baseq3
ADD mappool.txt .quakelive/baseq3
ADD access.txt .quakelive/baseq3

ENTRYPOINT ["./launch.sh"]
