FROM jenkins/jenkins

USER root

RUN apt-get update

RUN apt-get install -y ansible

RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

RUN apt-get install -y wget unzip && \
    wget https://releases.hashicorp.com/terraform/0.14.10/terraform_0.14.10_linux_amd64.zip && \
    unzip terraform_0.14.10_linux_amd64.zip && \
    mv terraform /usr/bin

USER jenkins

