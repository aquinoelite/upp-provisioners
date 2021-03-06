#!/bin/bash

cd /ansible

ansible-playbook provision.yml --extra-vars "\
aws_access_key=${AWS_ACCESS_KEY} \
aws_secret_access_key=${AWS_SECRET_ACCESS_KEY} \
aws_region=${AWS_REGION} \
cluster=${CLUSTER} \
environment_type=${ENVIRONMENT_TYPE} "
