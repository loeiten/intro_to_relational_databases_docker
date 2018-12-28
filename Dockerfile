# Start from base
FROM ubuntu:18.04

# Intall apt dependencies
RUN apt-get -yqq update
RUN apt-get -yqq upgrade
RUN apt-get -yqq install make zip unzip postgresql
RUN apt-get -yqq install python3 python3-pip
RUN apt-get -qqy install python python-pip

# Install the pip dependecies
RUN pip3 install --upgrade pip
RUN pip3 install flask packaging oauth2client redis passlib flask-httpauth
RUN pip3 install sqlalchemy flask-sqlalchemy psycopg2-binary bleach requests

RUN pip2 install --upgrade pip
RUN pip2 install flask packaging oauth2client redis passlib flask-httpauth
RUN pip2 install sqlalchemy flask-sqlalchemy psycopg2-binary bleach requests

# Set the workdir
WORKDIR /vagrant/

# Add the files
ADD catalog/
ADD forum/
ADD tournament/

# Setup the database
RUN su postgres -c 'createuser -dRS vagrant'
RUN su vagrant -c 'createdb'
RUN su vagrant -c 'createdb news'
RUN su vagrant -c 'createdb forum'
RUN su vagrant -c 'psql forum -f /vagrant/forum/forum.sql'

# Install redis
ADD http://download.redis.io/redis-stable.tar.gz
RUN tar xvzf redis-stable.tar.gz
RUN cd redis-stable
RUN make
RUN make install

