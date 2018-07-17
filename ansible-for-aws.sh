#!/usr/bin/env bash

#---------------------------------------------------------------------------------------------------
exit
#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && sudo yum -y update
#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------
# Python 2
#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && which python && python --version
printf "\n\n\n\n" && sudo yum -y install python
printf "\n\n\n\n" && which python && python --version

#---------------------------------------------------------------------------------------------------
# pip
#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && which pip && pip --version
printf "\n\n\n\n" && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
printf "\n\n\n\n" && python get-pip.py --user
printf "\n\n\n\n" && which pip && pip --version

#---------------------------------------------------------------------------------------------------
# Ansible
#---------------------------------------------------------------------------------------------------
# Requirement: paramiko cryptography setuptools PyYAML jinja2 pycrypto ecdsa enum34 idna cffi six ipaddress asn1crypto packaging appdirs MarkupSafe pycparser pyparsing
# setup-x86_64.exe -q --packages=binutils,curl,cygwin32-gcc-g++,gcc-g++,git,gmp,libffi-devel,libgmp-devel,make,nano,openssh,openssl-devel,python-crypto,python-paramiko,python2,python2-devel,python2-openssl,python2-pip,python2-setuptools
printf "\n\n\n\n" && which ansible && ansible --version
printf "\n\n\n\n" && pip install ansible --user
printf "\n\n\n\n" && which ansible && ansible --version

#---------------------------------------------------------------------------------------------------
# boto
#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && pip install boto --user

#---------------------------------------------------------------------------------------------------
# boto 3
#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && pip install boto3 --user

#---------------------------------------------------------------------------------------------------
# AWS Command Line Interface
#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && which aws && aws --version
printf "\n\n\n\n" && pip install awscli --upgrade --user
printf "\n\n\n\n" && which aws && aws --version

#---------------------------------------------------------------------------------------------------
# AWS EC2 External Inventory Script 
# https://docs.ansible.com/ansible/latest/user_guide/intro_dynamic_inventory.html#example-aws-ec2-external-inventory-script
#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && curl https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py -o ec2.py
printf "\n\n\n\n" && chmod a+x ec2.py
