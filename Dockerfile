FROM ruby:2.6.3
WORKDIR /pinterest
ADD . /pinterest

# Set Rails environment to production
ENV RAILS_ENV production

ENV DEVISE_SECRET_KEY 'aa5d30bf3b219a1c9efda32edde7dde0b3df9caf44c2ee665563540f98ac4a36e85c756f5bb0f51c311cb56c86b62a6efc666f0f0bde25d47ff130bfa2850515'
ENV SECRET_KEY_BASE '1edec954827cf476cc07bc7a305c8504556eccfd02bc8ce38354786e62f4face0627b61ee1c834961d0c0e6c6afc995cf12a13fc46e0cb5c98e4abfacef1353c'

# Start the application server
RUN bundle install --deployment --without development test \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt install -y nodejs && bundle exec rake db:schema:load \
    && bundle exec rake attachinary:install:migrations \
    && bundle exec rake assets:precompile && bundle exec rake db:migrate


EXPOSE 3000

CMD ./entry.sh
