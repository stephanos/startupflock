FROM gcr.io/google-appengine/debian8

RUN apt-get update -y \
    && apt-get install --no-install-recommends -y -q build-essential ca-certificates curl git \
    && apt-get clean \
    && rm /var/lib/apt/lists/*_* \
    && cd /opt \
    && mkdir nodejs \
    && curl https://nodejs.org/dist/v7.9.0/node-v7.9.0-linux-x64.tar.gz | tar xzf - -C /opt/nodejs --strip-components=1 \
    && cd /opt \
    && mkdir yarn \
    && curl -o- -L https://yarnpkg.com/latest.tar.gz | tar zxf - -C /opt/yarn --strip-components=1

ENV NODE_ENV="production" \
    NODE_PATH="/opt/node_modules" \
    PATH="/opt/yarn/bin:/opt/nodejs/bin:$PATH"

ADD package.json yarn.lock /opt/
RUN cd /opt \
    && yarn install --production

WORKDIR /app

CMD ["yarn", "start"]