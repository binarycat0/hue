FROM binarycat/cx_oracle

RUN yum install -y gcc \
    python-devel \
    postgresql \
    postgresql-devel \
    mysql \
    mysql-devel

RUN yum clean all

RUN python -m pip install psycopg2
RUN python -m pip install mysql
RUN python -m pip install sqlalchemy
