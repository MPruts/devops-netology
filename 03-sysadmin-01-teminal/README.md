##### Вывод vagrant status
>vagrant status

Current machine states:

default                   running (virtualbox)

The VM is running. To stop this VM, you can run `vagrant halt` to
shut it down forcefully, or you can run `vagrant suspend` to simply
suspend the virtual machine. In either case, to restart it again,
simply run `vagrant up`.

##### 5. Ознакомьтесь с графическим интерфейсом VirtualBox, посмотрите как выглядит виртуальная машина, которую создал для вас Vagrant, какие аппаратные ресурсы ей выделены. Какие ресурсы выделены по-умолчанию?
Memory - 1024 Mb

CPU - 2

HDD - 64 Gb

Ethernet - 1

##### 6. Ознакомьтесь с возможностями конфигурации VirtualBox через Vagrantfile: документация. Как добавить оперативной памяти или ресурсов процессора виртуальной машине?
Для изменения CPU и Memory  виртуальной машины необходимо в файле в блоке `Vagrant.configure("2") do |config|` добавить или отредактировать блок, указав необходимые значения

>config.vm.provider "virtualbox" do |vb|
>
>    vb.cpus = "4"
>
>    vb.memory = "2048"
>
>   end

##### 8.1 какой переменной можно задать длину журнала history, и на какой строчке manual это описывается
Описывается переменной  HISTSIZE. В manual описана на 595 строке

##### 8.2 что делает директива ignoreboth в bash
Явяляется директивой для HISTCONTROL и определяет чтобы в историю команд не попадали команды удовлетворяющие хотябы одному из следующих условий:

1. Если строка начинается с символа пробела
2. Если текущая введенная строка совпадает предыдущей выполненной строкой

##### 9. В каких сценариях использования применимы скобки {} и на какой строчке man bash это описано?
Используются при обозначении списка значений или списка команд. В manual описано на 197 строке.

##### 10. Основываясь на предыдущем вопросе, как создать однократным вызовом touch 100000 файлов? А получилось ли создать 300000?
touch file{1..100000} - файлы создались

Создать 300000 файлов данной командой не получилось, слишком большой список.

##### 11. В man bash поищите по /\[\[. Что делает конструкция [[ -d /tmp ]]
конструкция [[  ]] возвращает статус условного выражениия, которое заключено в скобки. В случае истины 0, в противном случае 1.

[[ -d /tmp ]] - данная конструкция выполняет проверку существования каталога /tmp и в данной системе возвращает 0

>vagrant@vagrant:~/test$ [[ -d /tmp ]]

>vagrant@vagrant:~/test$ echo $?

0

##### 12. Основываясь на знаниях о просмотре текущих (например, PATH) и установке новых переменных; командах, которые мы рассматривали, добейтесь в выводе type -a bash в виртуальной машине наличия первым пунктом в списке:
##### bash is /tmp/new_path_directory/bash
##### bash is /usr/local/bin/bash
##### bash is /bin/bash
##### (прочие строки могут отличаться содержимым и порядком)
>vagrant@vagrant:~/test$ type -a bash

bash is /usr/bin/bash

bash is /bin/bash

>vagrant@vagrant:~/test$ mkdir /tmp/new_path_directory

>vagrant@vagrant:~/test$ cp /bin/bash /tmp/new_path_directory/

>vagrant@vagrant:~/test$ PATH=/tmp/new_path_directory:$PATH

>vagrant@vagrant:~/test$ type -a bash

bash is /tmp/new_path_directory/bash

bash is /usr/bin/bash

bash is /bin/bash

##### 13. Чем отличается планирование команд с помощью batch и at?
at используется для назначения одноразового выполнения задания в указанной время.

batch используется для выполнения одноразового задания во время низкой загрузки системы или когда значение загрузки системы ниже заданного при вызове. 