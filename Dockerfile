FROM debian:stretch

MAINTAINER M3philis <m3philis@m3philis.de>

RUN apt-get update -y \
		&& apt-get dist-upgrade -y \
		&& apt-get install -y vim wget lib32gcc1

RUN mkdir -p /steam/{bin,gmod,css}

WORKDIR /steam/bin

RUN wget http://media.steampowered.com/client/steamcmd_linux.tar.gz \
		&& tar xvzf steamcmd_linux.tar.gz

RUN /steam/bin/steamcmd.sh +login anonymous +quit \
		&& /steam/bin/steamcmd.sh +force_install_dir "/steam/gmod" +login anonymous +app_update 4020 validate +quit \
		&& /steam/bin/steamcmd.sh +force_install_dir "/steam/css" +login anonymous +app_update 232330 validate +quit

ADD ./mount.cfg /steam/gmod/garrysmod/cfg/mount.cfg
ADD ./server.cfg /steam/gmod/garrysmod/cfg/server.cfg

CMD [ '/steam/gmod/srcds_run -console _game garrysmod +maxplayer 16 +map gm_construct +gamemode terrortown' ]

