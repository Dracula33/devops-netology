
_[Ссылка](https://github.com/netology-code/clokub-homeworks/blob/clokub-5/15.3.md) на задания_

### Задание 1

1. Создадим [ключ KMS](./terraform_host/kms.tf)

Сначала создалим все ресурсы без шифрования бакета  
![1](./attachment/1.jpg)

Ключ создался  
![4](./attachment/4.jpg)

Потом изменим конфиг бакета, добавим _server_side_encryption_configuration_ для включения шифрования  
![2](./attachment/2.jpg)

Если сразу создать бакет с шифрованием, то не получается положить в него объект    
![3](./attachment/3.jpg)

Проверим настройки бакета в интерфейсе, ключ подцепился  
![5](./attachment/5.jpg)

2. Создадим статический [сайт](./terraform_host/index.html) в бакете и сделаем его доступным по https

При помощи openssl создадим сертификат  
![6](./attachment/6.jpg)

Создадим [сертификат](./terraform_host/certificate.tf) в Certificate Manager в облаке  
![8](./attachment/8.jpg)

Создадим [bucket](./terraform_host/backet.tf). Укажем в блоке _https_ ссылку на сертификат  
![11](./attachment/11.jpg)

При помощи блока _website_ включим в бакете хостинг сайта  
![9](./attachment/9.jpg)

Перейдем по ссылке на сайт  
![10](./attachment/10.jpg)

Сайт открылся по https, но на нем висит сертификат yandex.  
Для проверки своего сертификата прописал адрес yandex, в который резолвится hostname, в _hosts_  
`XXX.XXX.XXX.XXX hw-bucket`

Открыл в браузере ссылку на сайт, подтвердил несколько раз исключение безопасности, и мне выдался правильный сертификат  
![7](./attachment/7.jpg)

---