FROM node:16.13.0 as build

WORKDIR /app

COPY ./theme-casper/package.json .
COPY ./theme-casper/yarn.lock .
RUN yarn install
COPY ./theme-casper/ .
RUN yarn zip

FROM ghost:5.2.3

RUN apt-get update -y && apt-get install -y zip

COPY --from=build /app/dist /var/lib/ghost/content.orig/themes
RUN find /var/lib/ghost/content.orig/themes/ -name '*.zip' -exec sh -c 'unzip -d "${1%.*}" "$1"' _ {} \;
RUN [ -d /var/lib/ghost/content.orig/themes/ ] && cp -R /var/lib/ghost/content.orig/themes /var/lib/ghost/content/themes
RUN cat /var/lib/ghost/content.orig/themes/casper-mdtp/page.hbs
RUN cat /var/lib/ghost/content/themes/casper-mdtp/page.hbs
