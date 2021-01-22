# FROM ruby:2.7.2-alpine

# RUN apk add --update --no-cache \
#       binutils-gold \
#       build-base \
#       curl \
#       file \
#       g++ \
#       gcc \
#       git \
#       less \
#       libstdc++ \
#       libffi-dev \
#       libc-dev \
#       linux-headers \
#       libxml2-dev \
#       libxslt-dev \
#       libgcrypt-dev \
#       make \
#       netcat-openbsd \
#       openssl \
#       pkgconfig \
#       tzdata

# RUN mkdir -p /app
# WORKDIR /app
# # COPY test-app/ /app/
# COPY ./test-app/Gemfile ./test-app/Gemfile.lock ./

# RUN echo "gem: --no-document" >> ~/.gemrc
# RUN gem install bundler -v 2.1.4
# RUN bundle check || bundle install

# EXPOSE 3000

# ENTRYPOINT [ "bundle", "exec", "rails", "s", "-b", "0.0.0.0" ]

# # ENTRYPOINT [ "ls", "-l" ]

ARG RUBY_VERSION
FROM ruby:${RUBY_VERSION}-alpine

ARG BUNDLER_VERSION

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
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
      tzdata

RUN gem update --system && \
      gem install bundler:${BUNDLER_VERSION}

RUN mkdir -p /app
WORKDIR /app

COPY ./test-app/Gemfile ./test-app/Gemfile.lock ./

RUN bundle install

# ENTRYPOINT [ "ls", "-l", "/usr/local/bundle/gems" ]

# ENTRYPOINT [ "gem", "which", "activesupport" ]