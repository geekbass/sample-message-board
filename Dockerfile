FROM ruby:2.5.0

RUN apt-get update -qq \
	&& apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    nodejs \
    wget \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /mnt/rails

COPY Gemfile /mnt/rails/

COPY Gemfile.lock /mnt/rails/

WORKDIR /mnt/rails

RUN bundle install

COPY . /mnt/rails

EXPOSE 5000
