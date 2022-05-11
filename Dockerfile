# These three ARGs must point to an Iron Bank image - the BASE_REGISTRY should always be what is written below; please use \
# '--build-arg' when building locally to replace these values
# If your container is not based on either the ubi7/ubi8 Iron Bank images, then it should be based on a different Iron Bank image
# Note that you will not be able to pull containers from nexus-docker-secure.levelup-dev.io into your local dev machine 
#ARG BASE_REGISTRY=registry1.dso.mil
#ARG BASE_IMAGE=ironbank/redhat/ubi/ubi8
ARG BASE_REGISTRY=docker.io
ARG BASE_IMAGE=redhat/ubi8
ARG BASE_TAG=8.5

# FROM statement must reference the base image using the three ARGs established
FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG} as base

EXPOSE 8123

RUN dnf update -y --nodocs && \
    dnf install -y --nodocs \
        libnet && \
    dnf -y clean all && \ 
    rm -rf /var/clean/dnf

COPY entrypoint.sh .

RUN mkdir /app

WORKDIR /app
RUN mkdir gserver
RUN mkdir updates

WORKDIR /app/gserver
COPY gserver/ .

RUN chmod +x gamserver

CMD ["/bin/bash", "/entrypoint.sh"]
#CMD ["--updates /app/updates/", "--server https://0.0.0.0:8123", "--daemon"]