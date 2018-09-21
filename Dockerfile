FROM mysql:5.7.18

MAINTAINER chenliujin <liujin.chen@qq.com>

ENV MYSQL_ROOT_PASSWORD chenliujin
ENV MYSQL_ROOT_HOST localhost

# 1.修改时区
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 


# 2.开启 binlog
RUN echo "character-set-server = utf8" >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo "log-bin=mysql-bin" >> /etc/mysql/mysql.conf.d/mysqld.cnf && \
    echo "server-id=1" >> /etc/mysql/mysql.conf.d/mysqld.cnf

# 3.慢查询
#slow_query_log = ON
#long_query_time = 3
