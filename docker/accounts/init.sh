#!/bin/bash

if [ -f .env ]
then
    # export vars from .env file
    set -a
    . ./.env

    if [ -z "$USERNAME" ]
    then 
        echo "A file named .env is expected and should contain following vars definition:"
        echo "USERNAME={domain-name-as-user-name}"
        echo "PASSWORD={user-password}"        
        echo "TEMPLATE={account-template}"
    else

        # create a new user
        adduser --force-badname --disabled-password --gecos ",,," $USERNAME
        echo "$USERNAME:$PASSWORD" | sudo chpasswd
        

        # set the home directory of the new user (FTP access)
        mkdir /home/$USERNAME/www
        sudo usermod -d /home/$USERNAME/www $USERNAME
        
        
        # add write permission to group over the www directory of the user        
        chmod g+w -R /home/$USERNAME/www

        # restart SFTP service (to enable ftp login at user home)
        sudo systemctl restart vsftpd

        # add account to docker group
        sudo usermod -a -G docker $USERNAME
        
        # define ssh-login as shell for user account
        sudo chsh -s /usr/local/bin/ssh-login $USERNAME

        # copy docker-compose files
        cp -r /home/nabu/docker/templates/$TEMPLATE/. /home/$USERNAME/
        
        echo "DOMAIN_NAME=$USERNAME" >> /home/$USERNAME/.env
        echo "DOMAIN_CONTACT=info@$USERNAME" >> /home/$USERNAME/.env        
        
        cd /home/$USERNAME
        
        # stop auto export
        set +a
    fi
else
    echo ".env file is missing"
fi
