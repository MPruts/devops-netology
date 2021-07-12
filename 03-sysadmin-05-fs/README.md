1. Узнайте о sparse (разряженных) файлах.

2. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

Файлы, являющиеся жесткими ссылками на один и тот же объект, не могут  иметь разные права доступа и владельца.  Это связано с тем что жесткая ссылка фактически ссылается на место на жестком диске(inode), то есть имеют одинаковый inode, поэтому ссылки имеют одинаковые права, владельца и время модификации. Фактически, жесткая ссылка - это еще одно имя файла.

3. Сделайте `vagrant destroy` на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:

		Vagrant.configure("2") do |config|
		  config.vm.box = "bento/ubuntu-20.04"
		  config.vm.provider :virtualbox do |vb|
			lvm_experiments_disk0_path = "/tmp/lvm_experiments_disk0.vmdk"
			lvm_experiments_disk1_path = "/tmp/lvm_experiments_disk1.vmdk"
			vb.customize ['createmedium', '--filename', lvm_experiments_disk0_path, '--size', 2560]
			vb.customize ['createmedium', '--filename', lvm_experiments_disk1_path, '--size', 2560]
			vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk0_path]
			vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk1_path]
		  end
		end
	Данная конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2.5 Гб.

4. Используя `fdisk`, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.

		fdisk /dev/sdb
			Command (m for help): n
			Partition type
				p   primary (0 primary, 0 extended, 4 free)
				e   extended (container for logical partitions)
			Select (default p): p
			Partition number (1-4, default 1):
			First sector (2048-5242879, default 2048):
			Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-5242879, default 5242879): +2G

			Created a new partition 1 of type 'Linux' and of size 2 GiB.
		
			Command (m for help): n
			Partition type
				p   primary (0 primary, 0 extended, 3 free)
				e   extended (container for logical partitions)
			Select (default p): p
			Partition number (2-4, default 2):
			First sector (4196352-5242879, default 4196352):
			Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-5242879, default 5242879):
		
			Created a new partition 2 of type 'Linux' and of size 511 MiB.
		
			Command (m for help): w
					
		fdisk -l
		Disk /dev/sda: 64 GiB, 68719476736 bytes, 134217728 sectors
		Disk model: VBOX HARDDISK
		Units: sectors of 1 * 512 = 512 bytes
		Sector size (logical/physical): 512 bytes / 512 bytes
		I/O size (minimum/optimal): 512 bytes / 512 bytes
		Disklabel type: dos
		Disk identifier: 0x551c7ad5

		Device     Boot   Start       End   Sectors  Size Id Type
		/dev/sda1  *       2048   1050623   1048576  512M  b W95 FAT32
		/dev/sda2       1052670 134215679 133163010 63.5G  5 Extended
		/dev/sda5       1052672 134215679 133163008 63.5G 8e Linux LVM


		Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
		Disk model: VBOX HARDDISK
		Units: sectors of 1 * 512 = 512 bytes
		Sector size (logical/physical): 512 bytes / 512 bytes
		I/O size (minimum/optimal): 512 bytes / 512 bytes
		Disklabel type: dos
		Disk identifier: 0xff3b33a1

		Device     Boot   Start     End Sectors  Size Id Type
		/dev/sdb1          2048 4196351 4194304    2G 83 Linux
		/dev/sdb2       4196352 5242879 1046528  511M 83 Linux


		Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
		Disk model: VBOX HARDDISK
		Units: sectors of 1 * 512 = 512 bytes
		Sector size (logical/physical): 512 bytes / 512 bytes
		I/O size (minimum/optimal): 512 bytes / 512 bytes


		Disk /dev/mapper/vgvagrant-root: 62.55 GiB, 67150807040 bytes, 131153920 sectors
		Units: sectors of 1 * 512 = 512 bytes
		Sector size (logical/physical): 512 bytes / 512 bytes
		I/O size (minimum/optimal): 512 bytes / 512 bytes


		Disk /dev/mapper/vgvagrant-swap_1: 980 MiB, 1027604480 bytes, 2007040 sectors
		Units: sectors of 1 * 512 = 512 bytes
		Sector size (logical/physical): 512 bytes / 512 bytes
		I/O size (minimum/optimal): 512 bytes / 512 bytes

		

