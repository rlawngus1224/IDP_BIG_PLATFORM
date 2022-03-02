FROM centos:7

LABEL MAINTAINER="JuHyun"

RUN yum -y update
RUN yum -y install wget openssh-server openssh-clients openssh-askpass java-1.8.0-openjdk-devel.x86_64

RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_dsa
RUN cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys

RUN mkdir /var/run/sshd

RUN mkdir /hadoop_home && \
cd /hadoop_home &&\
wget https://archive.apache.org/dist/hadoop/core/hadoop-2.7.7/hadoop-2.7.7.tar.gz && \
tar xvzf hadoop-2.7.7.tar.gz

RUN cd /hadoop_home && mv hadoop-2.7.7 hadoop
RUN rm -rf hadoop-2.7.7.tar.gz

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.322.b06-1.el7_9.x86_64
ENV HADOOP_HOME=/hadoop_home/hadoop
ENV HADOOP_CONFIG_HOME=$HADOOP_HOME/etc/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin
ENV PATH=$PATH:$HADOOP_HOME/sbin

RUN echo 'StrictHostKeyChecking no' >> /etc/ssh/ssh_config

RUN cd $HADOOP_HOME && mkdir datanode tmp namenode secondnode

RUN cd $HADOOP_CONFIG_HOME && rm -rf core-site.xml hdfs-site.xml mapred-site.xml
ADD *.xml $HADOOP_CONFIG_HOME/

RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.322.b06-1.el7_9.x86_64' >> /hadoop_home/hadoop/etc/hadoop/hadoop-env.sh
RUN echo '/usr/sbin/sshd' >> ~/.bashrc

RUN yum install -y which

RUN hadoop namenode -format
#RUN hadoop datanode -format
#RUN /usr/sbin/sshd

#CMD source ~/.bashrc


