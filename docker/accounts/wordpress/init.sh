#!/bin/bash

if [ -f ../.env ]
then
    # assign ownership to user and www-data (group)
    chown -R $USERNAME:www-data /home/$USERNAME/www    
    
else
    echo ".env file is missing"
fi

