FROM --platform=linux/amd64 ubuntu:20.04
ARG TF_VERSION=1.3.3
ARG INSTANCE_SSH_PUBLIC_KEY
ARG OCI_PRIVATE_KEY

RUN apt-get -y update && apt-get -y upgrade

RUN apt install -y wget unzip curl build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev \
    libffi-dev libsqlite3-dev wget libbz2-dev python3 python3-pip python3-venv


# Install terraform
RUN wget https://releases.hashicorp.com/terraform/$TF_VERSION/terraform_${TF_VERSION}_linux_amd64.zip \
    && unzip terraform_${TF_VERSION}_linux_amd64.zip \
    && mv terraform /usr/local/bin

# Install Azure cli
RUN pip install azure-cli
RUN mkdir ~/.ssh ~/.oci
RUN echo "$INSTANCE_SSH_PUBLIC_KEY" > ~/.ssh/id_rsa.pub && chmod 644 ~/.ssh/id_rsa.pub \
    && echo "$OCI_PRIVATE_KEY" > ~/.ssh/oci.pem && chmod 600 ~/.ssh/oci.pem

# Install Oracle CLI
RUN curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh -o install.sh && chmod +x install.sh && ./install.sh --accept-all-defaults

# Set up Oracle cli session
COPY oci_profile.zip /root/.oci/oci_profile.zip
RUN chmod 755 /root/.oci/oci_profile.zip && unzip /root/.oci/oci_profile.zip
RUN /root/bin/oci setup repair-file-permissions --file config