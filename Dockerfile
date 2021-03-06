FROM siomiz/softethervpn:ubuntu
ADD https://raw.githubusercontent.com/glotoff/docker/master/vpn_server.config /usr/vpnserver/
EXPOSE 80
RUN apt-get --assume-yes update
RUN apt-get --assume-yes install software-properties-common
RUN add-apt-repository ppa:certbot/certbot
RUN apt-get --assume-yes update
RUN apt-get --assume-yes install certbot
ONBUILD RUN certbot --agree-tos --email glotoff@gmail.com certonly --standalone -n -d lightsail.glotov.net
ONBUILD RUN vpncmd localhost:443 /SERVER /ADMINHUB:DEFAULT /PASSWORD:${vpnpwd} /CMD ServerCertSet /LOADCERT:/etc/letsencrypt/live/lightsail.glotov.net/fullchain.pem /LOADKEY:/etc/letsencrypt/live/lightsail.glotov.net/privkey.pem
ONBUILD RUN vpncmd localhost:443 /SERVER /ADMINHUB:DEFAULT /PASSWORD:${vpnpwd} /CMD UserPasswordSet test ${vpnpwd}