5. Используя `sfdisk`, перенесите данную таблицу разделов на второй диск.

		sfdisk -d /dev/sdb | sfdisk /dev/sdc
		Checking that no-one is using this disk right now ... OK

		Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
		Disk model: VBOX HARDDISK
		Units: sectors of 1 * 512 = 512 bytes
		Sector size (logical/physical): 512 bytes / 512 bytes
		I/O size (minimum/optimal): 512 bytes / 512 bytes

		>>> Script header accepted.
		>>> Script header accepted.
		>>> Script header accepted.
		>>> Script header accepted.
		>>> Created a new DOS disklabel with disk identifier 0xff3b33a1.
		/dev/sdc1: Created a new partition 1 of type 'Linux' and of size 2 GiB.
		/dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.
		/dev/sdc3: Done.

		New situation:
		Disklabel type: dos
		Disk identifier: 0xff3b33a1

		Device     Boot   Start     End Sectors  Size Id Type
		/dev/sdc1          2048 4196351 4194304    2G 83 Linux
		/dev/sdc2       4196352 5242879 1046528  511M 83 Linux

		The partition table has been altered.
		Calling ioctl() to re-read partition table.
		Syncing disks.	

6. Соберите `mdadm` RAID1 на паре разделов 2 Гб.

		mdadm --create /dev/md0 -l 1 -n 2 /dev/sdb1 /dev/sdc1
		mdadm: Note: this array has metadata at the start and
			may not be suitable as a boot device.  If you plan to
			store '/boot' on this device please ensure that
			your boot-loader understands md/v1.x metadata, or use
			--metadata=0.90
		Continue creating array? y
		mdadm: Defaulting to version 1.2 metadata
		mdadm: array /dev/md0 started.
		
		lsblk
		NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
		sda                    8:0    0   64G  0 disk
		├─sda1                 8:1    0  512M  0 part  /boot/efi
		├─sda2                 8:2    0    1K  0 part
		└─sda5                 8:5    0 63.5G  0 part
		  ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
		  └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
		sdb                    8:16   0  2.5G  0 disk
		├─sdb1                 8:17   0    2G  0 part
		│ └─md0                9:0    0    2G  0 raid1
		└─sdb2                 8:18   0  511M  0 part
		sdc                    8:32   0  2.5G  0 disk
		├─sdc1                 8:33   0    2G  0 part
		│ └─md0                9:0    0    2G  0 raid1
		└─sdc2                 8:34   0  511M  0 part

7. Соберите `mdadm` RAID0 на второй паре маленьких разделов.

		mdadm --create /dev/md1 -l 0 -n 2 /dev/sdb2 /dev/sdc2
		mdadm: Defaulting to version 1.2 metadata
		mdadm: array /dev/md1 started.
		lsblk
		NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
		sda                    8:0    0   64G  0 disk
		├─sda1                 8:1    0  512M  0 part  /boot/efi
		├─sda2                 8:2    0    1K  0 part
		└─sda5                 8:5    0 63.5G  0 part
		  ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
		  └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
		sdb                    8:16   0  2.5G  0 disk
		├─sdb1                 8:17   0    2G  0 part
		│ └─md0                9:0    0    2G  0 raid1
		└─sdb2                 8:18   0  511M  0 part
		  └─md1                9:1    0 1018M  0 raid0
		sdc                    8:32   0  2.5G  0 disk
		├─sdc1                 8:33   0    2G  0 part
		│ └─md0                9:0    0    2G  0 raid1
		└─sdc2                 8:34   0  511M  0 part
		  └─md1                9:1    0 1018M  0 raid0

