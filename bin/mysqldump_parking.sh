#!/bin/bash

mysqldump -h -P -u -p --skip-add-drop-table --no-data parking_meter parking_tariff parking_tariff_range_rule parking_tariff_tag_match parking_price_table > parking_tariff.sql
