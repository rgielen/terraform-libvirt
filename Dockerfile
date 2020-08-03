ARG TERRAFORM_VERSION=0.12.29

FROM hashicorp/terraform:$TERRAFORM_VERSION AS terraform

FROM ubuntu:18.04

ARG PLUGIN_VERSION=0.6.2
ARG BINARY_NAME=terraform-provider-libvirt-0.6.2+git.1585292411.8cbe9ad0.Ubuntu_18.04.amd64.tar.gz
ARG LOCATION=https://github.com/dmacvicar/terraform-provider-libvirt/releases/download/v$PLUGIN_VERSION/

ENV PROJECT_DIR=/var/tfproject

# Install Dependencies
# libvirt0 is needed to run the provider. xsltproc needed to use XML/XSLT. mkisofs needed to use cloud init images
# ca-certificates to avoid terraform init 509 error. openssh-client to talk to remote libvirt server
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        libvirt0 xsltproc mkisofs ca-certificates openssh-client curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && mkdir -p /root/.terraform.d/plugins

COPY --from=terraform /bin/terraform /bin/

RUN cd /root/.terraform.d/plugins \
        && curl -L $LOCATION/$BINARY_NAME | tar -xz \
        && mv terraform-provider-libvirt terraform-provider-libvirt-v$PLUGIN_VERSION \
        && chown root:root *

VOLUME ${PROJECT_DIR}
WORKDIR ${PROJECT_DIR}
