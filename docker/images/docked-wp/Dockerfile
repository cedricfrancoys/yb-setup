FROM wordpress:4.9.8
LABEL   Description="Latest version of Wordpress with Apache UID and GUID injection" \
        Maintainer="Cedric Francoys <cedricfrancoys@gmail.com>" \
        License="Apache License 2.0" \
        Version="1.0"

ARG apache_uid
ARG apache_gid

RUN /usr/sbin/usermod -u $apache_uid www-data && /usr/sbin/groupmod -g $apache_gid www-data