#### 1. На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:
#### - поместите его в автозагрузку,
#### - предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron),
#### - удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.

> systemctl list-units |grep node_e
  
  node_exporter.service                                                                    loaded active running   Node EXPORTER

> systemctl status node_exporter

● node_exporter.service - Node EXPORTER

     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)

     Active: active (running) since Fri 2021-07-09 05:04:12 UTC; 2min 29s ago

   Main PID: 616 (node_exporter)

      Tasks: 5 (limit: 1072)

     Memory: 16.9M

     CGroup: /system.slice/node_exporter.service

             └─616 /home/vagrant/03-sysadmin-04-os/node_exporter-1.1.2.linux-amd64/node_exporter --collector.cpu.info --collector.logind


Jul 09 05:04:12 vagrant node_exporter[616]: level=info ts=2021-07-09T05:04:12.846Z caller=node_exporter.go:113 collector=thermal_zone

Jul 09 05:04:12 vagrant node_exporter[616]: level=info ts=2021-07-09T05:04:12.846Z caller=node_exporter.go:113 collector=time

Jul 09 05:04:12 vagrant node_exporter[616]: level=info ts=2021-07-09T05:04:12.846Z caller=node_exporter.go:113 collector=timex

Jul 09 05:04:12 vagrant node_exporter[616]: level=info ts=2021-07-09T05:04:12.846Z caller=node_exporter.go:113 collector=udp_queues

Jul 09 05:04:12 vagrant node_exporter[616]: level=info ts=2021-07-09T05:04:12.846Z caller=node_exporter.go:113 collector=uname

Jul 09 05:04:12 vagrant node_exporter[616]: level=info ts=2021-07-09T05:04:12.846Z caller=node_exporter.go:113 collector=vmstat

Jul 09 05:04:12 vagrant node_exporter[616]: level=info ts=2021-07-09T05:04:12.846Z caller=node_exporter.go:113 collector=xfs

Jul 09 05:04:12 vagrant node_exporter[616]: level=info ts=2021-07-09T05:04:12.846Z caller=node_exporter.go:113 collector=zfs

Jul 09 05:04:12 vagrant node_exporter[616]: level=info ts=2021-07-09T05:04:12.846Z caller=node_exporter.go:195 msg="Listening on" address=:9100

Jul 09 05:04:12 vagrant node_exporter[616]: level=info ts=2021-07-09T05:04:12.846Z caller=tls_config.go:191 msg="TLS is disabled." http2=false

> systemctl cat node_exporter

# /etc/systemd/system/node_exporter.service

[Unit]

Description=Node EXPORTER

[Service]

EnvironmentFile=/home/vagrant/03-sysadmin-04-os/node_exporter-1.1.2.linux-amd64/node_exp

ExecStart=/home/vagrant/03-sysadmin-04-os/node_exporter-1.1.2.linux-amd64/node_exporter $OPT

[Install]

WantedBy=multi-user.target

> cat /home/vagrant/03-sysadmin-04-os/node_exporter-1.1.2.linux-amd64/node_exp

OPT=--collector.cpu.info --collector.logind

#### 2. Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.
--collector.cpu            Enable the cpu collector (default: enabled).

--collector.meminfo        Enable the meminfo collector (default: enabled).

--collector.filesystem     Enable the filesystem collector (default: enabled).

--collector.netstat        Enable the netstat collector (default: enabled).

#### 3. Установите в свою виртуальную машину Netdata. Воспользуйтесь готовыми пакетами для установки (sudo apt install -y netdata). После успешной установки:
#### - в конфигурационном файле /etc/netdata/netdata.conf в секции [web] замените значение с localhost на bind to = 0.0.0.0,
#### - добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте vagrant reload:
#### config.vm.network "forwarded_port", guest: 19999, host: 19999
#### После успешной перезагрузки в браузере на своем ПК (не в виртуальной машине) вы должны суметь зайти на localhost:19999. Ознакомьтесь с метриками, которые по умолчанию собираются Netdata и с комментариями, которые даны к этим метрикам.

Проверил. Графики отображаются.

#### 4. Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?
> dmesg -T | grep Hypervisor

[Thu Jul  8 10:39:43 2021] Hypervisor detected: KVM

Данное сообщение свидетельствует что машина является виртуальной.

#### 5. Как настроен sysctl fs.nr_open на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?
>sysctl -n fs.nr_open

1048576

Параметр означает максимальное количество открытых дескрипторов на процесс.

ulimit -n        the maximum number of open file descriptors

#### 6. Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через nsenter. Для простоты работайте в данном задании под root (sudo -i). Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.
> unshare -f --pid --mount-proc /usr/bin/sleep 1h

> lsns | grep sleep

4026532186 mnt         2  1896 root            unshare -f --pid --mount-proc /usr/bin/sleep 1h

4026532187 pid         1  1897 root            /usr/bin/sleep 1h

> nsenter -p --target 1897 --mount

> ps aux

USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND

root           1  0.0  0.0   8076   520 pts/0    S+   12:27   0:00 /usr/bin/sleep 1h

root           2  0.0  0.3   9836  3924 pts/1    S    12:27   0:00 -bash

root          11  0.0  0.3  11492  3384 pts/1    R+   12:27   0:00 ps aux

#### 7. Найдите информацию о том, что такое :(){ :|:& };:. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (это важно, поведение в других ОС не проверялось). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов dmesg расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?
> :() - начало описания функции

> { :|: } - описнаие тела функции, где происходит вызов функции :() и передача результата ее выполнения в функцию :() и все это выполняется в фоновом режиме(символ &)

> ; - переход к выполнению следующей команды

> : - вызов фунции :()

Сработал механизм ограничения количества запущенных задач пользователя. 

> dmesg 

Сработал механизм 

cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-3.scope

> systemctl cat user-1000.slice

 /usr/lib/systemd/system/user-.slice.d/10-defaults.conf

[Unit]

Description=User Slice of UID %j

Documentation=man:user@.service(5)

After=systemd-user-sessions.service

StopWhenUnneeded=yes

[Slice]

TasksMax=33%

Последний парамерт TasksMax=33% указывает что количество процессов не может превышать 33%, как полагаю, от максимально возможного количества процеcсов.

Временно увеличить значение можно выполнив 

> echo "<значение>" > /proc/sys/fs/file-max