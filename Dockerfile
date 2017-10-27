FROM debian:stretch

MAINTAINER M3philis <m3philis@m3philis.de>

ENV STEAM_ACC=0123456789ABCDEF
ENV AUTHKEY=0123456789ABCDEF
ENV COLLECTIONID=07C1A2E0D0B8F32055626FC481A65085

RUN apt update -y \
		&& apt dist-upgrade -y \
		&& apt install -y vim wget lib32gcc1 lib32ncurses5 dumb-init

RUN mkdir -p /steam/{bin,gmod,css}

WORKDIR /steam/bin

RUN wget http://media.steampowered.com/client/steamcmd_linux.tar.gz \
		&& tar xvzf steamcmd_linux.tar.gz

RUN /steam/bin/steamcmd.sh +login anonymous +quit
RUN/steam/bin/steamcmd.sh +force_install_dir "/steam/gmod" +login anonymous +app_update 4020 validate +quit
RUN /steam/bin/steamcmd.sh +force_install_dir "/steam/css" +login anonymous +app_update 232330 validate +quit

RUN cp /steam/bin/linux32/libstdc++.so.6 /steam/gmod/bin/libstdc++.so.6

ADD ./mount.cfg /steam/gmod/garrysmod/cfg/mount.cfg
ADD ./server.cfg /steam/gmod/garrysmod/cfg/server.cfg

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "/steam/gmod/srcds_run", "-console -authkey $AUTHKEY -game garrysmod +maxplayers 16 +map ttt_waterworld +gamemode terrortown +sv_setsteamaccount $STEAM_ACC +host_workshop_collection $COLLECTIONID" ]


