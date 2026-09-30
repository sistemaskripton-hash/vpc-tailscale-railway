#!/bin/sh

# 1. Iniciar Nginx en segundo plano (puerto 80 abierto)
nginx

# 2. Iniciar el demonio de Tailscale en modo userspace
tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
sleep 3

# 3. Autenticar en Tailscale y aceptar rutas
tailscale up --authkey=${TS_AUTHKEY} --hostname=railway-web --accept-routes

# 4. Enlazar la VPN directamente al Nginx local
tailscale serve --bg http://127.0.0.1:80

# 5. Mantener el contenedor encendido
sleep infinity
