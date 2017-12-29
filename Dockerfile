FROM binarycat/cx_oracle

RUN yum install -y wget\
    gcc \
    python-devel \
    postgresql \
    postgresql-devel \
    mysql \
    mysql-devel

RUN yum clean all

RUN python -m pip install psycopg2
RUN python -m pip install mysql
RUN python -m pip install sqlalchemy


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
ENV JAVA_HOME=/usr/java/jdk1.8.0_151/

# hadoop client
RUN wget https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/cloudera-cdh5.repo -O /etc/yum.repos.d/cloudera-cdh5.repo
RUN wget https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/cloudera-manager.repo -O /etc/yum.repos.d/cloudera-manager.repo
RUN rpm --import https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/RPM-GPG-KEY-cloudera

RUN yum clean all; \
    yum install -y hadoop-client \
    hadoop-yarn-resourcemanager

# hue
RUN yum install -y hue; yum clean all