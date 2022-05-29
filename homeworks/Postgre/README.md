### Задача 1

> вывода списка БД

`\l`

> подключения к БД

`\c`

> вывода списка таблиц

`\dt`

> вывода описания содержимого таблиц

`\d table_name`

> выхода из psql

`\q`

---

### Задача 2

```commandline
test_database=# select attname, avg_width from pg_stats where tablename='orders'
test_database-# and avg_width = (select max(avg_width) from pg_stats where tablename = 'orders');
 attname | avg_width
---------+-----------
 title   |        16
(1 row)
```
---

### Задача 3

```commandline
test_database=# create table orders_1 (like orders including defaults including constraints);
CREATE TABLE

test_database=# alter table orders_1 add constraint inh_1 check (price > 499);
ALTER TABLE

test_database=# create table orders_2 (like orders including defaults including constraints);
CREATE TABLE

test_database=# alter table orders_2 add constraint inh_2 check (price <= 499);
ALTER TABLE

test_database=# insert into orders_1 (select * from orders where price > 499 );
INSERT 0 3

test_database=# insert into orders_2 (select * from orders where price <= 499 );
INSERT 0 5

test_database=# truncate orders;
TRUNCATE TABLE

test_database=# select * from orders;
 id | title | price
----+-------+-------
(0 rows)

test_database=# select * from orders_1;
 id |       title        | price
----+--------------------+-------
  2 | My little database |   500
  6 | WAL never lies     |   900
  8 | Dbiezdmin          |   501
(3 rows)

test_database=# select * from orders_2;
 id |        title         | price
----+----------------------+-------
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  7 | Me and my bash-pet   |   499
(5 rows)

test_database=# alter table orders_1 inherit orders;
ALTER TABLE

test_database=# alter table orders_2 inherit orders;
ALTER TABLE

test_database=# select * from orders;
 id |        title         | price
----+----------------------+-------
  2 | My little database   |   500
  6 | WAL never lies       |   900
  8 | Dbiezdmin            |   501
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  7 | Me and my bash-pet   |   499
(8 rows)
```

> Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

Да, можно было сразу создать секционированную таблицу с нужными секциями, чтобы данные по price вставлялись в нужное место

---

### Задача 4

Добавил бы ограничения уникальности на таблицу или уникальный индекс в объявления таблиц;

```
CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0,
    CONSTRAINT title_unique UNIQUE (title)
);

```
Только либо я что-то делаю не так, либо оно не работает)  
Похоже, при вставке нужно использовать триггер, который будет проверять наличие нового title во всех секциях

Несработавший пример с ограничением:

```commandline
test1=# select * from orders order by title;
 id |        title         | price
----+----------------------+-------
  3 | Adventure psql time  |   300
  8 | Dbiezdmin            |   501
  5 | Log gossips          |   123
  7 | Me and my bash-pet   |   499
  2 | My little database   |   500
  4 | Server gravity falls |   300
  6 | WAL never lies       |   900
  1 | War and peace        |   100
(8 rows)

test1=# insert into orders values(9, 'Adventure psql time', 400);
INSERT 0 1

test1=# select * from orders order by title;
 id |        title         | price
----+----------------------+-------
  3 | Adventure psql time  |   300
  9 | Adventure psql time  |   400
  8 | Dbiezdmin            |   501
  5 | Log gossips          |   123
  7 | Me and my bash-pet   |   499
  2 | My little database   |   500
  4 | Server gravity falls |   300
  6 | WAL never lies       |   900
  1 | War and peace        |   100
(9 rows)

test1=# insert into orders values(10, 'Adventure psql time', 500);
ERROR:  duplicate key value violates unique constraint "title_unique"
DETAIL:  Key (title)=(Adventure psql time) already exists.

test1=# \d orders;
                                   Table "public.orders"
 Column |         Type          | Collation | Nullable |              Default
--------+-----------------------+-----------+----------+------------------------------------
 id     | integer               |           | not null | nextval('orders_id_seq'::regclass)
 title  | character varying(80) |           | not null |
 price  | integer               |           |          | 0
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
    "title_unique" UNIQUE CONSTRAINT, btree (title)
Number of child tables: 2 (Use \d+ to list them.)

test1=# \d orders_1;
                                  Table "public.orders_1"
 Column |         Type          | Collation | Nullable |              Default
--------+-----------------------+-----------+----------+------------------------------------
 id     | integer               |           | not null | nextval('orders_id_seq'::regclass)
 title  | character varying(80) |           | not null |
 price  | integer               |           |          | 0
Indexes:
    "title_unique_1" UNIQUE CONSTRAINT, btree (title)
Check constraints:
    "inh_1" CHECK (price > 499)
Inherits: orders

test1=# \d orders_2;
                                  Table "public.orders_2"
 Column |         Type          | Collation | Nullable |              Default
--------+-----------------------+-----------+----------+------------------------------------
 id     | integer               |           | not null | nextval('orders_id_seq'::regclass)
 title  | character varying(80) |           | not null |
 price  | integer               |           |          | 0
Indexes:
    "title_unique_2" UNIQUE CONSTRAINT, btree (title)
Check constraints:
    "inh_2" CHECK (price <= 499)
Inherits: orders
```

---