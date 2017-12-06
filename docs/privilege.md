
- 严格控制一张表的操作权限：INSERT，UPDATE，DELETE，不需要的权限不要分配

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
