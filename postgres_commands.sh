#!/usr/bin/env bash

service postgresql start
su postgres -c 'createuser -dRS new_user'
# Add a blank user to avoid "No passwd entry for user 'new_user'"
adduser --disabled-password --gecos "" new_user
su new_user -c 'createdb'
su new_user -c 'createdb news'
su new_user -c 'createdb forum'
su new_user -c 'psql forum -f /added_dirs/forum/forum.sql'
su new_user
/bin/bash

