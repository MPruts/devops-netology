### Задача 1

Выполнить в mongoshell
1. db.enableFreeMonitoring() - включение мониторинга
2. db.currentUp({"secs.running": {$gte:180}}) - отобразит список запросов выполняющихся более 3 минут
3. Найти в списке возвращенных запросов тот что создал пользователь и записать его id
4. db.killOp(<id-запроса_пользователя>) - остановка выполнения запроса пользователя

Для того чтобы запросы пользователя были ограничены по времени суполения можно добавить в выолнение запроса метод **maxTimeMS(<time_live>)**

Где <time_live> - время в милисекундах, по истечении которого запрос будет остановлен

### Задача 2

Блокировка операций записи вероятно происходит из-за того что Redis достиг выделенного объема оперативной памяти под кэширование, которое указано в параметре maxmemory. При достижении данного параметра Redis начинает удалять ключи согласно политике опреденной в параметре maxmemory-policy. Вероятно стоит проанализировать данные на комличество записей сс истекшим TTL. Возможно имеет смысл сменить политику очиски кэша.

### Задача 3

Первое о чем думается - проверить настройки сетевого подключения и доступности сервера и сервиса.
Так как число записей растет, то вероятно не зватает времени ожидания ответа от сервера. Вероятно стоит увеличить параметр сервера net_read_timeout и понаблюдать.
Возможно имеет смысл партицировать данные.

### Задача 4

Данная ошибка возникает при нехватки выделяемой процессам памяти на сервере, в этом случае происходит принудительная остановка какого-либо процесса, который определяется OOM-Killer.
Можно отключить OOM-Killer, но это не рекомендуется.
В качестве решения проблемы для начала я бы выставил параметр машины vm.overcommit_memory в значение 2. В этом случае происходит отказ в обработке запросов, которые запрашивают память большую чем размер памяти пространства подкачки и ОЗУ в соответствии с параметром overcommit_ratio.
Так же, по возможности - добавил бы ОЗУ в систему.