#!/bin/sh

# 1. Iniciar Nginx primero en segundo plano para que el puerto 80 local ya esté abierto
nginx

# 2. Iniciar el demonio de Tailscale en modo userspace
tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
sleep 3

# 3. Autenticar en Tailscale (efímero para autoremover la IP si Railway reinicia)
tailscale up --authkey=${TS_AUTHKEY} --hostname=railway-web --accept-routes --ephemeral

# 4. Enlazar el tráfico web de la VPN directamente al Nginx local
tailscale serve --bg http://127.0.0.1:80

# 5. Mantener el contenedor en ejecución
sleep infinity
