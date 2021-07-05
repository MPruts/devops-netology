#### 1.Какой системный вызов делает команда cd? В прошлом ДЗ мы выяснили, что cd не является самостоятельной программой, это shell builtin, поэтому запустить strace непосредственно на cd не получится. Тем не менее, вы можете запустить strace на /bin/bash -c 'cd /tmp'. В этом случае вы увидите полный список системных вызовов, которые делает сам bash при старте. Вам нужно найти тот единственный, который относится именно к cd.
Системный вызов относительно команды cd 

chdir("/tmp")

#### 2. Попробуйте использовать команду file на объекты разных типов на файловой системе. Например:
> #### vagrant@netology1:~$ file /dev/tty
#### /dev/tty: character special (5/0)
> #### vagrant@netology1:~$ file /dev/sda
#### /dev/sda: block special (8/0)
> #### vagrant@netology1:~$ file /bin/bash
#### /bin/bash: ELF 64-bit LSB shared object, x86-64
#### Используя strace выясните, где находится база данных file на основании которой она делает свои догадки.
База данных команды находится файле magic.mgc, который последовательно ищется в разных каталогах и перечитывается.

Список мест где происходит поиск данных:

stat("/home/vagrant/.magic.mgc", 0x7fff58655510) = -1 ENOENT (No such file or directory)

stat("/home/vagrant/.magic", 0x7fff58655510) = -1 ENOENT (No such file or directory)

openat(AT_FDCWD, "/etc/magic.mgc", O_RDONLY) = -1 ENOENT (No such file or directory)

stat("/etc/magic", {st_mode=S_IFREG|0644, st_size=111, ...}) = 0

openat(AT_FDCWD, "/etc/magic", O_RDONLY) = 3

openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3

В итоге база данных найдена по последнему пути: `openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3`

#### 3. Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).
> cat /dev/null > /proc/<pid-процесса, который занимает удаленный файл>/fd/<имя файла дескриптора, который ссылается на удаленный файл>

#### 4. Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?
Зомби процессы потребляют немного памяти в kernel потому что kernel необходимо хранить информацию об этом процессе, других ресурсов они не занимают.

#### 5. В iovisor BCC есть утилита opensnoop:
> #### root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop
#### /usr/sbin/opensnoop-bpfcc
#### На какие файлы вы увидели вызовы группы open за первую секунду работы утилиты? Воспользуйтесь пакетом bpfcc-tools для Ubuntu 20.04. Дополнительные сведения по установке.
> sudo opensnoop-bpfcc

PID    COMM               FD ERR PATH

598    irqbalance          6   0 /proc/interrupts

598    irqbalance          6   0 /proc/stat

598    irqbalance          6   0 /proc/irq/20/smp_affinity

598    irqbalance          6   0 /proc/irq/0/smp_affinity

598    irqbalance          6   0 /proc/irq/1/smp_affinity

598    irqbalance          6   0 /proc/irq/8/smp_affinity

598    irqbalance          6   0 /proc/irq/12/smp_affinity

598    irqbalance          6   0 /proc/irq/14/smp_affinity

598    irqbalance          6   0 /proc/irq/15/smp_affinity

777    vminfo              6   0 /var/run/utmp

578    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services

578    dbus-daemon        18   0 /usr/share/dbus-1/system-services

578    dbus-daemon        -1   2 /lib/dbus-1/system-services

578    dbus-daemon        18   0 /var/lib/snapd/dbus-1/system-services/

777    vminfo              6   0 /var/run/utmp

578    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services

578    dbus-daemon        18   0 /usr/share/dbus-1/system-services

578    dbus-daemon        -1   2 /lib/dbus-1/system-services

578    dbus-daemon        18   0 /var/lib/snapd/dbus-1/system-services/

#### 6. Какой системный вызов использует uname -a? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в /proc, где можно узнать версию ядра и релиз ОС.
Используется системный вызов uname.

Альтернативное местоположение в /proc, где можно узнать версию ядра и релиз ОС:

Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}

#### 7. Чем отличается последовательность команд через ; и через && в bash? Например:
> #### root@netology1:~# test -d /tmp/some_dir; echo Hi
#### Hi
> #### root@netology1:~# test -d /tmp/some_dir && echo Hi
> #### root@netology1:~#
#### Есть ли смысл использовать в bash &&, если применить set -e?
Записи команд через ; происходит последовательное выполнение команд вне зависимости от результата выполнения предыдущей команды. При записи команд через && происходит последовательное выполненние команд только при условии что предыдущая команда была выполнена успешно.

Использование && в bash не имеет смысла если выполнена команда set -e, в данном случае происходит немедленный выход из выполнения команд, если какая-либо команда завершилась с ненулевым статусом.

#### 8. Из каких опций состоит режим bash set -euxo pipefail и почему его хорошо было бы использовать в сценариях?
-e - немедленный выход из выполнения, если команда завершается с ненулевым статусом.

-u - считать неустановленные переменные как ошибку.

