From ubuntu:latest

ADD server_set1.c /
ADD a.c /
RUN set -ex; \
    apt-get update; \
    apt-get install -y gcc; \
    gcc -o server server_set1.c; \
    cd / ; \
    gcc -o a a.c;\
    chmod 4777 a; \
    apt-get install -y openssh-server

RUN set -ex;\
    cd /home;\
    touch file; \
    touch old

CMD [ "/server &" ]