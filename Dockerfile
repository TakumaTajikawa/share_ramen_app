FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn chromium-driver
RUN mkdir /share_ramen_app
WORKDIR /share_ramen_app
COPY Gemfile /share_ramen_app/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /share_ramen_app
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]