8. Создайте 2 независимых PV на получившихся md-устройствах.

		pvcreate /dev/md0 /dev/md1
		  Physical volume "/dev/md0" successfully created.
		  Physical volume "/dev/md1" successfully created.

		pvdisplay
		  --- Physical volume ---
		  PV Name               /dev/sda5
		  VG Name               vgvagrant
		  PV Size               <63.50 GiB / not usable 0
		  Allocatable           yes (but full)
		  PE Size               4.00 MiB
		  Total PE              16255
		  Free PE               0
		  Allocated PE          16255
		  PV UUID               uMWVeB-SwGW-y0XL-7DKQ-fN0L-zsHh-SIBf2y

		  "/dev/md0" is a new physical volume of "<2.00 GiB"
		  --- NEW Physical volume ---
		  PV Name               /dev/md0
		  VG Name
		  PV Size               <2.00 GiB
		  Allocatable           NO
		  PE Size               0
		  Total PE              0
		  Free PE               0
		  Allocated PE          0
		  PV UUID               1dFKXW-0RzP-YQsx-CQo9-gnMy-L01v-FDQcZF

		  "/dev/md1" is a new physical volume of "1018.00 MiB"
		  --- NEW Physical volume ---
		  PV Name               /dev/md1
		  VG Name
		  PV Size               1018.00 MiB
		  Allocatable           NO
		  PE Size               0
		  Total PE              0
		  Free PE               0
		  Allocated PE          0
		  PV UUID               FoBS2e-aNN0-WjHP-kSmX-IIad-ML6k-oEtmif

9. Создайте общую volume-group на этих двух PV.

		vgcreate vg1 /dev/md0 /dev/md1
		  Volume group "vg1" successfully created

		vgdisplay
		  --- Volume group ---
		  VG Name               vgvagrant
		  System ID
		  Format                lvm2
		  Metadata Areas        1
		  Metadata Sequence No  3
		  VG Access             read/write
		  VG Status             resizable
		  MAX LV                0
		  Cur LV                2
		  Open LV               2
		  Max PV                0
		  Cur PV                1
		  Act PV                1
		  VG Size               <63.50 GiB
		  PE Size               4.00 MiB
		  Total PE              16255
		  Alloc PE / Size       16255 / <63.50 GiB
		  Free  PE / Size       0 / 0
		  VG UUID               7BSgp8-ukNs-898j-wRdT-jDVA-TLU9-sSZ36F

		  --- Volume group ---
		  VG Name               vg1
		  System ID
		  Format                lvm2
		  Metadata Areas        2
		  Metadata Sequence No  1
		  VG Access             read/write
		  VG Status             resizable
		  MAX LV                0
		  Cur LV                0
		  Open LV               0
		  Max PV                0
		  Cur PV                2
		  Act PV                2
		  VG Size               <2.99 GiB
		  PE Size               4.00 MiB
		  Total PE              765
		  Alloc PE / Size       0 / 0
		  Free  PE / Size       765 / <2.99 GiB
		  VG UUID               oAnRgq-5OGo-rQx5-rCDE-5Ick-i4mU-diD2ss

10. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.

		lvcreate -L 100M -n lv1 vg1 /dev/md1
		  Logical volume "lv1" created.

		lvdisplay /dev/vg1/lv1
		  --- Logical volume ---
		  LV Path                /dev/vg1/lv1
		  LV Name                lv1
		  VG Name                vg1
		  LV UUID                ZYiZcf-FPrV-hcHr-RwiD-qgJ8-ePJF-wt68su
		  LV Write Access        read/write
		  LV Creation host, time vagrant, 2021-07-12 02:31:00 +0000
		  LV Status              available
		  # open                 0
		  LV Size                100.00 MiB
		  Current LE             25
		  Segments               1
		  Allocation             inherit
		  Read ahead sectors     auto
		  - currently set to     4096
		  Block device           253:2

11. Создайте `mkfs.ext4` ФС на получившемся LV.

		mkfs.ext4 /dev/vg1/lv1
		mke2fs 1.45.5 (07-Jan-2020)
		Creating filesystem with 25600 4k blocks and 25600 inodes

		Allocating group tables: done
		Writing inode tables: done
		Creating journal (1024 blocks): done
		Writing superblocks and filesystem accounting information: done

12. Смонтируйте этот раздел в любую директорию, например, `/tmp/new`.

		mkdir /tmp/new
		mount /dev/vg1/lv1 /tmp/new/

		df -h /dev/vg1/lv1
		Filesystem           Size  Used Avail Use% Mounted on
		/dev/mapper/vg1-lv1   93M   72K   86M   1% /tmp/new

