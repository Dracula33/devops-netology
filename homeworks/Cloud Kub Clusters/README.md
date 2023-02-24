
_[Ссылка](https://github.com/netology-code/clokub-homeworks/blob/clokub-5/15.4.md) на задания_

### Задание 1

1. Настроил [MySql кластер](./terraform_host/mysqlcluster.tf) по заданным условиям

Сам кластер  
![2](./attachment/2.jpg)

Его ноды с репликами в разных зонах доступности  
![3](./attachment/3.jpg)

Топология кластера  
![4](./attachment/4.jpg)

Создал [базу данных](./terraform_host/mysqldatabase.tf)  
![5](./attachment/5.jpg)

Создал [пользователя](./terraform_host/mysqluser.tf)  
![6](./attachment/6.jpg)

Так как все в приватной сети, создал [nat-instance](./terraform_host/nat-instance.tf.bak), с которого проверил доступ к БД  
![1](./attachment/1.jpg)

Сохранил параметры подключения в [ConfigMap](./terraform_host/db_configmap.tf) для последующих пунктов  

---

2. Настроил [кластер Kubernetes](./terraform_host/kubercluster.tf)

Создал для кластера [сервисный аккаунт](./terraform_host/kuberservice_accounts.tf), ключ [kms](./terraform_host/kms.tf)  
![8](./attachment/8.jpg)

Создал [группу узлов](./terraform_host/kubercluster_group.tf) для кластера  
![9](./attachment/9.jpg)

Группы с автомасштабированием создались только в одном регионе  
![10](./attachment/10.jpg)

Пытался создать ноды в разных подсетях, похоже, для автомасштабирования это сделать нельзя  
![7](./attachment/7.jpg)

При помощи _yc_ получил конфиг для _kubectl_. Успешно подключился к кластеру  
![11](./attachment/11.jpg)

Задеплоил [phpmyadmin](./manifest/deployment.yaml). Проверил его через сервис с типом _NodePort_  
![12](./attachment/12.jpg)

Задеплоил сервис с типом [LoadBalancer](./manifest/service.yaml). Появился балансировщик и целевая группа  
![13](./attachment/13.jpg)

Подключился к БД через балансировщик  
![14](./attachment/14.jpg)

---