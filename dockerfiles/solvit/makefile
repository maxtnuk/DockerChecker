BASE_DM=https://github.com/docker/machine/releases/download/v0.16.0

.PHONY: install_docker, install_dm, create_dm

all: install_docker install_dm create_dm
	echo "environment setting finish!!"

install_docker:
	apt update
	apt install -y apt-transport-https ca-certificates curl software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
	apt update
	apt-cache policy docker-ce
	apt install -y docker-ce

install_dm:
	curl -L $(BASE_DM)/docker-machine-$(shell uname -s)-$(shell uname -m) >/tmp/docker-machine
	mv /tmp/docker-machine /usr/local/bin/docker-machine
	chmod +x /usr/local/bin/docker-machine

create_dm:
	docker-machine create --driver generic \
	--generic-ip-address=${REMOTE_IP} \
	--generic-ssh-key ${REMOTE_SSH_FILE} \
	--generic-ssh-user=${REMOTE_HOST} ${REMOTE_NAME}

install_dc:
	sudo curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(shell uname -s)-$(shell uname -m) -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose

create_volume:
	docker volume create algospace
	docker run -it -v algospace:/workspace --name space -w /workspace alpine

rm_dm:
	docker-machine rm ${REMOTE_NAME}
