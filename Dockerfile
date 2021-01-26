ARG RUBY_VERSION
FROM ruby:${RUBY_VERSION}-alpine

ARG BUNDLER_VERSION

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      mariadb-dev \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      openssl \
      pkgconfig \
      tzdata \
      libc6-compat && \
      ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2

# gem update --system &&
#  rm /usr/local/lib/ruby/gems/*/specifications/default/bundler-*.gemspec &&
# gem uninstall bundler &&
# RUN \
#       \
#        \
#       gem install bundler:${BUNDLER_VERSION}

RUN mkdir -p /app
WORKDIR /app

COPY ./test-app/Gemfile ./test-app/Gemfile.lock ./

# RUN mkdir /root/.bundle/ && echo -e '--- \nBUNDLE_PATH: "vendor/bundle"' > /root/.bundle/config

RUN bundle install

STOPSIGNAL SIGTERM

# ENTRYPOINT [ "ls", "-l", "/usr/local/bundle/gems" ]

# ENTRYPOINT [ "gem", "which", "activesupport" ]