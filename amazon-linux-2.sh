#!/usr/bin/env bash

exit

#---------------------------------------------------------------------------------------------------

printf "\n\n\n\n" && cat ~/.bashrc
LL_ALIAS_COMMAND='alias ll="ls --time-style='"'"'+%Y-%m-%d %H:%M:%S'"'"' -AlFh --color"'
echo "">>~/.bashrc
echo "${LL_ALIAS_COMMAND}">>~/.bashrc
echo 'alias llll='"'"'printf "\n\n\n\n"'"'"''>>~/.bashrc
printf "\n\n\n\n" && cat ~/.bashrc
source ~/.bashrc

#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && sudo yum -y update
#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------
# Java
#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && which javac java
printf "\n\n\n\n" && sudo yum search java | grep -E 'java-.*-openjdk-devel'
printf "\n\n\n\n" && sudo yum -y install java-1.8.0-openjdk-devel
printf "\n\n\n\n" && which javac && javac -version
printf "\n\n\n\n" && which java && java -version

#---------------------------------------------------------------------------------------------------
# Git
#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && which git
printf "\n\n\n\n" && sudo yum search git
printf "\n\n\n\n" && sudo yum info git
printf "\n\n\n\n" && sudo yum -y install git
printf "\n\n\n\n" && which git && git --version

#---------------------------------------------------------------------------------------------------
# Python
#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && which python
printf "\n\n\n\n" && sudo yum info python
printf "\n\n\n\n" && which python && python --version

#---------------------------------------------------------------------------------------------------
# Perl
#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && which perl
printf "\n\n\n\n" && sudo yum info perl
printf "\n\n\n\n" && which perl && perl --version

#---------------------------------------------------------------------------------------------------
# NodeJS
#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && which node npm
#printf "\n\n\n\n" && curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
#printf "\n\n\n\n" && source ~/.nvm/nvm.sh
#printf "\n\n\n\n" && nvm install --lts
printf "\n\n\n\n" && curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
printf "\n\n\n\n" && sudo yum -y install nodejs
printf "\n\n\n\n" && which node && node -v
printf "\n\n\n\n" && which npm && npm -v

#---------------------------------------------------------------------------------------------------
# Yarn
#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && which yarn
printf "\n\n\n\n" && curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
printf "\n\n\n\n" && sudo yum info yarn
printf "\n\n\n\n" && sudo yum -y install yarn
printf "\n\n\n\n" && which yarn && yarn -v

#---------------------------------------------------------------------------------------------------
# Nginx
#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && which nginx
printf "\n\n\n\n" && sudo amazon-linux-extras list | grep nginx
printf "\n\n\n\n" && sudo amazon-linux-extras install nginx1.12
printf "\n\n\n\n" && which nginx && nginx -v


#---------------------------------------------------------------------------------------------------
# HAProxy
#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && which haproxy
printf "\n\n\n\n" && sudo yum -y install gcc pcre-static pcre-devel openssl openssl-devel systemd-devel
printf "\n\n\n\n" && wget https://www.haproxy.org/download/1.8/src/haproxy-1.8.12.tar.gz -O haproxy-1.8.12.tar.gz
printf "\n\n\n\n" && md5sum haproxy-1.8.12.tar.gz
# 9f37013ec1e76942a67a9f7c067af9f2  haproxy-1.8.12.tar.gz
printf "\n\n\n\n" && tar xzvf haproxy-1.8.12.tar.gz
printf "\n\n\n\n" && cd haproxy-1.8.12/
# make
printf "\n\n\n\n" && make TARGET=linux2628 USE_PCRE=1 USE_OPENSSL=1 USE_ZLIB=1 USE_SYSTEMD=1
# install HAProxy
printf "\n\n\n\n" && sudo make install
# confirm HAProxy
printf "\n\n\n\n" && which haproxy && haproxy -v
# add service
printf "\n\n\n\n" && sudo systemctl list-unit-files | grep haproxy
printf "\n\n\n\n" && cd contrib/systemd/
printf "\n\n\n\n" && make
printf "\n\n\n\n" && sudo rsync -arvt haproxy.service /etc/systemd/system/haproxy.service
printf "\n\n\n\n" && sudo chown root:root /etc/systemd/system/haproxy.service
printf "\n\n\n\n" && sudo chmod 644 /etc/systemd/system/haproxy.service
printf "\n\n\n\n" && sudo systemctl daemon-reload
printf "\n\n\n\n" && sudo systemctl list-unit-files | grep haproxy
# create config file
(cat <<- TEMP_BASH_HERE_DOCUMENT
global
    #chroot /var/lib/haproxy
    #user haproxy
    #group haproxy
    #log 127.0.0.1 local2
    #tune.ssl.default-dh-param 2048
    #maxpipes 100000
    #tune.maxaccept 100000
    #ulimit-n 100000
    maxconn 100000
    daemon
    master-worker
    #stats socket /var/lib/haproxy/stats mode 660 expose-fd listeners level admin
    stats socket /var/run/haproxy.sock mode 600 expose-fd listeners level admin
    stats timeout 30s

defaults
    log global
    mode tcp
    maxconn 100000
    #option httplog
    option dontlognull
    timeout connect 7000ms
    timeout client 101000ms
    timeout server 101000ms

listen stats
    bind *:8099
    #bind *:8099 ssl crt /etc/ssl/congacon.pem
    mode http
    maxconn 1000
    stats enable
    stats uri /haproxy?stats
    stats realm Haproxy\ Statistics
    # user:pass
    stats auth congacon:congacon
TEMP_BASH_HERE_DOCUMENT
) > haproxy.cfg
printf "\n\n\n\n" && cat haproxy.cfg
printf "\n\n\n\n" && haproxy -c -V -f haproxy.cfg
printf "\n\n\n\n" && sudo mkdir -p /etc/haproxy/
printf "\n\n\n\n" && sudo rsync -arvt haproxy.cfg /etc/haproxy/haproxy.cfg
printf "\n\n\n\n" && sudo chown root:root /etc/haproxy/haproxy.cfg
printf "\n\n\n\n" && sudo chmod 644 /etc/haproxy/haproxy.cfg
# start service
printf "\n\n\n\n" && sudo systemctl restart haproxy
# view status
printf "\n\n\n\n" && sudo systemctl status -l haproxy
cd ~
