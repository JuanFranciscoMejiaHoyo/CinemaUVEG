# ETAPA 1: Compilar la app de Angular
FROM node:22-alpine AS build
WORKDIR /app

# Copiar archivos de dependencias e instalar
COPY package*.json ./
RUN npm ci

# Copiar el código fuente y compilar
COPY . .
RUN npm run build

# ETAPA 2: Servir los archivos estáticos con Nginx
FROM nginx:alpine
# Copiar el build compilado al directorio de Nginx
# (Si tu carpeta en dist tiene otro nombre, ajústalo aquí)
COPY --from=build /app/dist/cinema-uveg/browser /usr/share/nginx/html

# Copiar configuración personalizada de Nginx para el ruteo de Angular
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]