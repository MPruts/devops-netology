#### Задание 1
|                            |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|----------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Краткое описание инцидента | В 22:52 UTC 21 октября произошло прерывание репликации БД межда ЦОД Западного и Восточного побережий что привело к рассинхронизации данных в рекпликах БД на Западном и Восточном ЦОД                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| Предшествующие события     | В 22:52 UTC 21 октября производилась замена вышедшего из стороя оптического оборудвания.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| Причина инцидента          | В результате произошел разрыв соединения длительностью в 43 секунды. Этот обрыв связи и стал причиной инцидента. Так как в период отсутствия связи реплики западного побережья успели провести кворум среди серверов и выбрать нового лидера для обработки данных. Однако на кластере восточного поборежья так же присутствовали данные которые в следствии обрыва не успели быть реплицированы на Западное побережье. А после восстановления соединения между Западным и Восчтоным ЦОД возник конфликт, так как и там и там присутствовали не реплицированные записи.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| Воздействие                | Пользовательские данные не были потеряны, но наблюдались проблемы в отображении страниц, а именно - информация былаа устаревшей. Было принято решение о приостановке обработки метаданных push и оставноке обработки wedhook.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Обнаружение                | Инцидент был замечен системой мониторинга. Затем были привлечены ответственные инженеры и команды разработчиков БД.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| Реакция                    | Ответственные разработчики устранили инцидент за 24 часа 11 минут.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| Восстановление             | Было принято решение восстановить из резервной копии реплики на восточном побережье, реплицировать их с западным, после чего дополнить данными которые находились в очереди на восточном побережье                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| Таймлайн                   | 22:52 UTC 21/10/2018 произошел обрев соединения между западным и восточным цод <br> 22:54 UTC 21/10/2018 система мониторинга начала фиксировать сбои в системах <br> 23:07 UTC 21/10/2018 блокировка инструментов развертывания, определение причины сбоев: рассинхронизация кластеров <br> 23:13 UTC 21/10/2018 определения масштаба инцидента: затронуты несколько кластеров <br> 23:19 UTC 21/10/2018 определение первичных действий для остановки ухудшения последствий инцидента <br> 00:05 UTC 22/10/2018 определение плана по восстановлению работоспособности системы: сделать бэкапы затронутых систем, восстановить их из резервной копии, запустить процесс репликации, дополнить данными из очереди <br> 00:41 UTC 22/10/2018 запуск процесса резервного копирования затронутых кластеров <br> 06:41 UTC 22/10/2018 часть серверов восточного побережья закончила восстановление и начался процесс репликации <br> 07:46 UTC 22/10/2018 публикация сообщения GitHUB  о текущем состоянии дел <br> 11:12 UTC 22/10/2018 все первичные базы на восточном побережье были полностью восстановлены, но содержали еще не полные данные, что приводило не корректному отображению информации <br> 13:15 UTC 22/10/2018 предоставление реплик баз для чтения в восточном облаке позволило пережить пик нагрузки <br> 16:24 UTC 22/10/2018 завершена синхронизация реплик и переключение на исходную топологию <br> 16:45 UTC 22/10/2018 дополнение данных из очередей в базы <br> 23:03 UTC 22/10/2018 все запросы webhook и и прочие страницы были обработаны |
| Последующие действия       | Произведен переход на новый механизм отчетности о состоянии                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |