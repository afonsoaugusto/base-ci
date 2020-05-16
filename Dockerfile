FROM centos:7

ARG TERRAFORM_VERSION
ARG GCLOUD_VERSION

ENV TERRAFORM_VERSION=0.12.24
ENV GCLOUD_VERSION=266.0.0

RUN adduser ci && \
    yum install unzip -y && \
    yum install wget -y && \
    yum install ruby -y && \
    yum install git -y && \
    yum install python3 -y && \
    pip3 install ansible && \
    yum clean all

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm -rf terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    chown ci:ci terraform && \
    mv  terraform /bin/terraform

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    rm -rf awscliv2.zip && \
    bash ./aws/install

RUN wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz && \
    tar -zxvf google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz && \
    rm -rf google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz && \
    chown -R ci:ci google-cloud-sdk/ && \
    su ci && \
    sh /google-cloud-sdk/install.sh --usage-reporting false --path-update true --rc-path=/home/ci/.bashrc --command-completion true -q    

WORKDIR /home/ci/

USER ci