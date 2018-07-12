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
# boto
#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && pip install boto --user

#---------------------------------------------------------------------------------------------------
# boto 3
#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && pip install boto3 --user

#---------------------------------------------------------------------------------------------------
# AWS EC2 External Inventory Script 
# https://docs.ansible.com/ansible/latest/user_guide/intro_dynamic_inventory.html#example-aws-ec2-external-inventory-script
#---------------------------------------------------------------------------------------------------
printf "\n\n\n\n" && curl https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py -o ec2.py
printf "\n\n\n\n" && chmod a+x ec2.py