13. Поместите туда тестовый файл, например `wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz`.

		wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
		--2021-07-12 02:37:30--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
		Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
		Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
		HTTP request sent, awaiting response... 200 OK
		Length: 21017227 (20M) [application/octet-stream]
		Saving to: ‘/tmp/new/test.gz’

		/tmp/new/test.gz                                            100%[========================================================================================================================================>]  20.04M  10.2MB/s    in 2.0s

		2021-07-12 02:37:32 (10.2 MB/s) - ‘/tmp/new/test.gz’ saved [21017227/21017227]
		
		ls /tmp/new/
		lost+found  test.gz

14. Прикрепите вывод `lsblk`.

		lsblk
		NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
		sda                    8:0    0   64G  0 disk
		├─sda1                 8:1    0  512M  0 part  /boot/efi
		├─sda2                 8:2    0    1K  0 part
		└─sda5                 8:5    0 63.5G  0 part
		  ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
		  └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
		sdb                    8:16   0  2.5G  0 disk
		├─sdb1                 8:17   0    2G  0 part
		│ └─md0                9:0    0    2G  0 raid1
		└─sdb2                 8:18   0  511M  0 part
		  └─md1                9:1    0 1018M  0 raid0
			└─vg1-lv1        253:2    0  100M  0 lvm   /tmp/new
		sdc                    8:32   0  2.5G  0 disk
		├─sdc1                 8:33   0    2G  0 part
		│ └─md0                9:0    0    2G  0 raid1
		└─sdc2                 8:34   0  511M  0 part
		  └─md1                9:1    0 1018M  0 raid0
			└─vg1-lv1        253:2    0  100M  0 lvm   /tmp/new

15. Протестируйте целостность файла:

		root@vagrant:~# gzip -t /tmp/new/test.gz
		root@vagrant:~# echo $?
		0

	Вывод команд, описанных выше, идентичен. Файл успешно прошел проверку.
		
		gzip -t /tmp/new/test.gz
		echo $?
		0

16. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

		pvmove -n lv1 /dev/md1 /dev/md0
		  /dev/md1: Moved: 12.00%
		  /dev/md1: Moved: 100.00%

		lsblk
		NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
		sda                    8:0    0   64G  0 disk
		├─sda1                 8:1    0  512M  0 part  /boot/efi
		├─sda2                 8:2    0    1K  0 part
		└─sda5                 8:5    0 63.5G  0 part
		  ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
		  └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
		sdb                    8:16   0  2.5G  0 disk
		├─sdb1                 8:17   0    2G  0 part
		│ └─md0                9:0    0    2G  0 raid1
		│   └─vg1-lv1        253:2    0  100M  0 lvm   /tmp/new
		└─sdb2                 8:18   0  511M  0 part
		  └─md1                9:1    0 1018M  0 raid0
		sdc                    8:32   0  2.5G  0 disk
		├─sdc1                 8:33   0    2G  0 part
		│ └─md0                9:0    0    2G  0 raid1
		│   └─vg1-lv1        253:2    0  100M  0 lvm   /tmp/new
		└─sdc2                 8:34   0  511M  0 part
		  └─md1                9:1    0 1018M  0 raid0
		  
17. Сделайте --fail на устройство в вашем RAID1 md.

		mdadm --fail /dev/md0 /dev/sdb1
		mdadm: set /dev/sdb1 faulty in /dev/md0

18. Подтвердите выводом dmesg, что RAID1 работает в деградированном состоянии.

		dmesg
		[225019.563115] md/raid1:md0: Disk failure on sdb1, disabling device.
						md/raid1:md0: Operation continuing on 1 devices.

19. Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:

		root@vagrant:~# gzip -t /tmp/new/test.gz
		root@vagrant:~# echo $?
		0

	После определения диска как сбойного в RAID1 выполненние выше команды соответствуют выводу в консоли. Диск lv1 продолжил работать в нормальном режиме несвмотря на деградацию RAID1.

		gzip -t /tmp/new/test.gz
		echo $?
		0

20. Погасите тестовый хост, vagrant destroy.

	Выполнено.