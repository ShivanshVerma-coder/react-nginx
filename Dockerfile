FROM node:16-alpine as builder

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .
RUN npm run build

FROM nginx

#expose is used by aws elasticbeanstalk to expose the container port to the outside world
EXPOSE 80 

COPY --from=builder /app/build /usr/share/nginx/html