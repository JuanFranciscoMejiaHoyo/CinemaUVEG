# ETAPA 1: Compilar la app de Angular
FROM node:22-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# ETAPA 2: Nginx
FROM nginx:alpine

# Copiamos el contenido directamente
COPY --from=build /app/dist/CinemaUVEG/browser /usr/share/nginx/html

# Configuración de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]