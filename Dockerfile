# ETAPA 1: Compilar Angular
FROM node:22-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# ETAPA 2: Nginx
FROM nginx:alpine

# Borramos la configuración por defecto que te muestra esa pantalla chafa
RUN rm /etc/nginx/conf.d/default.conf

# Copiamos la app compilada
COPY --from=build /app/dist/CinemaUVEG /usr/share/nginx/html

# Copiamos TU nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]