# 主库 

## 开启 binlog

```
[mysqld]
log-bin=mysql-bin
server-id=1
```

### db 关闭 binlong

```
binlog-ignore-db = wordpress 
```

### db 开启 binlog 

```
binlog-do-db = zencart 
```

## 重启 master

```
mysql > show master status;
+------------------+----------+--------------+------------------+-------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
+------------------+----------+--------------+------------------+-------------------+
| mysql-bin.000001 |      154 |              |                  |                   |
+------------------+----------+--------------+------------------+-------------------+
```

## 权限

```
mysql > CREATE USER 'replication'@'%' IDENTIFIED BY '123456';
mysql > GRANT REPLICATION SLAVE ON *.* TO 'replication'@'%';
mysql > FLUSH PRIVILEGES;
```

## 备份主库

mysqldump --master-data 记录 master_log_file 和 master_log_pos，启动复制时需要用到

```
mysqldump -h 127.0.0.1 -P 3306 -u root -p {123456} -A --master-data > all.sql

```

---

# 从库

```
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
#log-error      = /var/log/mysql/error.log
# By default we only accept connections from localhost
#bind-address   = 127.0.0.1
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0
character-set-server = utf8
max_connections=1000 # 最大链接数
log-bin=mysql-bin
server-id=2
relay_log=mysql-relay-bin
log_slave_updates=1
read_only=1 # 只读
```

relay-log 日志记录的是从服务器I/O线程将主服务器的二进制日志读取过来记录到从服务器本地文件，然后SQL线程会读取 relay-log 日志的内容并应用到从服务器

log_slave_updates 表示允许备库将其重放的事件也记录到自身的二进制日志中。

### 启用复制

```
mysql > change master to master_host='k2', master_port=33066, master_user='replication',master_password='123456',master_log_file='mysql-bin.000001',master_log_pos=154;
mysql > start slave;
mysql > show slave status \G;
mysql > stop slave;
```

---

# 从库切为主库

## 锁定主库

```
mysql > flush tables with read lock;
mysql > unlock tables; # 最后执行 
```

## 检查从库同步状态

```
mysql > show processlist;
```

直到看到状态都为：slave has read all relay log 表示更新都执行完毕

## 从库切换为主库

```
mysql > stop slave;
mysql > reset master;
```

### 配置

重置 server-id=1, 其它注释掉：

```
server-id=1
# relay_log=mysql-relay-bin
# log_slave_updates=1
# read_only=1
```

---

# 参考文献
- https://dev.mysql.com/doc/refman/5.7/en/replication.html
