

# 只读
```
# mysql > CREATE USER 'viewer'@'%' IDENTIFIED BY '72b154cb';
# mysql > GRANT SELECT on zencart.* to viewer@'%';
# mysql > flush privileges;
```


# 增删改查
```
mysql > CREATE USER 'appuser'@'%' IDENTIFIED BY '123456';
mysql > GRANT SELECT,INSERT,UPDATE,DELETE on zencart.* to appuser@'%';
mysql > flush privileges;
```


# 删除用户
```
mysql > drop user appuser@'%';
```
