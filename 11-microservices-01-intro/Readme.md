#### Задание 1
Выгоды от перехода на микросервисную архитектуру:
- повышение частоты обновления функционала системы, за счет проведения обновления отдельных микросервисов
- слабая связность сервисов позволит проводить обновления микросервисов сервисов без оставновки сервиса в целом
- за счет разделения на микросервисы упростится траблшутинг при появление каких-то проблем после обновления, так как область поиска сузится до размеров микросервиса
- микросервисы позволят вести параллельную разработку каждого сервиса не завися при этом от того в какой стадии разработки находятся другие микросервисы продукта в целом
- упростится мастабируемость системы, так как при недостатки ресурсов в каком-то отдельном сервисе, достаточно будет его увеличить/расширить, не не затрагивая при этом ресурсы других сервисов

Проблемы, которые необходимо решить в первую очередь:
- с помощью предметно-ориентированного подхода определить доменные области, в которых будут создаваться и развиваться микросервисы
- проблемы разработки, такие как: интерфейсы взаимодействия между микросервисами, инфраструктура разработки, версионирование артифактов, документирование, автоматизация тестирования, сборки и развертывания
- проблемы эксплуатации: определение способа мониторирнга состояния и работы миросервисов, организация сбора логов и их анализ, управление изменениями настроек микросервисов и управление инфраструктурой продукта в целом

#### Доработка домашнего задания
Переход на микросервисы повлечет за собой увеличение/появление парка серверов, так как для каждого сервиса выделяется 1 или несколько серверов, в этом случае понадобится определить :
  - сколько ресурсов будет выделятьсся под каждый сервис
  - будут ли это виртуальные серверы или контейнеры, какой тип контейнеризации/виртуаизации испльзовать
  - где будут физически располагаться ресурсы, на которых будут развертываться сервисы: будет ли это собственный ЦОД или же аренда у облачных провайдеров. Если это будет собственный ЦОД, то как будет обеспечиваться отказоустойчивость работы сервисов
  - понадобится штат сотрудников, которые будут заниматься настройкой/поддержкой данной инфраструктуры. В случае если используется собственный ЦОД, то так же необходим штат сотрудников, которые будут заниматься обслуживанием ЦОД и оборудования, расположенного там и предназначенного для выделения ресурсов под сервисы.
  - определить уровень критичности недоступности каждого сервиса
