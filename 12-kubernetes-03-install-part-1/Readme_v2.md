## Задание 1
Известно:
- База данных должна быть отказоустойчивой. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии.
- Кэш должен быть отказоустойчивый. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии.
- Фронтенд обрабатывает внешние запросы быстро, отдавая статику. Потребляет не более 50 МБ ОЗУ на каждый экземпляр, 0.2 ядра. 5 копий.
- Бекенд потребляет 600 МБ ОЗУ и по 1 ядру на копию. 10 копий.

## Рассчеты
- Ресурсы для нод БД

    Для работы 1 ноды БД понадобится:
    
        - 1 Гб RAM , 1 CPU , HDD 10 Гб - для работы ОС        
        - 4 Гб RAM , 1 CPU , HDD 30 Гб - ресурсы, потребляемые БД 

    Коэфициент резервирования - 1.5

    Итого для работы 3 нод БД потребуется:
    
        - 6 CPU * 1,5 = 9 CPU
        - 15 Гб RAM * 1,5 = 22,5 Гб        
        - 120 ГБ HDD * 1,5 = 180 Гб

- Ресурсы для кэш

    Для работы 1 ноды КЭШ понадобится:
    
        - 1 Гб RAM , 1 CPU , HDD 10 Гб - для работы ОС        
        - 4 Гб RAM , 1 CPU , HDD 30 Гб - ресурсы, потребляемые кэшем
    
    Коэфициент резервирования - 1.5

    Итого для работы 3 нод КЭШ потребуется:
    
        - 6 CPU * 1,5 = 9 CPU
        - 15 Гб RAM * 1,5 = 22,5 Гб      
        - 120 ГБ HDD * 1,5 = 180 Гб

- Ресурсы для Master node

    Для работы 1 ноды Master node понадобится:
    
        - 1 Гб RAM , 1 CPU , HDD 10 Гб - для работы ОС        
        - 2 Гб RAM , 2 CPU , HDD 50 Гб - ресурсы, потребляемые сервисами Master node

    Коэфициент резервирования - 1.5

    Итого для работы 3 нод Master node потребуется:
    
        - 9 CPU * 1,5 = 13,5 CPU
        - 9 Гб RAM * 1,5 = 13,5 ГБ      
        - 180 ГБ HDD * 1,5 = 270 Гб

- Ресурсы для Worker node Бэкенд

    Будем использовать 2 worker node, следовательно для получения работы 10 копий сервиса Бэкенда на 1 ноде будем запускать 5 копий Бэкенда
    
    Для работы 1 ноды Worker node понадобится:
    
        - 1 Гб RAM , 1 CPU , HDD 10 Гб - для работы ОС        
        - 1 Гб RAM , 1 CPU , HDD 100 Гб - ресурсы, потребляемые сервисами Worker node
        - 3 Гб RAM , 5 CPU , HDD 10 Гб - ресурсы, потребляемые сервисами Бэкенда

    Коэфициент резервирования - 1.5

    Итого для работы 2 нод Worker node Бэкенда потребуется:
    
        - 14 CPU * 1,5 = 21 CPU
        - 10 Гб RAM * 1,5 = 15 Гб       
        - 240 ГБ HDD * 1,5 = 360 Гб

- Ресурсы для Worker node Фронтэенд

    Будем использовать 1 worker node для запуска 5 сервисов Фронтэнда
    
    Для работы 1 ноды Worker node понадобится:
    
        - 1 Гб RAM , 1 CPU , HDD 10 Гб - для работы ОС        
        - 1 Гб RAM , 1 CPU , HDD 100 Гб - ресурсы, потребляемые сервисами Worker node
        - 0,25 Гб RAM , 1 CPU , HDD 10 Гб - ресурсы, потребляемые сервисами Фронтенда

    Коэфициент резервирования - 2

    Итого для работы 1 нод Worker node Фронтенда потребуется:
    
        - 3 CPU * 2 = 6 CPU
        - 2,25 Гб RAM * 2 = 4,5 Гб        
        - 120 ГБ HDD * 2 = 240 Гб


##### Ресурсы для запуска сервиса
| Наименование | Ресурсы | Итого |
|--------------|---------|-------|
| HDD || 1230 Гб |
| БД | 180 Гб ||
| КЭШ | 180 Гб ||
| Master node | 270 Гб ||
| Worker node Бэкенд | 360 Гб ||
| Worker node Фронтенд | 240 Гб ||
| CPU || 58,5 |
| БД | 9 ||
| КЭШ | 9 ||
| Master node | 13,5 ||
| Worker node Бэкенд | 21 ||
| Worker node Фронтенд | 6 ||
| RAM || 78 Гб |
| БД | 22,5 Гб ||
| КЭШ | 22,5 Гб ||
| Master node | 13,5 Гб ||
| Worker node Бэкенд | 15 Гб ||
| Worker node Фронтенд | 4,5 Гб ||


##### ИТОГО для запуска приложения в кластере необходимы следующие ресурсы:
- CPU -58,5
- RAM - 78 Гб
- HDD - 1230 Гб