FROM ubuntu:24.04

WORKDIR /tmp
COPY install.sh /tmp

RUN /tmp/install.sh

ENTRYPOINT ["sysbench"]
CMD [ "--help" ]
