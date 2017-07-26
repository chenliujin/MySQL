#!/bin/bash

host=''
port='33066'
user=''
passwd=''
database='parking_meter'
table='parking_tariff parking_tariff_range_rule parking_tariff_tag_match parking_price_table'
output_file='parking_tariff.sql'

# 1. 只导出数据结构
# 1. 不需要 drop table
# 1. 去掉 AUTO_INCREMENT
mysqldump -h$host -P$port -u$user -p$passwd --skip-add-drop-table --no-data $database $table | sed 's/ AUTO_INCREMENT=[0-9]*//' > $output_file

