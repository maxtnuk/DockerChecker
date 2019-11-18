FROM maxtnt/docker_elixir_alpine:base2

ARG REMOTE_IP
ARG REMOTE_SSH_FILE
ARG REMOTE_HOST
ARG REMOTE_NAME

# install docker-machine
RUN docker-machine create --driver generic \
	--generic-ip-address=$REMOTE_IP \
	--generic-ssh-key $REMOTE_SSH_FILE \
	--generic-ssh-user=$REMOTE_HOST $REMOTE_NAME

ENV DOCKER_TLS_VERIFY 1
ENV DOCKER_HOST tcp://$REMOTE_IP:2376
ENV DOCKER_CERT_PATH /opt/app/.docker/machine/machines/$REMOTE_NAME
ENV DOCKER_MACHINE_NAME $REMOTE_NAME

# Now copy all the source
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

# Now copy all the source
ADD solvit /app
    
WORKDIR /app
RUN mix deps.get
# ENV PORT 8080
# RUN mix phx.digest

# Rock'n'roll
ENV PORT 8080
CMD ["mix", "phx.server"]
#CMD [ "/bin/bash" ]