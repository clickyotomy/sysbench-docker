FROM public.ecr.aws/amazonlinux/amazonlinux:2

ARG TAG=1.0.20

COPY install.sh /tmp
RUN SYSBENCH_TAG=${TAG} /tmp/install.sh

ENTRYPOINT ["sysbench"]
CMD [ "--help" ]
