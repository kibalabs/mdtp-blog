FROM node:16.13.0 as build

WORKDIR /app

COPY ./theme-casper/package.json .
COPY ./theme-casper/yarn.lock .
RUN yarn install
COPY ./theme-casper/ .
RUN yarn zip

FROM ghost:5.88.1

# NOTE(krishan711): overwrite default entrypoint
COPY docker-entrypoint.sh /usr/local/bin

RUN apt-get update -y && apt-get install -y zip

COPY --from=build /app/dist /var/lib/ghost/content.orig/themes
RUN find /var/lib/ghost/content.orig/themes/ -name '*.zip' -exec sh -c 'unzip -d "${1%.*}" "$1"' _ {} \;
