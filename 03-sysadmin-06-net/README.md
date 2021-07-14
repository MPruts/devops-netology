1. Работа c HTTP через телнет.
- Подключитесь утилитой телнет к сайту stackoverflow.com telnet stackoverflow.com 80
- отправьте HTTP запрос
```bash
GET /questions HTTP/1.0
HOST: stackoverflow.com
[press enter]
[press enter]
```
- В ответе укажите полученный HTTP код, что он означает?

		telnet stackoverflow.com 80
		Trying 151.101.129.69...
		Connected to stackoverflow.com.
		Escape character is '^]'.
		GET /questions HTTP/1.0
		HOST: stackoverflow.com

		HTTP/1.1 301 Moved Permanently
		cache-control: no-cache, no-store, must-revalidate
		location: https://stackoverflow.com/questions
		x-request-guid: 704d9bee-cd2b-4767-87c7-21233374d6ee
		feature-policy: microphone 'none'; speaker 'none'
		content-security-policy: upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com
		Accept-Ranges: bytes
		Date: Wed, 14 Jul 2021 05:30:23 GMT
		Via: 1.1 varnish
		Connection: close
		X-Served-By: cache-fra19141-FRA
		X-Cache: MISS
		X-Cache-Hits: 0
		X-Timer: S1626240623.215379,VS0,VE92
		Vary: Fastly-SSL
		X-DNS-Prefetch-Control: off
		Set-Cookie: prov=c5b4ea1d-f24d-73a3-782a-dfc6b4c6ccd1; domain=.stackoverflow.com; expires=Fri, 01-Jan-2055 00:00:00 GMT; path=/; HttpOnly

		Connection closed by foreign host.
		
	Код HTTP/1.1 301 Moved Permanently означает что произошло перенаправление.
	
2. Повторите задание 1 в браузере, используя консоль разработчика F12.
- откройте вкладку Network
- отправьте запрос http://stackoverflow.com
- найдите первый ответ HTTP сервера, откройте вкладку Headers
- укажите в ответе полученный HTTP код.
- проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?
- приложите скриншот консоли браузера в ответ.

Первый ответ сервера:
		
		Request URL: https://stackoverflow.com/
		Request Method: GET
		Status Code: 200 
		Remote Address: 151.101.1.69:443
		Referrer Policy: strict-origin-when-cross-origin
		accept-ranges: bytes
		cache-control: private
		content-encoding: gzip
		content-security-policy: upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com
		content-type: text/html; charset=utf-8
		date: Wed, 14 Jul 2021 05:47:44 GMT
		feature-policy: microphone 'none'; speaker 'none'
		strict-transport-security: max-age=15552000
		vary: Accept-Encoding,Fastly-SSL
		via: 1.1 varnish
		x-cache: MISS
		x-cache-hits: 0
		x-dns-prefetch-control: off
		x-frame-options: SAMEORIGIN
		x-request-guid: bca8b6b2-2baf-4b4e-aaa5-05358a234141
		x-served-by: cache-fra19144-FRA
		x-timer: S1626241664.314861,VS0,VE96
		:authority: stackoverflow.com
		:method: GET
		:path: /
		:scheme: https
		accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
		accept-encoding: gzip, deflate, br
		accept-language: ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7
		cookie: prov=c7263ae4-cc89-5c1a-2981-66f87a515624
		sec-ch-ua: " Not;A Brand";v="99", "Google Chrome";v="91", "Chromium";v="91"
		sec-ch-ua-mobile: ?0
		sec-fetch-dest: document
		sec-fetch-mode: navigate
		sec-fetch-site: none
		sec-fetch-user: ?1
		upgrade-insecure-requests: 1
		user-agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36
			
Дольше всего выполнялся первый запрос.
Файл img1.png
	
3. Какой IP адрес у вас в интернете? 

Мой адрес 92.242.3.154.

Файл img2.png
		
4. Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой whois

		whois 92.242.3.154 | grep role
		role:           MIRALOGIC NOC role

		whois  92.242.3.154 | grep origin
		origin:         AS12668
		Адрес принадлежит AS12668
		 
5. Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой traceroute 
		
		traceroute 8.8.8.8 -An
		traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
		 1  10.1.0.1 [*]  0.439 ms  0.620 ms  0.776 ms
		 2  92.242.3.153 [AS12668]  3.788 ms  3.836 ms  3.869 ms
		 3  92.242.29.158 [AS12668]  5.476 ms  6.213 ms  6.246 ms
		 4  212.188.22.34 [AS8359]  5.415 ms  6.482 ms  6.469 ms
		 5  212.188.22.33 [AS8359]  4.064 ms  5.128 ms  4.286 ms
		 6  212.188.29.249 [AS8359]  5.319 ms  2.455 ms  4.013 ms
		 7  212.188.29.85 [AS8359]  18.842 ms  18.846 ms  18.840 ms
		 8  * 195.34.50.161 [AS8359]  31.173 ms *
		 9  212.188.29.82 [AS8359]  31.878 ms  31.465 ms  31.921 ms
		10  108.170.250.99 [AS15169]  31.099 ms 108.170.250.83 [AS15169]  28.258 ms 108.170.250.99 [AS15169]  31.770 ms
		11  209.85.249.158 [AS15169]  49.150 ms 216.239.51.32 [AS15169]  49.133 ms 142.251.49.78 [AS15169]  49.082 ms
		12  216.239.48.224 [AS15169]  44.326 ms 216.239.43.20 [AS15169]  41.489 ms 108.170.235.204 [AS15169]  47.007 ms
		13  216.239.49.113 [AS15169]  44.116 ms 172.253.51.249 [AS15169]  48.744 ms 209.85.246.111 [AS15169]  46.906 ms
		14  * * *
		15  * * *
		16  * * *
		17  * * *
		18  * * *
		19  * * *
		20  * * *
		21  * * 8.8.8.8 [AS15169]  47.646 ms

6. Повторите задание 5 в утилите mtr. На каком участке наибольшая задержка - delay?
		
Наибольшая задержка на hop 10.

Файл img3.png
		
7. Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой dig
		
		dig dns.google

		; <<>> DiG 9.16.1-Ubuntu <<>> dns.google
		;; global options: +cmd
		;; Got answer:
		;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 48229
		;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

		;; OPT PSEUDOSECTION:
		; EDNS: version: 0, flags:; udp: 65494
		;; QUESTION SECTION:
		;dns.google.                    IN      A

		;; ANSWER SECTION:
		dns.google.             671     IN      A       8.8.8.8
		dns.google.             671     IN      A       8.8.4.4

		;; Query time: 48 msec
		;; SERVER: 127.0.0.53#53(127.0.0.53)
		;; WHEN: Wed Jul 14 06:20:24 UTC 2021
		;; MSG SIZE  rcvd: 71

8. Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой dig
		
		dig -x 8.8.8.8

		; <<>> DiG 9.16.1-Ubuntu <<>> -x 8.8.8.8
		;; global options: +cmd
		;; Got answer:
		;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 24071
		;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

		;; OPT PSEUDOSECTION:
		; EDNS: version: 0, flags:; udp: 65494
		;; QUESTION SECTION:
		;8.8.8.8.in-addr.arpa.          IN      PTR

		;; ANSWER SECTION:
		8.8.8.8.in-addr.arpa.   666     IN      PTR     dns.google.

		;; Query time: 0 msec
		;; SERVER: 127.0.0.53#53(127.0.0.53)
		;; WHEN: Wed Jul 14 06:22:07 UTC 2021
		;; MSG SIZE  rcvd: 73
		
		
		dig -x 8.8.4.4

		; <<>> DiG 9.16.1-Ubuntu <<>> -x 8.8.4.4
		;; global options: +cmd
		;; Got answer:
		;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 59319
		;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

		;; OPT PSEUDOSECTION:
		; EDNS: version: 0, flags:; udp: 65494
		;; QUESTION SECTION:
		;4.4.8.8.in-addr.arpa.          IN      PTR

		;; ANSWER SECTION:
		4.4.8.8.in-addr.arpa.   18987   IN      PTR     dns.google.

		;; Query time: 44 msec
		;; SERVER: 127.0.0.53#53(127.0.0.53)
		;; WHEN: Wed Jul 14 06:22:29 UTC 2021
		;; MSG SIZE  rcvd: 73