-x - печатать команды и их аргументы когда они выполняются.

-o pipefail - возвращаемое значение конвейера - это статус последней команды с ненулевым значением выхода или нулем, если нет команды с ненулевым значением выхода.

Это удобно для определения места возникновения проблемы, так как будет происходить возврат значений в результате которых была получена ошибка.

#### 9. Используя -o stat для ps, определите, какой наиболее часто встречающийся статус у процессов в системе. В man ps ознакомьтесь (/PROCESS STATE CODES) что значат дополнительные к основной заглавной буквы статуса процессов. Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).
Наиболее часто встречающийся статус у процессов: I - процесс продолжительное время в ожидающем режиме, затем идут процессы со статусом S - спящие процессы, ожидающие ижидающие завершения выполнения каких-либо команд.

`<    процесс с высоким приоритетом`

`N    процесс с низким приоритетом`

`L    некоторые страницы заблокированы в оперативной памяти`

`s    процесс является лидером сеанса`

`l    многопоточный процесс`

`+    находится в приорететной группе процессов`

> ps -xo pid,stat,cmd --sort=stat
    
	PID STAT CMD

      3 I<   [rcu_gp]

      4 I<   [rcu_par_gp]

      6 I<   [kworker/0:0H-kblockd]

      9 I<   [mm_percpu_wq]

     11 I    [rcu_sched]

     20 I<   [kworker/1:0H-kblockd]

     22 I<   [netns]

     27 I<   [writeback]

     77 I<   [kintegrityd]

     78 I<   [kblockd]

     79 I<   [blkcg_punt_bio]

     80 I<   [tpm_dev_wq]

     81 I<   [ata_sff]

     82 I<   [md]

     83 I<   [edac-poller]

     84 I<   [devfreq_wq]

     91 I<   [kthrotld]

     92 I<   [acpi_thermal_pm]

     94 I<   [scsi_tmf_0]

     96 I<   [scsi_tmf_1]

     98 I<   [vfio-irqfd-clea]

     99 I<   [ipv6_addrconf]

    109 I<   [kstrp]

    112 I<   [kworker/u5:0]

    126 I<   [charger_manager]

    162 I<   [scsi_tmf_2]

    164 I<   [ttm_swap]

    165 I<   [cryptd]

    200 I<   [kworker/0:1H-kblockd]

    211 I<   [kdmflush]

    213 I<   [kdmflush]

    244 I<   [raid5wq]

    300 I<   [ext4-rsv-conver]

    326 I<   [kworker/1:1H-kblockd]

    383 I<   [rpciod]

    385 I<   [xprtiod]

    408 I<   [iprt-VBoxWQueue]

    524 I<   [kaluad]

    525 I<   [kmpath_rdacd]

    526 I<   [kmpathd]

    527 I<   [kmpath_handlerd]

   7766 I    [kworker/0:0-events]

   7998 I    [kworker/1:1-events]

   8081 I    [kworker/0:2-events]

   8247 I    [kworker/1:0-events]

   9029 I    [kworker/u4:2-events_power_efficient]

   9048 I    [kworker/u4:0-events_unbound]

   9117 R+   ps -xo pid,stat,cmd --sort=stat

      1 Ss   /sbin/init

      2 S    [kthreadd]

     10 S    [ksoftirqd/0]

     12 S    [migration/0]

     13 S    [idle_inject/0]

     14 S    [cpuhp/0]

     15 S    [cpuhp/1]

     16 S    [idle_inject/1]

     17 S    [migration/1]

     18 S    [ksoftirqd/1]

     21 S    [kdevtmpfs]

     23 S    [rcu_tasks_kthre]

     24 S    [kauditd]

     25 S    [khungtaskd]

     26 S    [oom_reaper]

     28 S    [kcompactd0]

     29 SN   [ksmd]

     30 SN   [khugepaged]

     85 S    [watchdogd]

     88 S    [kswapd0]

     89 S    [ecryptfs-kthrea]

     93 S    [scsi_eh_0]

     95 S    [scsi_eh_1]

    161 S    [scsi_eh_2]

    299 S    [jbd2/dm-0-8]

    363 S<s  /lib/systemd/systemd-journald

    391 Ss   /lib/systemd/systemd-udevd

    528 SLsl /sbin/multipathd -d -s

    577 Ssl  /usr/lib/accountsservice/accounts-daemon

    598 Ssl  /usr/sbin/irqbalance --foreground

    604 Ss   /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers

    611 Ss   /lib/systemd/systemd-logind

    638 Ssl  /usr/lib/policykit-1/polkitd --no-debug

    777 Sl   /usr/sbin/VBoxService --pidfile /var/run/vboxadd-service.sh

    794 Ss   /usr/sbin/cron -f

    799 Ss   sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups

    809 Ss+  /sbin/agetty -o -p -- \u --noclear tty1 linux

   8092 Ss   sshd: vagrant [priv]

   8834 S    sudo -s

   8835 S    /bin/bash