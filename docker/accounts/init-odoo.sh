#!/bin/bash
# This script has t obe run after general user initialisation: init.sh

# Create a odoo user (to link host with VM), no home, no login, no prompt
adduser --no-create-home --disabled-login --gecos "" nabu

# Build docked-odoo image
cd /home/docker/images/docked-odoo/
/home/docker/images/docked-odoo/build.sh

# Edit account parameters and then Run script for account creation
cd /home/docker/accounts
vi .env ; /home/docker/accounts/init.sh


cd /home/$USERNAME

echo "retrieving addons from github repositories"
git config --global credential.helper cache
git clone https://github.com/odoo/enterprise --depth 1 --branch 12.0 --single-branch ./odoo/enterprise
git clone https://github.com/ARTECOM/odoo-external.git ./odoo/external
git clone https://github.com/ARTECOM/odoo-artecom.git ./odoo/custom

chown odoo:odoo -R /home/$USERNAME/odoo