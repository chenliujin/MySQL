#!/bin/bash

host=''
port='33066'
user='appuser'
passwd='123456'
database='parking_meter'
table='parking_tariff parking_tariff_range_rule parking_tariff_tag_match parking_price_table'
output_file=$database'.sql'

# 1. 不导出数据：--no-data
# 1. 不需要 drop table: --skip-add-drop-table
# 1. 去掉 AUTO_INCREMENT
# 1. 只导出数据，不需要创建表：--no-create-info
mysqldump \
	-h$host \
	-P$port \
	-u$user \
	-p$passwd \
	--skip-add-drop-table \
	--no-data \
	$database | sed 's/ AUTO_INCREMENT=[0-9]*//' > $output_file

