BASE_DM=https://github.com/docker/machine/releases/download/v0.16.0

.PHONY: install_docker, create_dm

init : create_dm

connect:
	eval $(shell docker-machine env ${REMOTE_NAME} --shell ssh)

create_dm:
	docker-machine create --driver generic \
	--generic-ip-address=${REMOTE_IP} \
	--generic-ssh-key ${REMOTE_SSH_FILE} \
	--generic-ssh-user=${REMOTE_HOST} ${REMOTE_NAME}

create_volume:
	docker volume create algospace
	docker run -it -v algospace:/workspace --name space -w /workspace alpine

rm_dm:
	docker-machine rm ${REMOTE_NAME}
