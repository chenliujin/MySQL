# 知识点
* 复合索引
* 存储引擎




# Install

```
# rpm -ivh https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
# yum install -y mysql-community-server
```

# 版本

```
# Enable to use MySQL 5.7
[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

[mysql80-community]
name=MySQL 8.0 Community Server
baseurl=http://repo.mysql.com/yum/mysql-8.0-community/el/7/$basearch/
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
```

## 1. 开机启动
```
# systemctl enable mysqld
# systemctl start  mysqld
```

## 2. 初始密码

```
# cat /var/log/mysqld.log | grep password
2018-09-18T05:45:40.494756Z 5 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: 7sEFoReyvf&i
```

## 3. 修改初始密码

密码需包含大小写字母，数字，特殊符号

```
mysql > SHOW VARIABLES LIKE 'validate_password%';
mysql > ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '@Chenliujin8';
```

`降低级别`

```
mysql> set global validate_password_policy=0;
mysql> SHOW VARIABLES LIKE 'validate_password%';
mysql > ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'chenliujin';
```

# JDBC

```
rpm -ivh https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.12-1.el7.noarch.rpm
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
