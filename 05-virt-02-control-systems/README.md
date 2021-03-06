Задача 1 
```
Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.

Сценарии:

- 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований  
Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий 
- Требуется наиболее производительное бесплатное opensource решение для виртуализации небольшой (20 серверов) инфраструктуры Linux и Windows виртуальных машин
- Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows инфраструктуры 
- Необходимо рабочее окружение для тестирование программного продукта на нескольких дистрибутивах Linux
```

        1. KVM - является бесплатной аппаратной виртуализацией, поддержка Windows лучше чем у Xen
        2. XEN - является более стабильным бесплатным гипервизором, драйверы для работы с Linux гостывыми ОС лучше, присутствует поддержка Windows систем
        3. Hyper-V Server - является бестплатным гипервизором виртуализации, но при этом клиентскую машину Windows нужно лицензировать отдельно. Наибольшая совместимость гипервизора для Windows систем
        4. KVM - является бесплатной аппаратной виртуализацией, если тестирование не направлено на высокие I/O операции. Либо Xen PV - является так же бесплатным. Можно сформировать шаблоны машин для дальнейшего их быстрого развертывания и применения в тестировании.

Задача 2
```
Опишите сценарий миграции с VMware vSphere на Hyper-V для Linux и Windows виртуальных машин. Детально опишите необходимые шаги для использования всех преимуществ Hyper-V для Windows.
```
        Перенос Linux машины:
        - удалить VmWare Tools
        - выключить виртуальную машину
        - скачать на свою станцию каталог с содержимым выиртуальной машины, а так же каталоги где расположены диски виртуальной машины
        - скачать v2v Converter для преобразования дисков VmWare в Hyper-V и установить
        - запустить v2v Converter и выбрать файл жесткого диска виртуальной машины
        - выбираем тип диска, который должен получиться в результате конвертации, и выбираем путь созранения конвертируемого диска
        - переносим конвертированный диск на Hyper-V
        - создаем виртуальную машины с аналогичными ресурсами как в VmWare
        - при создании указывает файл жесткого диска, который был сконвертирован и перенесен на гипервизор
        - при создании виртуальной машины указать mac-адрес сетевого адаптера как у виртуальной машины, которая была в VmWare
        - при конвертации мог измениться UUID загрузочного диска. Для правки, нужно загрузиться с загрузочного диска, опредеить разделы подключенных дисков, примонтировать разделы. Определить ннужный UUID для загрузки и происзвести его замену в файле fstab и в файле загрузчика

        Перенос Windows машины:
        - удалить VmWare Tools
        - выключить виртуальную машину
        - скачать на свою станцию каталог с содержимым выиртуальной машины, а так же каталоги где расположены диски виртуальной машины
        - скачать v2v Converter для преобразования дисков VmWare в Hyper-V и установить
        - запустить v2v Converter и выбрать файл жесткого диска виртуальной машины
        - выбираем тип диска, который должен получиться в результате конвертации, и выбираем путь созранения конвертируемого диска
        - переносим конвертированный диск на Hyper-V
        - создаем виртуальную машины с аналогичными ресурсами как в VmWare
        - при создании указывает файл жесткого диска, который был сконвертирован и перенесен на гипервизор
        - при создании виртуальной машины указать mac-адрес сетевого адаптера как у виртуальной машины, которая была в VmWare
        
Задача 3 
```
Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был бы выбор, то создавали ли вы бы гетерогенную среду или нет? Мотивируйте ваш ответ примерами. 
```
        Гетерогенная среда - это одновременной использование нескольких гипервизоров, например: Xen, Hyper-V.
        Использование гетерогенной среды повлечет за собой траты на железо, так же необходимы специалисты, которые обладают знаниями по работе с той или иной системой виртуализации, что повлечет увеличение штата сотрудников.
        При использовании и Linux, и Windows можно свести все к использованию гипервизора от VmWare, так как в этом случае в плане стабильности и производительности он будет наилучшим, но это повлечет за собой траты на приобретение этого гипервизора и обучение персонала.
        Если позволяют финансы, использовал бы гипервизор от vmware. Кроме того, использование гетерогенной среды будет требовать ежемесячной оплаты услуг персонала по ее обслуживанию, в то время как использование vmware хоть и повлечет за собой траты на обучение персонала, но это будет разовым случаем и позволит сократить число лиц обслуживающих среду виртуализации.