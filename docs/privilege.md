

# 只读
```
# mysql > CREATE USER 'viewer'@'%' IDENTIFIED BY '72b154cb';
# mysql > GRANT SELECT on zencart.* to viewer@'%';
# mysql > flush privileges;
```
