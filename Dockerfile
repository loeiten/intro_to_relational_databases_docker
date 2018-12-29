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
WORKDIR /added_dirs/

# Add the files
ADD catalog/ /added_dirs/catalog/
ADD forum/ /added_dirs/forum/
ADD tournament/ /added_dirs/tournament/

# Install redis
WORKDIR /opt/
ADD http://download.redis.io/redis-stable.tar.gz redis-stable.tar.gz
RUN tar -xvzf redis-stable.tar.gz
WORKDIR /opt/redis-stable
RUN make
RUN make install

# Setup the user
ADD postgres_commands.sh /postgres_commands.sh
RUN chmod +x /postgres_commands.sh
WORKDIR /home/new_user/
ENTRYPOINT ["/postgres_commands.sh"]

