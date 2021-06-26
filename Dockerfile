FROM klakegg/hugo:0.83.1-ubuntu-ci as build

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y npm
    
COPY ./ /app
WORKDIR /app

# https://github.com/npm/cli/issues/681#issuecomment-793916156
RUN npm install -g n
RUN n lts
RUN npm install -g npm
# RUN hash -d npm

RUN npm install
RUN hugo

FROM nginx:alpine
COPY --from=build /app/public /usr/share/nginx/html

WORKDIR /usr/share/nginx/html

