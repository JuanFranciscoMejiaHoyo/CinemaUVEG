# ETAPA 1: Compilar Angular
FROM node:22-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# ETAPA 2: Nginx
FROM nginx:alpine

# 1. Borramos TODO el contenido por defecto de Nginx (incluido su index.html)
RUN rm -rf /usr/share/nginx/html/*

# 2. Borramos el archivo de conf por defecto
RUN rm /etc/nginx/conf.d/default.conf

# 3. Copiamos TU app compilada
COPY --from=build /app/dist/CinemaUVEG /usr/share/nginx/html

# 4. Copiamos TU nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]