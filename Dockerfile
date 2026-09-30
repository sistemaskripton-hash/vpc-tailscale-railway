FROM nginx:alpine
# Instalar Tailscale y dos2unix para arreglar los scripts de Windows
RUN apk add --no-cache tailscale dos2unix
# Copiar el script de inicio
COPY start.sh /start.sh
# Limpiar saltos de linea de Windows a Linux y dar permisos
RUN dos2unix /start.sh && chmod +x /start.sh
# Exponer el puerto de Nginx
EXPOSE 80
# Iniciar mediante el script
CMD ["/start.sh"]
