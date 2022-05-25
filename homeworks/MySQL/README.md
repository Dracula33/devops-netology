### Задача 1

```commandline
mysql> \s
--------------
mysql  Ver 8.0.29 for Linux on x86_64 (MySQL Community Server - GPL)
...

mysql> select count(1) from orders where price > 300;
+----------+
| count(1) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)

mysql>

```
---

### Задача 2
```commandline
mysql> create user 'test'@'localhost'
    -> identified with mysql_native_password by 'test-pass'
    -> with MAX_QUERIES_PER_HOUR 100
    -> PASSWORD EXPIRE interval 180 day
    -> FAILED_LOGIN_ATTEMPTS 3
    -> attribute '{"name":"James", "surname":"Pretty"}'
    -> ;
Query OK, 0 rows affected (0.02 sec)

mysql> grant select on test_db.* to 'test'@'localhost';
Query OK, 0 rows affected, 1 warning (0.01 sec)

mysql> select * from information_schema.user_attributes where user='test';
+------+-----------+----------------------------------------+
| USER | HOST      | ATTRIBUTE                              |
+------+-----------+----------------------------------------+
| test | localhost | {"name": "James", "surname": "Pretty"} |
+------+-----------+----------------------------------------+
1 row in set (0.00 sec)
```
---

### Задача 3
```commandline
mysql> select table_name, table_schema, engine from information_schema.tables where table_name = 'orders';
+------------+--------------+--------+
| TABLE_NAME | TABLE_SCHEMA | ENGINE |
+------------+--------------+--------+
| orders     | test_db      | InnoDB |
+------------+--------------+--------+
1 row in set (0.00 sec)
```
На InnoDb
```commandline
mysql> show profiles;
+----------+------------+------------------------------------------+
| Query_ID | Duration   | Query                                    |
+----------+------------+------------------------------------------+
|        7 | 0.00565875 | update orders set price = price - 50     |
```
На MyISAM
```commandline
mysql> show profiles;
+----------+------------+------------------------------------------+
| Query_ID | Duration   | Query                                    |
+----------+------------+------------------------------------------+
|       13 | 0.00706475 | update orders set price = price - 50     |
```
---

### Задача 4
```commandline
root@93c07f3675c7:/# cat /etc/mysql/conf.d/mysql.cnf
[mysqld]
innodb_flush_log_at_trx_commit=2
innodb_file_per_table=true
innodb_log_buffer_size=1048576
innodb_buffer_pool_size=134217728
innodb_log_file_size=104857600
```
---