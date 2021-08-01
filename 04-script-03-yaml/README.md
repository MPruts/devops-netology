1. Мы выгрузили JSON, который получили через API запрос к нашему сервису:
	```json
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            },
            { "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43
            }
        ]
    }
	```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

		{
		  "info": "Sample JSON output from our service\t",
		  "elements": [
			{
			  "name": "first",
			  "type": "server",
			  "ip": "7175"
			},
			{
			  "name": "second",
			  "type": "proxy",
			  "ip": "71.78.22.43"
			}
		  ]
		}

2. В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: { "имя сервиса" : "его IP"}. Формат записи YAML по одному сервису: - имя сервиса: его IP. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

		cat testhttp.py
		#!/usr/bin/env python3

		import socket
		import time
		import json
		import yaml

		sites = ['drive.google.com', 'mail.google.com', 'google.com']
		lastip_sites = dict.fromkeys(sites)

		while (1 == 1):
			tmp = []
			for site in sites:
				ip = socket.gethostbyname(site)
				print(site+' - '+ip)
				if ( lastip_sites[site] != str(ip) ):
					print('[ERROR] '+site+' IP mismatch: '+str(lastip_sites[site])+' '+str(ip))
				lastip_sites[site] = str(ip)
				tmp.append({str(site): str(ip)})
			print('---------------------------------')

			with open ('testhttp.yml', 'w') as th_yml:
				th_yml.write(yaml.dump(tmp))

			with open ('testhttp.json', 'w') as th_json:
				th_json.write(json.dumps(tmp, indent=2))
			time.sleep(10)