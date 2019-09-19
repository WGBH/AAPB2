#FROM phusion/passenger-full
#FROM nginx:latest
FROM ruby:2.4.7-stretch

WORKDIR /var/www/aapb

COPY . .

# each run line adds a 'layer' to the image, which will each end up in the final compiled image
# https://stackoverflow.com/questions/39223249/multiple-run-vs-single-chained-run-in-dockerfile-what-is-better

RUN apt-get update && apt-get -y install curl libcurl3 libcurl3-openssl-dev openjdk-8-jdk && apt-get clean && gem install curb -v '0.9.7' --source 'https://rubygems.org/' && bundle install && rake db:setup && rake jetty:config && rake jetty:start

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-b", "tcp://127.0.0.1:3000", "-C", "config/puma.rb"]
