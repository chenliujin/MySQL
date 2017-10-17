
### 查看 binlog 开启情况
```
mysql > show variables like 'log_bin%';
+---------------------------------+--------------------------------+
| Variable_name                   | Value                          |
+---------------------------------+--------------------------------+
| log_bin                         | ON                             |
| log_bin_basename                | /var/lib/mysql/mysql-bin       |
| log_bin_index                   | /var/lib/mysql/mysql-bin.index |
| log_bin_trust_function_creators | OFF                            |
| log_bin_use_v1_row_events       | OFF                            |
+---------------------------------+--------------------------------+


mysql > show variables like 'binlog%';  
+-----------------------------------------+--------------+
| Variable_name                           | Value        |
+-----------------------------------------+--------------+
| binlog_cache_size                       | 32768        |
| binlog_checksum                         | CRC32        |
| binlog_direct_non_transactional_updates | OFF          |
| binlog_error_action                     | ABORT_SERVER |
| binlog_format                           | ROW          |
| binlog_group_commit_sync_delay          | 0            |
| binlog_group_commit_sync_no_delay_count | 0            |
| binlog_gtid_simple_recovery             | ON           |
| binlog_max_flush_queue_time             | 0            |
| binlog_order_commits                    | ON           |
| binlog_row_image                        | FULL         |
| binlog_rows_query_log_events            | OFF          |
| binlog_stmt_cache_size                  | 32768        |
+-----------------------------------------+--------------+
```

# Master

### 开启 binlog
```
[mysqld]
log-bin=mysql-bin
server-id=1

# 不同步哪些数据库  
binlog-ignore-db = information_schema
binlog-ignore-db = mysql
binlog-ignore-db = performance_schema
binlog-ignore-db = sys
```

### 指定数据库
```
# 只同步哪些数据库，除此之外，其他不同步  
binlog-do-db = game 
```

重启 master
```
mysql > show master status;
+------------------+----------+--------------+------------------+-------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
+------------------+----------+--------------+------------------+-------------------+
| mysql-bin.000001 |      154 |              |                  |                   |
+------------------+----------+--------------+------------------+-------------------+
```

### 权限

```
mysql > CREATE USER 'replication'@'k1' IDENTIFIED BY '123456';
mysql > GRANT REPLICATION SLAVE ON *.* TO 'replication'@'k1';
mysql > FLUSH PRIVILEGES;
```

---

# 从库
```
log-bin=mysql-bin
server-id=2
relay_log=mysql-relay-bin
log_slave_updates=1
read_only=1
```

relay-log 日志记录的是从服务器I/O线程将主服务器的二进制日志读取过来记录到从服务器本地文件，然后SQL线程会读取 relay-log 日志的内容并应用到从服务器

log_slave_updates表示允许备库将其重放的事件也记录到自身的二进制日志中。

### 启用复制
```
mysql > change master to master_host='k2',master_user='replication',master_password='123456',master_log_file='mysql-bin.000001',master_log_pos=154;
mysql > start slave;
mysql > show slave status \G;
mysql > stop slave;
```
