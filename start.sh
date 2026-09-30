#!/bin/sh

# Iniciar Tailscale en background sin requerir privilegios de red
tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
sleep 5

# Autenticarse usando la variable de entorno que pondremos en Railway
tailscale up --authkey=${TS_AUTHKEY} --hostname=railway-test-web

# Iniciar Nginx en primer plano para que el contenedor no se apague
nginx -g "daemon off;"

