# ETAPA 1: Compilar Angular
FROM node:22-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# ETAPA 2: Nginx
FROM nginx:alpine

# Copiar DIRECTO desde /app/dist/CinemaUVEG (sin /browser)
COPY --from=build /app/dist/CinemaUVEG /usr/share/nginx/html

# Configuración Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]