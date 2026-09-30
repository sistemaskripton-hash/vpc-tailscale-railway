#!/bin/sh

# Iniciar Tailscale en background en modo usuario
tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
sleep 5

# Autenticar y ACEPTAR las rutas enviadas por el MikroTik (10.105.0.0/16)
tailscale up --authkey=${TS_AUTHKEY} --hostname=railway-test-web --accept-routes

# Exponer el puerto 80 de Nginx hacia la red de Tailscale
tailscale serve --bg http://localhost:80

# Iniciar Nginx
nginx -g "daemon off;"
