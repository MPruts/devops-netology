1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP
```
telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32
```

		route-views>show ip route 82.193.136.170
		Routing entry for 82.193.136.0/23
		  Known via "bgp 6447", distance 20, metric 0
		  Tag 6939, type external
		  Last update from 64.71.137.241 4w0d ago
		  Routing Descriptor Blocks:
		  * 64.71.137.241, from 64.71.137.241, 4w0d ago
			  Route metric is 0, traffic share count is 1
			  AS Hops 3
			  Route tag 6939
			  MPLS label: none
		
		route-views>sh bgp 82.193.136.170
		BGP routing table entry for 82.193.136.0/23, version 158847844
		Paths: (25 available, best #23, table default)
		  Not advertised to any peer
		  Refresh Epoch 1
		  3561 3910 3356 9002 9002 9002 9002 9002 9049 5563
			206.24.210.80 from 206.24.210.80 (206.24.210.80)
			  Origin IGP, localpref 100, valid, external
			  path 7FE1013DF530 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  3267 9049 5563
			194.85.40.15 from 194.85.40.15 (185.141.126.1)
			  Origin IGP, metric 0, localpref 100, valid, external
			  path 7FE0C4536A90 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  3333 9002 9002 9049 5563
			193.0.0.56 from 193.0.0.56 (193.0.0.56)
			  Origin IGP, localpref 100, valid, external
			  path 7FE1048659A8 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  20912 3257 1299 9049 5563
			212.66.96.126 from 212.66.96.126 (212.66.96.126)
			  Origin IGP, localpref 100, valid, external
			  Community: 3257:8095 3257:30622 3257:50001 3257:53900 3257:53904 20912:65004
			  path 7FE13C0C6D90 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  3549 3356 9002 9002 9002 9002 9002 9049 5563
			208.51.134.254 from 208.51.134.254 (67.16.168.191)
			  Origin IGP, metric 0, localpref 100, valid, external
			  Community: 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067 3549:2581 3549:30840
			  path 7FE114B50EF0 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  3356 9002 9002 9002 9002 9002 9049 5563
			4.68.4.46 from 4.68.4.46 (4.69.184.201)
			  Origin IGP, metric 0, localpref 100, valid, external
			  Community: 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067
			  path 7FE0A25F9158 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  701 1299 9049 5563
			137.39.3.55 from 137.39.3.55 (137.39.3.55)
			  Origin IGP, localpref 100, valid, external
			  path 7FE0BD4A5E40 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  53767 174 174 1299 9049 5563
			162.251.163.2 from 162.251.163.2 (162.251.162.3)
			  Origin IGP, localpref 100, valid, external
			  Community: 174:21000 174:22013 53767:5000
			  path 7FE1293FDC88 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  852 1299 9049 5563
			154.11.12.212 from 154.11.12.212 (96.1.209.43)
			  Origin IGP, metric 0, localpref 100, valid, external
			  path 7FE053C046B0 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  4901 6079 9002 9002 9049 5563
			162.250.137.254 from 162.250.137.254 (162.250.137.254)
			  Origin IGP, localpref 100, valid, external
			  Community: 65000:10100 65000:10300 65000:10400
			  path 7FE127157FA8 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 2
		  3303 6939 9049 5563
			217.192.89.50 from 217.192.89.50 (138.187.128.158)
			  Origin IGP, localpref 100, valid, external
			  Community: 3303:1006 3303:1021 3303:1030 3303:3067 6939:7040 6939:8752 6939:9002
			  path 7FE15A120B28 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  101 2914 1299 9049 5563
			209.124.176.223 from 209.124.176.223 (209.124.176.223)
			  Origin IGP, localpref 100, valid, external
			  Community: 101:20100 101:20110 101:22100 2914:420 2914:1007 2914:2000 2914:3000
			  Extended Community: RT:101:22100
			  path 7FE0ACCB2350 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 2
		  24441 3491 3491 1299 9049 5563
			202.93.8.242 from 202.93.8.242 (202.93.8.242)
			  Origin IGP, localpref 100, valid, external
			  path 7FE12AC17690 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  57866 9002 9049 5563
			37.139.139.17 from 37.139.139.17 (37.139.139.17)
			  Origin IGP, metric 0, localpref 100, valid, external
			  Community: 9002:0 9002:64667 57866:11
			  path 7FE17DA61688 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  20130 6939 9049 5563
			140.192.8.16 from 140.192.8.16 (140.192.8.16)
			  Origin IGP, localpref 100, valid, external
			  path 7FE0E6C888F0 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 4
		  8283 1299 9049 5563
			94.142.247.3 from 94.142.247.3 (94.142.247.3)
			  Origin IGP, metric 0, localpref 100, valid, external
			  Community: 1299:30000 8283:1 8283:101
			  unknown transitive attribute: flag 0xE0 type 0x20 length 0x18
				value 0000 205B 0000 0000 0000 0001 0000 205B
					  0000 0005 0000 0001
			  path 7FE175101250 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  49788 1299 9049 5563
			91.218.184.60 from 91.218.184.60 (91.218.184.60)
			  Origin IGP, localpref 100, valid, external
			  Community: 1299:30000
			  Extended Community: 0x43:100:1
			  path 7FE03B136168 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  7018 1299 9049 5563
			12.0.1.63 from 12.0.1.63 (12.0.1.63)
			  Origin IGP, localpref 100, valid, external
			  Community: 7018:5000 7018:37232
			  path 7FE04F875CB0 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  1221 4637 9002 9002 9049 5563
			203.62.252.83 from 203.62.252.83 (203.62.252.83)
			  Origin IGP, localpref 100, valid, external
			  path 7FE157A32330 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  2497 1299 9049 5563
			202.232.0.2 from 202.232.0.2 (58.138.96.254)
			  Origin IGP, localpref 100, valid, external
			  path 7FE0CA20C7C0 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  1351 6939 9049 5563
			132.198.255.253 from 132.198.255.253 (132.198.255.253)
			  Origin IGP, localpref 100, valid, external
			  path 7FE14BDBCEE0 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  7660 2516 1299 9049 5563
			203.181.248.168 from 203.181.248.168 (203.181.248.168)
			  Origin IGP, localpref 100, valid, external
			  Community: 2516:1030 7660:9003
			  path 7FE0C3703308 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  6939 9049 5563
			64.71.137.241 from 64.71.137.241 (216.218.252.164)
			  Origin IGP, localpref 100, valid, external, best
			  path 7FE009DB6210 RPKI State not found
			  rx pathid: 0, tx pathid: 0x0
		  Refresh Epoch 1
		  19214 174 1299 9049 5563
			208.74.64.40 from 208.74.64.40 (208.74.64.40)
			  Origin IGP, localpref 100, valid, external
			  Community: 174:21000 174:22013
			  path 7FE020BCE3A8 RPKI State not found
			  rx pathid: 0, tx pathid: 0
		  Refresh Epoch 1
		  3257 1299 9049 5563
			89.149.178.10 from 89.149.178.10 (213.200.83.26)
			  Origin IGP, metric 10, localpref 100, valid, external
			  Community: 3257:8794 3257:30052 3257:50001 3257:54900 3257:54901
			  path 7FE0D6E1E4B8 RPKI State not found
			  rx pathid: 0, tx pathid: 0
			  
2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.
		echo "dummy" >> /etc/modules
		echo "options dummy numdummies=2" > /etc/modprobe.d/dummy.conf
		
		cat /etc/network/interfaces
		auto lo
		iface lo inet loopback


		allow-hotplug ens3
		iface ens3 inet dhcp

		auto dummy0
		iface dummy0 inet static
				address 10.2.2.2/32
				pre-up ip link add dummy0 type dummy
				post-down ip link dell dummy0
		
		ip route add 172.16.2.0/24 via 192.168.255.1
		ip route add 10.3.3.3/32 dev dummy0
		ip route add 10.5.5.5/32 via 192.168.255.1 metric 50
		ip route add 10.5.5.5/32 via 10.2.2.2 metric 60
		
		ip -br route
		default via 192.168.255.1 dev ens3
		10.3.3.3 dev dummy0 scope link
		10.5.5.5 via 192.168.255.1 dev ens3 metric 50
		10.5.5.5 via 10.2.2.2 dev dummy0 metric 60
		172.16.2.0/24 via 192.168.255.1 dev ens3
		192.168.255.0/24 dev ens3 proto kernel scope link src 192.168.255.12
		
3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.
		
		ss -tpn
		State      Recv-Q Send-Q Local Address:Port               Peer Address:Port
		CLOSE-WAIT 1      0      127.0.0.1:35216              127.0.0.1:8080                users:(("apache2",pid=3640,fd=12))
		ESTAB      0      0      127.0.0.1:3306               127.0.0.1:34954               users:(("mysqld",pid=2551,fd=49))
		CLOSE-WAIT 1      0      127.0.0.1:35508              127.0.0.1:8080                users:(("apache2",pid=2858,fd=12))
		CLOSE-WAIT 1      0      127.0.0.1:35506              127.0.0.1:8080                users:(("apache2",pid=3629,fd=12))
		ESTAB      0      0      127.0.0.1:34954              127.0.0.1:3306                users:(("java",pid=2614,fd=100))
		CLOSE-WAIT 1      0      127.0.0.1:35218              127.0.0.1:8080                users:(("apache2",pid=2774,fd=12))
		ESTAB      0      0      127.0.0.1:3306               127.0.0.1:34880               users:(("mysqld",pid=2551,fd=46))
		ESTAB      0      0      127.0.0.1:34880              127.0.0.1:3306                users:(("java",pid=2614,fd=75))
		CLOSE-WAIT 1      0      127.0.0.1:35132              127.0.0.1:8080                users:(("apache2",pid=2885,fd=12))
		ESTAB      0      0      127.0.0.1:3306               127.0.0.1:34950               users:(("mysqld",pid=2551,fd=43))
		ESTAB      0      0      127.0.0.1:34952              127.0.0.1:3306                users:(("java",pid=2614,fd=99))
		CLOSE-WAIT 1      0      127.0.0.1:35510              127.0.0.1:8080                users:(("apache2",pid=2777,fd=12))
		CLOSE-WAIT 1      0      127.0.0.1:35188              127.0.0.1:8080                users:(("apache2",pid=2775,fd=12))
		ESTAB      0      0      127.0.0.1:3306               127.0.0.1:34952               users:(("mysqld",pid=2551,fd=48))
		ESTAB      0      64     10.113.19.44:22                 10.113.19.57:2374                users:(("sshd",pid=3525,fd=3))
		ESTAB      0      0      127.0.0.1:34950              127.0.0.1:3306                users:(("java",pid=2614,fd=96))
		CLOSE-WAIT 1      0      127.0.0.1:35184              127.0.0.1:8080                users:(("apache2",pid=4221,fd=12))
		ESTAB      0      0      10.113.19.44:80                 10.113.19.57:6806                users:(("apache2",pid=2885,fd=11))                  127.0.0.1:35184                                                                                                           127.0.0.1:8080                users:(("apache2",pid=4221,fd=12))
4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

		ss -aup
		State      Recv-Q Send-Q Local Address:Port                 Peer Address:Port
		UNCONN     0      0          *:19337                    *:*                     users:(("dhcpd",pid=6106,fd=20))
		UNCONN     0      0          *:bootps                   *:*                     users:(("dhcpd",pid=6106,fd=8))
		UNCONN     0      0      192.168.255.1:ntp                      *:*                     users:(("ntpd",pid=2602,fd=21))
		UNCONN     0      0      192.168.250.1:ntp                      *:*                     users:(("ntpd",pid=2602,fd=20))
		UNCONN     0      0      10.113.19.44:ntp                      *:*                     users:(("ntpd",pid=2602,fd=19))
		UNCONN     0      0      127.0.0.1:ntp                      *:*                     users:(("ntpd",pid=2602,fd=18))
		UNCONN     0      0          *:ntp                      *:*                     users:(("ntpd",pid=2602,fd=17))
		UNCONN     0      0         :::40583                   :::*                     users:(("dhcpd",pid=6106,fd=21))
		UNCONN     0      0         :::ntp                     :::*                     users:(("ntpd",pid=2602,fd=16))
		
5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали. 

		Файл Диаграмма.png
