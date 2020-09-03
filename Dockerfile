# Stage 1

FROM node:10-alpine as build-step
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
RUN npm run build --prod



# Stage 2
FROM nginx:1.17.1-alpine as prod-step
COPY --from=build-step /app/dist/ng-docker-app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
