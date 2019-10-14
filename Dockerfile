FROM ruby:2.6.3
WORKDIR /pinterest
ADD . /pinterest

ENV RAILS_ENV production

ENV DEVISE_SECRET_KEY 'aa5d30bf3b219a1c9efda32edde7dde0b3df9caf44c2ee665563540f98ac4a36e85c756f5bb0f51c311cb56c86b62a6efc666f0f0bde25d47ff130bfa2850515'
ENV SECRET_KEY_BASE '1edec954827cf476cc07bc7a305c8504556eccfd02bc8ce38354786e62f4face0627b61ee1c834961d0c0e6c6afc995cf12a13fc46e0cb5c98e4abfacef1353c'

RUN rm -rf /pinterest/vendor/bundle/ruby/2.6.0/cache/nokogiri-1.10.4.gem
RUN bundle install --deployment --without development test \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt install -y nodejs && bundle exec rake assets:precompile


EXPOSE 3000

CMD ./entry.sh
