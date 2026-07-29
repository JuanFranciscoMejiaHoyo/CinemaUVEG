# ETAPA 1: Compilar Angular
FROM node:22-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# ETAPA 2: Nginx
FROM nginx:alpine

# Limpieza
RUN rm -rf /usr/share/nginx/html/*
RUN rm /etc/nginx/conf.d/default.conf

# COPIAR DESDE /browser PARA QUE EL index.html QUEDE EN LA RAÍZ DE NGINX
COPY --from=build /app/dist/CinemaUVEG/browser /usr/share/nginx/html

# Tu configuración de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]