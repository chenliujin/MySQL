
- --add-drop-table
- --skip-add-drop-table

- --master-data[=value]

Use this option to dump a master replication server to produce a dump file that can be used to set up another server as a slave of the master. It causes the dump output to include a CHANGE MASTER TO statement that indicates the binary log coordinates (file name and position) of the dumped server. These are the master server coordinates from which the slave should start replicating after you load the dump file into the slave.

If the option value is 2, the CHANGE MASTER TO statement is written as an SQL comment, and thus is informative only; it has no effect when the dump file is reloaded. If the option value is 1, the statement is not written as a comment and takes effect when the dump file is reloaded. If no option value is specified, the default value is 1.

This option requires the RELOAD privilege and the binary log must be enabled.

The --master-data option automatically turns off --lock-tables. It also turns on --lock-all-tables, unless --single-transaction also is specified, in which case, a global read lock is acquired only for a short time at the beginning of the dump (see the description for --single-transaction). In all cases, any action on logs happens at the exact moment of the dump.

It is also possible to set up a slave by dumping an existing slave of the master, using the --dump-slave option, which overrides --master-data and causes it to be ignored if both options are used.

- --single-transaction


# 查看 binlog 日志

```
mysqlbinlog binlog.log | more
```

# 增量备份
- 打开 binlog
- 打开 general_log 

general_log 记录数据库的任何操作，查看 general_log 的状态和位置可以用命令 show variables like "general_log%"，开启 general_log 可以用命令 set global general_log=on


# 部分恢复

## 控制 binlog 的区间

- --start-position: 开始点
- --stop-position: 结束点
- --start-date 'yyyy-mm-dd hh:mm:ss': 开始时间
- --stop-date 'yyyy-mm-dd hh:mm:ss': 结束时间

```
mysqlbinlog mysql-bin.000003 --stop-position=208 | mysql -h127.0.0.1 -uroot -p123456  -P3306
```
