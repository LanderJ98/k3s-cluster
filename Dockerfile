FROM --platform=linux/amd64 ubuntu:20.04
ARG TF_VERSION=1.2.9
ARG INSTANCE_SSH_PUBLIC_KEY
ARG OCI_PRIVATE_KEY

RUN apt-get -y update && apt-get -y upgrade

RUN apt install -y wget unzip curl

# Install terraform
RUN wget https://releases.hashicorp.com/terraform/$TF_VERSION/terraform_${TF_VERSION}_linux_amd64.zip \
    && unzip terraform_${TF_VERSION}_linux_amd64.zip \
    && mv terraform /usr/local/bin

# Install Azure cli
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
RUN mkdir ~/.ssh
RUN echo "$INSTANCE_SSH_PUBLIC_KEY" > ~/.ssh/id_rsa.pub && chmod 644 ~/.ssh/id_rsa.pub \
    && echo "$OCI_PRIVATE_KEY" > ~/.ssh/oci.pem && chmod 600 ~/.ssh/oci.pem