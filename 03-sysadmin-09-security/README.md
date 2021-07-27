1. Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.
		
		Выполнено. Смотри Screen8.png
		
2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.

		Выполнено. Смотри Screen9.png

3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.
	
		Выполнено. Смотри Screen1.png,Screen2.png 
		
		cat  /etc/apache2/sites-available/pmu-company.conf
		<VirtualHost *:443>
				ServerName 192.168.56.1
				DocumentRoot /var/www/pmu-company

				SSLEngine on
				SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
				SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
		</VirtualHost>
		
		ls /etc/ssl/private/ | grep apa
		apache-selfsigned.key
		
		ls /etc/ssl/certs/ | grep apa
		apache-selfsigned.crt
		
4. Проверьте на TLS уязвимости произвольный сайт в интернете.

		 ./testssl.sh -U --sneaky https://e1.ru

		###########################################################
			testssl.sh       3.1dev from https://testssl.sh/dev/
			(18dfa26 2021-07-25 16:34:58 -- )

			  This program is free software. Distribution and
					 modification under GPLv2 permitted.
			  USAGE w/o ANY WARRANTY. USE IT AT YOUR OWN RISK!

			   Please file bugs @ https://testssl.sh/bugs/

		###########################################################

		 Using "OpenSSL 1.0.2-chacha (1.0.2k-dev)" [~183 ciphers]
		 on vagrant:./bin/openssl.Linux.x86_64
		 (built: "Jan 18 17:12:17 2019", platform: "linux-x86_64")


		 Start 2021-07-27 13:47:30        -->> 195.19.220.24:443 (e1.ru) <<--

		 rDNS (195.19.220.24):   --
		 Service detected:       HTTP


		 Testing vulnerabilities

		 Heartbleed (CVE-2014-0160)                not vulnerable (OK), no heartbeat extension
		 CCS (CVE-2014-0224)                       not vulnerable (OK)
		 Ticketbleed (CVE-2016-9244), experiment.  not vulnerable (OK)
		 ROBOT                                     Server does not support any cipher suites that use RSA key transport
		 Secure Renegotiation (RFC 5746)           supported (OK)
		 Secure Client-Initiated Renegotiation     not vulnerable (OK)
		 CRIME, TLS (CVE-2012-4929)                not vulnerable (OK)
		 BREACH (CVE-2013-3587)                    no gzip/deflate/compress/br HTTP compression (OK)  - only supplied "/" tested
		 POODLE, SSL (CVE-2014-3566)               not vulnerable (OK)
		 TLS_FALLBACK_SCSV (RFC 7507)              No fallback possible (OK), no protocol below TLS 1.2 offered
		 SWEET32 (CVE-2016-2183, CVE-2016-6329)    not vulnerable (OK)
		 FREAK (CVE-2015-0204)                     not vulnerable (OK)
		 DROWN (CVE-2016-0800, CVE-2016-0703)      not vulnerable on this host and port (OK)
												   make sure you don't use this certificate elsewhere with SSLv2 enabled services
												   https://censys.io/ipv4?q=9F47FF8FEB745F883A177B74FCCF09604E2D817E335026FCA5280C7D44BE8656 could help you to find out
		 LOGJAM (CVE-2015-4000), experimental      not vulnerable (OK): no DH EXPORT ciphers, no DH key detected with <= TLS 1.2
		 BEAST (CVE-2011-3389)                     not vulnerable (OK), no SSL3 or TLS1
		 LUCKY13 (CVE-2013-0169), experimental     potentially VULNERABLE, uses cipher block chaining (CBC) ciphers with TLS. Check patches
		 Winshock (CVE-2014-6321), experimental    not vulnerable (OK) - ARIA, CHACHA or CCM ciphers found
		 RC4 (CVE-2013-2566, CVE-2015-2808)        no RC4 ciphers detected (OK)


		 Done 2021-07-27 13:47:49 [  20s] -->> 195.19.220.24:443 (e1.ru) <<--

5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.
 
		Выполнено. Смотри Screen3.png,Screen4.png,Screen5.png
		
6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.

		Выполнено. Смотри Screen6.png

7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.

		Выполнено. Смотри Screen7.png, pnet0.pcap
		