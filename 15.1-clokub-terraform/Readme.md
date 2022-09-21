### Задание 1
Для создания инфраструктуры необходимо чтобы присутствовали переменные среды:
1. export YC_TOKEN=$(yc iam create-token)
2. export YC_CLOUD_ID=$(yc config get cloud-id)
3. export YC_FOLDER_ID=$(yc config get folder-id)

Так же необходимо скачать файл [main.tf](./terraform-files/main.tf) из каталога tesrraform.

Перейти в каталог с файлом main.tf и выполнить команду `terraform apply`

#### Применение файла конфигурации terrafom

![](img/1_1.png)

#### Созданная инфраструктура в YandexCloud

![](img/1_10.png)

![](img/1_11.png)

![](img/1_12.png)

![](img/1_13.png)

![](img/1_14.png)

#### Подключение к машине NAT-инстанс

![](img/1_9.png)

#### Подключение к машине из сети Public и прверка доступа в интернет

![](img/1_2.png)

![](img/1_3.png)

![](img/1_4.png)

#### Подключение к машине из сети Private и прверка доступа в интернет

![](img/1_5.png)

![](img/1_6.png)

#### Проверка достпности машин между сетями Public и Private

![](img/1_7.png)

![](img/1_8.png)



