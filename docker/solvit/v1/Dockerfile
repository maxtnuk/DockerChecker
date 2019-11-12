FROM  maxtnt/docker_elixir_alpine:base2

# Install dep

ENV REMOTE_IP 54.180.124.55
ENV REMOTE_SSH_FILE /base/user_instance.pem
ENV REMOTE_HOST ubuntu
ENV REMOTE_NAME virt

RUN docker-machine create --driver generic \
	--generic-ip-address=${REMOTE_IP} \
	--generic-ssh-key ${REMOTE_SSH_FILE} \
	--generic-ssh-user=${REMOTE_HOST} ${REMOTE_NAME}

ENV DOCKER_TLS_VERIFY 1
ENV DOCKER_HOST tcp://${REMOTE_IP}:2376
ENV DOCKER_CERT_PATH /opt/app/.docker/machine/machines/${REMOTE_NAME}
ENV DOCKER_MACHINE_NAME ${REMOTE_NAME}

# RUN eval $(docker-machine env ${REMOTE_NAME} --shell bash)

CMD [ "/bin/bash" ]

