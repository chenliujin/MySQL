
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

---

# 日志清理

## [方法一] 手动清理 binlog
```
mysql > show master status; # 主库
mysql > show slave status; # 从库
mysql > purge master logs before'2018-01-01 00:00:00';
```

## [方法二] 通过设置 binlog 过期的时间，使系统自动删除 binlog 文件
```
mysql > show variables like 'expire_logs_days'; 
mysql > set global expire_logs_days = 365;
```

