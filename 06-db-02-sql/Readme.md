Задача 1
```
docker run --name pg12_1 -e POSTGRES_PASSWORD=password  -v pg-data:/var/lib/postgresql/data -v pg-backup:/pg_backup -d postgres:12
```
Задача 2
- создайте пользователя test-admin-user и БД test_db
```
create database test_db;
create user "test-admin-user" password 'pass123';
```
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
```
CREATE TABLE orders (id serial primary key, description varchar(50), price integer);
CREATE TABLE clients (id serial primary key, lastname varchar(50), country varchar(20), zakaz integer references orders (id));
CREATE INDEX cl_ind_country ON clients ( country ) ;
```
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
```
GRANT ALL ON TABLE clients,orders TO "test-user-admin";
```
- создайте пользователя test-simple-user  
```
create user "test-simple-user" password 'pass123';
```
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db
```
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE clients,orders TO "test-simple-user" ;
```
- итоговый список БД после выполнения пунктов выше,
```
test_db=# \l
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres                   +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres                   +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/postgres                  +
           |          |          |            |            | postgres=CTc/postgres         +
           |          |          |            |            | "test-user-admin"=CTc/postgres

```
- описание таблиц (describe)
```
test_db=# \d orders
                                      Table "public.orders"
   Column    |         Type          | Collation | Nullable |              Default               
-------------+-----------------------+-----------+----------+------------------------------------
 id          | integer               |           | not null | nextval('orders_id_seq'::regclass)
 description | character varying(50) |           |          | 
 price       | integer               |           |          | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_zakaz_fkey" FOREIGN KEY (zakaz) REFERENCES orders(id)

test_db=# \d clients
                                    Table "public.clients"
  Column  |         Type          | Collation | Nullable |               Default               
----------+-----------------------+-----------+----------+-------------------------------------
 id       | integer               |           | not null | nextval('clients_id_seq'::regclass)
 lastname | character varying(50) |           |          | 
 country  | character varying(20) |           |          | 
 zakaz    | integer               |           |          | 
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "cl_ind_country" btree (country)
Foreign-key constraints:
    "clients_zakaz_fkey" FOREIGN KEY (zakaz) REFERENCES orders(id)
```
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
```
test_db=# SELECT * FROM information_schema.table_privileges where grantee='test-user-admin' or grantee='test-simple-user';
 grantor  |     grantee      | table_catalog | table_schema | table_name | privilege_type | is_grantable | with_hierarchy 
----------+------------------+---------------+--------------+------------+----------------+--------------+----------------
 postgres | test-simple-user | test_db       | public       | orders     | INSERT         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | SELECT         | NO           | YES
 postgres | test-simple-user | test_db       | public       | orders     | UPDATE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | DELETE         | NO           | NO
 postgres | test-user-admin  | test_db       | public       | orders     | INSERT         | NO           | NO
 postgres | test-user-admin  | test_db       | public       | orders     | SELECT         | NO           | YES
 postgres | test-user-admin  | test_db       | public       | orders     | UPDATE         | NO           | NO
 postgres | test-user-admin  | test_db       | public       | orders     | DELETE         | NO           | NO
 postgres | test-user-admin  | test_db       | public       | orders     | TRUNCATE       | NO           | NO
 postgres | test-user-admin  | test_db       | public       | orders     | REFERENCES     | NO           | NO
 postgres | test-user-admin  | test_db       | public       | orders     | TRIGGER        | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | INSERT         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | SELECT         | NO           | YES
 postgres | test-simple-user | test_db       | public       | clients    | UPDATE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | DELETE         | NO           | NO
 postgres | test-user-admin  | test_db       | public       | clients    | INSERT         | NO           | NO
 postgres | test-user-admin  | test_db       | public       | clients    | SELECT         | NO           | YES
 postgres | test-user-admin  | test_db       | public       | clients    | UPDATE         | NO           | NO
 postgres | test-user-admin  | test_db       | public       | clients    | DELETE         | NO           | NO
 postgres | test-user-admin  | test_db       | public       | clients    | TRUNCATE       | NO           | NO
 postgres | test-user-admin  | test_db       | public       | clients    | REFERENCES     | NO           | NO
 postgres | test-user-admin  | test_db       | public       | clients    | TRIGGER        | NO           | NO

```
- список пользователей с правами над таблицами test_db
```
test_db=# \dp
                                           Access privileges
 Schema |      Name      |   Type   |         Access privileges          | Column privileges | Policies 
--------+----------------+----------+------------------------------------+-------------------+----------
 public | clients        | table    | postgres=arwdDxt/postgres         +|                   | 
        |                |          | "test-simple-user"=arwd/postgres  +|                   | 
        |                |          | "test-user-admin"=arwdDxt/postgres |                   | 
 public | clients_id_seq | sequence |                                    |                   | 
 public | orders         | table    | postgres=arwdDxt/postgres         +|                   | 
        |                |          | "test-simple-user"=arwd/postgres  +|                   | 
        |                |          | "test-user-admin"=arwdDxt/postgres |                   | 
 public | orders_id_seq  | sequence |                                    |                   | 

```

Задача 3
```
test_db=# select count(*) from clients;
 count 
-------
     5
test_db=# select count(*) from orders;
 count 
-------
     5

```
Задача 4
```
test_db=# update clients SET zakaz = 3 where lastname = 'Иванов Иван Иванович';
test_db=# update clients SET zakaz = 4 where lastname = 'Петров Петр Петрович';
test_db=# update clients SET zakaz = 5 where lastname = 'Иоганн Себастьян Бах';

test_db=# select cl.lastname, ord.description from clients as cl inner join orders as ord on cl.zakaz = ord.id;
       lastname       | description 
----------------------+-------------
 Иванов Иван Иванович | Книга
 Петров Петр Петрович | Монитор
 Иоганн Себастьян Бах | Гитара
```
Задача 5
```
test_db=# EXPLAIN  select cl.lastname, ord.description from clients as cl inner join orders as ord on cl.zakaz = ord.id;
                              QUERY PLAN                               
-----------------------------------------------------------------------
 Hash Join  (cost=1.11..2.19 rows=5 width=46) - для каждой строки clients вычисляется hash для сравнения с hash таблицы orders по условию hash cond
   Hash Cond: (cl.zakaz = ord.id) - если условие не соблюдается, то строка пропускается
   ->  Seq Scan on clients cl  (cost=0.00..1.05 rows=5 width=37) - чтение таблицы clients, состоящей из 5 строк
   ->  Hash  (cost=1.05..1.05 rows=5 width=17) - вычисление hash для каждой из 5 строк из таблицы orders
         ->  Seq Scan on orders ord  (cost=0.00..1.05 rows=5 width=17) - чтение таблицы orders, состоящей из 5 строк 

```
Задача 6
Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).
```
pg_dump -U postgres test_db > /pg_backup/test_db_backup
```
Остановите контейнер с PostgreSQL (но не удаляйте volumes).
```
docker stop pg12_1
```
Поднимите новый пустой контейнер с PostgreSQL.
```
docker run --name pg12_2 -e POSTGRES_PASSWORD=password  -v pg-data2:/var/lib/postgresql/data -v pg-backup:/pg_backup -d postgres:12
```
Восстановите БД test_db в новом контейнере.
```
docker exec -it pg12_2 bash
root@e725b669606c:/# psql -U postgres
postgres=# create database test_db2;
postgres=# exit
root@e725b669606c:/# psql test_db2 < /pg_backup/test_db_backup
```
