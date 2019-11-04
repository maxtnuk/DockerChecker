FROM bitwalker/alpine-elixir:1.9.2

ENV BASE_DM=https://github.com/docker/machine/releases/download/v0.16.0
    
WORKDIR /workspace

RUN apk add docker

RUN set -ex; \
    apk add --update curl tar make; \
    curl -L $BASE_DM/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine; \
	mv /tmp/docker-machine /usr/local/bin/docker-machine; \
	chmod +x /usr/local/bin/docker-machine

RUN set -ex; \
    curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(shell uname -s)-$(shell uname -m) -o /usr/local/bin/docker-compose; \
	chmod +x /usr/local/bin/docker-compose

COPY user_instance.pem /base/user_instance.pem

COPY docker-compose.yml /workspace/docker-compose.yml
COPY run_algo.sh /workspace/run_algo.sh
COPY makefile /workspace/makefile

CMD [ "/bin/bash" ]