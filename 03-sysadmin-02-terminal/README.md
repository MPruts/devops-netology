##### 1. Какого типа команда cd? Попробуйте объяснить, почему она именно такого типа; опишите ход своих мыслей, если считаете что она могла бы быть другого типа.
Команда cd является встроенной (builtin) командой linux. Она этого типа потому что она выполняет только одну конкретную операцию, описанную в бинарным исполняемым файлом, так как она необходима для непосредственного взаимодействия со средой.

##### 2. Какая альтернатива без pipe команде grep <some_string> <some_file> | wc -l? man grep поможет в ответе на этот вопрос. Ознакомьтесь с документом о других подобных некорректных вариантах использования pipe.
grep <some_string> <some_file> -c является альтернативой команды grep <some_string> <some_file> | wc -l?

##### 3. Какой процесс с PID 1 является родителем для всех процессов в вашей виртуальной машине Ubuntu 20.04?
PID 1 - процесс systemd

> vagrant@vagrant:~$ pstree -p

systemd(1)─┬─VBoxService(818)─┬─{VBoxService}(820)

##### 4. Как будет выглядеть команда, которая перенаправит вывод stderr ls на другую сессию терминала?
ls /root 2>/dev/pts/<номер терминала для перенаправления>, например:

при запуске команды в терминале pts1 команды

> ls /root 2>/dev/pts/0

на экране терминала pts0 появится сообщение: ls: cannot open directory '/root': Permission denied

##### 5. Получится ли одновременно передать команде файл на stdin и вывести ее stdout в другой файл? Приведите работающий пример.
Получится

> head < file1 1>file2

##### 6. Получится ли вывести находясь в графическом режиме данные из PTY в какой-либо из эмуляторов TTY? Сможете ли вы наблюдать выводимые данные?
При выполнении команды от пользователя root вывод команды из PTY, который открыт в графическом режиме, происходит в TTY. Для того чтобы просмотреть результат выполнения команды нужно переключиться из графического режима в указанный TTY.

Пример команды:

> ls / 1>/dev/tty2

в результате в консоли TTY2 будет отражено содержимое каталого /

##### 7. Выполните команду bash 5>&1. К чему она приведет? Что будет, если вы выполните echo netology > /proc/$$/fd/5? Почему так происходит?
Команда bash 5>&1 производит перенаправление дескриптора 5 в дескриптор stdout 1. Это преведет к тому что данные направленные в дескриптор 5 будут перенаправлены в дескриптор stdout 1.

Выполнение команды `echo netology > /proc/$$/fd/5` произойдет вывод на экран сообщения netology.

Это связано с тем что что выполнение команды направлено на передачу данных в дескриптор 5, который предыдущей командой был перенаправлен в дескриптор stdout 1.

##### 8. Получится ли в качестве входного потока для pipe использовать только stderr команды, не потеряв при этом отображение stdout на pty? Напоминаем: по умолчанию через pipe передается только stdout команды слева от | на stdin команды справа. Это можно сделать, поменяв стандартные потоки местами через промежуточный новый дескриптор, который вы научились создавать в предыдущем вопросе.
Получится.

Пример:

> find / -name "file*" 5>&1 1>&2 2>&5 | grep ar

В результате будет произведен поиск файлов с содержащих в имени "file" в каталоге / и выведен на экран, кроме того будет произведена фильтраци ошибочных сообщений, будут выведены только те, в которых присутствуют символы "ar"

##### 9. Что выведет команда cat /proc/$$/environ? Как еще можно получить аналогичный по содержанию вывод?
Команда выводит список переменных среды. Аналогичную информацию можно получить выполнив команду `env`

##### 10. Иcmспользуя man, опишите что доступно по адресам /proc/<PID>/cmdline, /proc/<PID>/exe
`/proc/<PID>/cmdline` содержит полную команду запуска процесса, только если процесс не стал зомби, в таком случае будет пустой.

`/proc/<PID>/exe` содержит символическую ссылку к исполняемой команде.

##### 11. Узнайте, какую наиболее старшую версию набора инструкций SSE поддерживает ваш процессор с помощью /proc/cpuinfo.
> cat /proc/cpuinfo | grep sse

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni pclmulqdq ssse3 cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti fsgsbase avx2 invpcid rdseed clflushopt md_clear flush_l1d

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni pclmulqdq ssse3 cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti fsgsbase avx2 invpcid rdseed clflushopt md_clear flush_l1d

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni pclmulqdq ssse3 cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti fsgsbase avx2 invpcid rdseed clflushopt md_clear flush_l1d

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni pclmulqdq ssse3 cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti fsgsbase avx2 invpcid rdseed clflushopt md_clear flush_l1d

Последняя sse версия на моем процессоре - sse4.1 и sse4.2

##### 12. При открытии нового окна терминала и vagrant ssh создается новая сессия и выделяется pty. Это можно подтвердить командой tty, которая упоминалась в лекции 3.2. Однако:
##### > vagrant@netology1:~$ ssh localhost 'tty'
##### not a tty
##### Почитайте, почему так происходит, и как изменить поведение.
Так происходи потому что при выполнении команды не происходит выделение терминала. Если ввести данну команду с атрибутом -t, то произойдет принудительное выделение терминала для выполнения команды.

> vagrant@vagrant:~$ ssh localhost -t 'tty'

vagrant@localhost's password:

/dev/pts/1

Connection to localhost closed.

###### 13. Бывает, что есть необходимость переместить запущенный процесс из одной сессии в другую. Попробуйте сделать это, воспользовавшись reptyr. Например, так можно перенести в screen процесс, который вы запустили по ошибке в обычной SSH-сессии.
Проверил, работает.

###### 14. sudo echo string > /root/new_file не даст выполнить перенаправление под обычным пользователем, так как перенаправлением занимается процесс shell'а, который запущен без sudo под вашим пользователем. Для решения данной проблемы можно использовать конструкцию echo string | sudo tee /root/new_file. Узнайте что делает команда tee и почему в отличие от sudo echo команда с sudo tee будет работать.
Команда tee выполняет перенаправление входного потока в поток вывода и в один или несколько файлов.

`sudo echo` выполнится с повышенными правами, но передача стандартного потока вывадо будет происходить с правами обычного пользователя, у которого недостаточно привелегий на запись в каталог /root.

`sudo tee` команда получит в качестве входного потока данные, но при этом сама команда tee будет выполняться с повышенными правами, а значит у нее появятся права на запись в каталог /root.
