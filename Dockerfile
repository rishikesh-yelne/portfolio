# syntax=docker/dockerfile:1.2
FROM node:16.15.0-alpine as BUILDER

WORKDIR /tmp/build/

COPY package.json package-lock.json ./
RUN npm install

COPY src src
COPY angular.json ts* ./

ARG HREF="/"
ARG ENV="development"
RUN npx ng build --base-href="$HREF" --configuration="$ENV"


FROM nginx:1.22.1-alpine as RUNNER

ARG HREF="/"

RUN echo "server{listen 4200;location /{root /usr/share/nginx/html;index index.html;try_files \$uri ${HREF}index.html \$uri/ =404;}}" > /etc/nginx/conf.d/default.conf \
  && rm -rf /usr/share/nginx/html/*
COPY --from=BUILDER /tmp/build/dist/portfolio /usr/share/nginx/html$HREF

HEALTHCHECK --start-period=3s --interval=10s --timeout=3s --retries=3 \
  CMD wget --quiet --tries=1 --spider localhost:4200$HREF || exit 1
