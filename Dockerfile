FROM binarycat/cx_oracle:5

RUN yum install -y wget\
    postgresql \
    postgresql-devel \
    mysql \
    mysql-devel

RUN python -m pip install psycopg2
RUN python -m pip install mysql
RUN python -m pip install sqlalchemy
RUN python -m pip install Werkzeug

# java
RUN wget -c \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.rpm \
    -O /tmp/jdk-8u151-linux-x64.rpm

RUN wget -c \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jre-8u151-linux-x64.rpm \
    -O /tmp/jre-8u151-linux-x64.rpm

RUN yum install -y /tmp/jdk-8u151-linux-x64.rpm
RUN yum install -y /tmp/jre-8u151-linux-x64.rpm

RUN export JAVA_HOME=/usr/java/jdk1.8.0_151/jre/

# hadoop client
RUN wget https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/cloudera-cdh5.repo -O /etc/yum.repos.d/cloudera-cdh5.repo
RUN wget https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/cloudera-manager.repo -O /etc/yum.repos.d/cloudera-manager.repo
RUN rpm --import https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/RPM-GPG-KEY-cloudera

RUN yum install -y hadoop-client

# hue
RUN yum install -y hue; \
    yum clean all

ENV HUE_HOME=/usr/lib/hue/build/env/
ENV JAVA_HOME=/usr/java/jdk1.8.0_151/

ENV HUE_CONF_DIR=/etc/hue/conf
ENV HADOOP_CONF_DIR=/etc/hadoop/conf

#
EXPOSE 8080
VOLUME /etc/hue/conf
VOLUME /etc/hadoop/conf

CMD ["$HUE_HOME/bin/hue", "runserver_plus", "0.0.0.0:8080"]