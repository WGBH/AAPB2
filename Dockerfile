#FROM phusion/passenger-full
#FROM nginx:latest
FROM ruby:2.4.7-stretch

# each run line adds a 'layer' to the image, which will each end up in the final compiled image
# https://stackoverflow.com/questions/39223249/multiple-run-vs-single-chained-run-in-dockerfile-what-is-better

ENV BUNDLE_PATH /var/bundle
ENV AAPB_SOLR_HOST 'docker-aapb_solr_1'

RUN apt-get update && apt-get -y install curl libcurl3 libcurl3-openssl-dev openjdk-8-jdk && apt-get clean


# cache the stupid bundle
WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
ADD ./cmless/ cmless/
RUN bundle install

WORKDIR /var/www/aapb
COPY . .

# RUN bundle exec ruby scripts/download_clean_ingest.rb --stdout-log --files /var/www/aapb/spec/fixtures/pbcore/clean-*.xml 

EXPOSE 3000

# CMD ["bundle", "exec", "puma", "-b", "unix:///var/sockets/puma.sock", "-C", "config/puma.rb"]
CMD ["bundle", "exec", "puma", "-b", "unix:///var/sockets/puma.sock", "-C", "config/puma.rb"]



 #&& rake jetty:config && rake jetty:start


# MS word apostrophes BREAK cmless in teh docker ruby environment... causes the document to end, making any content after stupid apostrophe  missing in parsed xml doc



# containers are by default reacable with CONTAINER ID as their hostname. specified by hostname: option in compose file