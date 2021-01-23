FROM ruby:2.6.4

RUN apt-get update && \
  apt-get install -y bash postgresql-client nodejs --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*
RUN gem install bundler rerun rb-fsevent

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install needed gems
ADD Gemfile /usr/src/app/
ADD Gemfile.lock /usr/src/app/
RUN bundle install

ENV PATH="/usr/local/bundle/bin:${PATH}"

# Copy project files
# COPY . /usr/src/app
ADD . /usr/src/app

# script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
