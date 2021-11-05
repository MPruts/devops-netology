### Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.
```
docker run --name pg13_1 -e POSTGRES_PASSWORD=password  -v pg-data-13:/var/lib/postgresql/data -d postgres:13
```
Управляющие команды для:
- вывода списка БД
```
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)
```
- подключения к БД
```
postgres=# \c postgres 
You are now connected to database "postgres" as user "postgres".
```
- вывода списка таблиц
```
postgres=# \dt
```
- вывода описания содержимого таблиц
```
postgres=# \d <имя_таблицы>
```
- выхода из psql
```
postgres=# \q
```

### Задача 2

```
test_database=# select * from pg_stats where tablename='orders' and avg_width=(select max(avg_width) from pg_stats where tablename = 'orders');
 schemaname | tablename | attname | inherited | null_frac | avg_width | n_distinct | most_common_vals | most_common_freqs |                                                                 histogram_bounds                                                                  | correlation | most_common_elems | most_common_elem_freqs | elem_count_histogram 
------------+-----------+---------+-----------+-----------+-----------+------------+------------------+-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------+-------------+-------------------+------------------------+----------------------
 public     | orders    | title   | f         |         0 |        16 |         -1 |                  |                   | {"Adventure psql time",Dbiezdmin,"Log gossips","Me and my bash-pet","My little database","Server gravity falls","WAL never lies","War and peace"} |  -0.3809524 |                   |                        | 
(1 row)
```
### Задача 3

Транзация:
```
BEGIN;
CREATE TABLE orders_1 ( CHECK (price > 499) ) INHERITS ( orders);
INSERT INTO orders_1 SELECT id,title,price FROM orders WHERE price > 499;
DELETE FROM ONLY orders WHERE price > 499;
CREATE RULE order_insert_to_1 AS ON INSERT TO orders WHERE (price > 499) DO INSTEAD INSERT INTO orders_1 VALUES (NEW.*);
CREATE TABLE orders_2 ( CHECK (price <= 499) ) INHERITS ( orders);
INSERT INTO orders_2 SELECT id,title,price FROM orders WHERE price <= 499;
DELETE FROM ONLY orders WHERE price <= 499;
CREATE RULE order_insert_to_2 AS ON INSERT TO orders WHERE (price <= 499) DO INSTEAD INSERT INTO orders_2 VALUES (NEW.*);
COMMIT;
```
Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?
```
Если при первоначальном проектировании таблицы условия были бы известны, то можно было бы сразу создать таблицы для шардов, а для исходной таблицы добавить правила вставки новых записей, чтобы они сразу добавлялись в нужные таблицы.
```
### Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.
```
pg_dump -U postgres test_database > /tmp/test_dump_new.sql
```
Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

Добавил параметр `UNIQUE` в файле дампа [test_dump_new.sql](test_dump_new.sql) БД `test_database` при создании таблицы `orders` для столбца `title`
