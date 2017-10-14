
- --add-drop-table
- --skip-add-drop-table

- --master-data 

在 mysqldump 中使用 --master-data=2，会记录 binlog 文件和 position 的信息。

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
