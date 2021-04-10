FROM centos:7

RUN yum install -y openssh-server mysql unzip

RUN adduser nadim && \
    echo "12345" | passwd nadim --stdin && \
    mkdir /home/nadim/.ssh && \
    chmod 700 /home/nadim/.ssh

COPY jenkins_home/ansible/remote-key.pub /home/nadim/.ssh/authorized_keys

RUN chown nadim:nadim -R /home/nadim/.ssh && \
    chmod 600 /home/nadim/.ssh/authorized_keys

RUN /usr/sbin/sshd-keygen

RUN yum install -y mysql

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

CMD /usr/sbin/sshd -D
