#!/bin/bash
docker-machine create --driver generic \
--generic-ip-address=54.180.124.55 \
--generic-ssh-key "./user_instance.pem" \
--generic-ssh-user=ubuntu virt
