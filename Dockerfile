FROM ruby:2.7
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client vim

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

RUN mkdir /deploy_app
WORKDIR /deploy_app
COPY Gemfile /deploy_app/Gemfile
COPY Gemfile.lock /deploy_app/Gemfile.lock
RUN bundle install
COPY . /deploy_app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]