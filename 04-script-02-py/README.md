1. Есть скрипт:
	```python
    #!/usr/bin/env python3
	a = 1
	b = '2'
	c = a + b
	```
	* Какое значение будет присвоено переменной c?
	
		Будет выдано сообщение об ошибке, так как происходит сложение переменных разных типов
	
	* Как получить для переменной c значение 12?
		
		c = str(a)+b
	
	* Как получить для переменной c значение 3?
		
		c = a + int(b)
		
2. Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

	```python
    #!/usr/bin/env python3

    import os

	bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
	result_os = os.popen(' && '.join(bash_command)).read()
    is_change = False
	for result in result_os.split('\n'):
        if result.find('modified') != -1:
            prepare_result = result.replace('\tmodified:   ', '')
            print(prepare_result)
            break
	```
		#!/usr/bin/env python3
		import os

		path = '/home/vagrant/netology/devops-netology'
		bash_command = ["cd "+path, "git status"]

		result_os = os.popen(' && '.join(bash_command)).read()
		is_change = False

		for result in result_os.split('\n'):
		  if result.find('modified') != -1:
			prepare_result = result.replace('\tmodified:   ', '')
			print(path+'/'+prepare_result)

3. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

		cat check.py
		#!/usr/bin/env python3
		import os
		import sys

		path = sys.argv[1]

		if path[-1] == '/':
			path = path[:-1]

		if os.path.exists(path) :
			bash_command = ["cd "+path, "git status 2>&1"]

			result_os = os.popen(' && '.join(bash_command)).read()

			if result_os.find('fatal: not a git repository') != -1:
				print('Каталог не является git репозиторием')
				sys.exit()

			is_change = False

			for result in result_os.split('\n'):
				if result.find('modified') != -1:
					prepare_result = result.replace('\tmodified:   ', '')
					print(path+'/'+prepare_result)
		else:
			print('Каталог не существует')
			sys.exit()

4. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: drive.google.com, mail.google.com, google.com.

		cat testhttp.py
		#!/usr/bin/env python3

		import socket
		import time

		sites = ['drive.google.com', 'mail.google.com', 'google.com']
		lastip_sites = dict.fromkeys(sites)

		while (1 == 1):
			for site in sites:
				ip = socket.gethostbyname(site)
				print(site+' - '+ip)
				if ( lastip_sites[site] != str(ip) ):
					print('[ERROR] '+site+' IP mismatch: '+str(lastip_sites[site])+' '+str(ip))
				lastip_sites[site] = str(ip)
			print('---------------------------------')
			time.sleep(3)