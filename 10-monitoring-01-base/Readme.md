#### Задание 1 

В мониторинг метрик должны попасть такие метрики как:
- Загрузка ЦПУ (CPU)
- Загрузка Оперативной памяти (RAM)
- Количество свободных и занятых Inodes на диске (Inodes)
- Количество свободного и занятого пространства на диске (HDD Space)
- количество операций вводы вывода на диске (IOPS)
- Размеры файлов отчетов (Size reports)
- Время формирования отчета (Time create report)
- Время ответа сервера на запрос о формировании отчета (Time response)
- Количество обращений к сервису в единицу времени
- Общее количество обращений к сервису
- Количество успешно отработанных обращений к сервису
- Количество неуспешно отрработанных обращений к сервису
- 

Данный перечень метрик позволит отслеживать состояние сервера, его загрузку, производить оценку текущих ресурсов и его возможностей.
Так же это позволит производить оценку доступности сервиса.
Кроме того можно производить анализ времени формирования отчета, что является очень важным.


#### Задание  2

Описание значения списка метрик, которые не понятны менеджеру, изложить в пояснительной записке с описанием того как данная метрика будет участвовать в анализе работы системы в целом и на что она влияет.

Для оценки уровня выполнения обязанностей перед клиентами нужно будет составить условия\критерии по которым можно будет делать выводы об уровне выполнения обязанностей перед клиентами.
Например должны быть описаны такие параметры как: период доступности системы, период недоступности системы, максимально время формирования отчета.
Значения этих параметров позволят настроить соттветствующие опвощения при достижении критичных значений.
Это позволит вовремя скорректировать работоспособность сервиса, или же стать триггером для поиска узких мест в работе сервиса с целью оптимизации производительности и предоставления. 

#### доработка задания 2
Первые 6 метрик являются показателями физического состояния оборудования, на котором развернут сервис. Данные метрики позволяют сделать выводы о достаточности выделенных ресурсов для нормальной работы сервиса. Это нужно для своевременного реагирования на нехватку ресурсов, а так же при возникновении проблем в работе железа, на котором развернут сервис.

Следующие 6 показателей метрики могут быть использованы для определения стемени выполнения обязательств перед клиентом по доступности сервиса. Например уровень доступности сервиса можно мерить отношением количества успешно обработанных запросов к общему количеству запросов. Так же эти показатели могут быть использованы в анализе чтобы дать ответ на вопрос: в какое время больше всего происходит обращений к сервису, с какой периодичностью это происходит.


#### Задание 3

Как вариант - получить от разработчиков метрики, которые возможно возможно получать при работе приложения, и их допустимые значения.
Настроить мониторинг приложения на значения метрик, которые будут отличны от допустимых.

#### доработка задания 3

Как вариант можно использовать систему перехвата ошибок sentry, которая будет слать ошибки приложений разработчикам. Еще можно использовать трейсинг, чтобы определять шаги приведшие сервис к тому или иному состоянию.

#### Задание 4

Ошибка состоит в том что при расчете SLA по кодам происходит учет только кодов формата 2ХХ, но в процессе работы сервиса вполне возможны и коды формата 3ХХ.
Для корректного расчета SLA  нужно скорректировать формулу, добавив в к сумме запросов с кодом 2ХХ еще и запросы в кодом 3ХХ.

``(summ_2xx_requests+summ_3xx_requests)/summ_all_requests``    