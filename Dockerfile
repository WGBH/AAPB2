#FROM phusion/passenger-full:<VERSION>
FROM phusion/passenger-full

WORKDIR /var/www/aapb

COPY . .

# each run line adds a 'layer' to the image, which will each end up in the final compiled image
# https://stackoverflow.com/questions/39223249/multiple-run-vs-single-chained-run-in-dockerfile-what-is-better

RUN apt-get update && apt-get -y install curl libcurl4 libcurl4-openssl-dev && gem install curb -v '0.9.7' --source 'https://rubygems.org/' && bundle install

EXPOSE 80

CMD ["ruby", "./test-crap.rb"]