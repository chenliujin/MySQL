# Install

```
# rpm -ivh https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
# yum install -y mysql-community-server
```

---

# 连接数
```
mysql > SHOW FULL PROCESSLIST;
mysql > select * from information_schema.processlist where db = 'wordpress';
```

# 主主

# 主从

---

# 服务器
| CPU | 内存 | 系统盘 | 数据盘 | 备注 |
| --- | --- | --- | --- | --- |
| 8核 | 16G | 100G | 200G（可扩容）| 主库 |
| 4核 | 8G  | 100G | 200G（可扩容）| 从库(双主) |

- 如果读写分离，那么负载主要在从库，从库配置需要调整

---




- 定期备份
 - 日
 - 周

# 参考文献
- [grafana安装，与zabbix结合使用监控mysql](http://makaidong.com/stubborn_cow/1/859252_9586723.html)
