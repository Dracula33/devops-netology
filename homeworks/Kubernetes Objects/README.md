
_[Ссылка](https://github.com/netology-code/devkub-homeworks/blob/main/13-kubernetes-config-01-objects.md) на задания_

### Задание 1

Задеплоил stage окружение при помощи манифестов:
- [statefulset](./ansible/files/manifests/stage/statefulset.yaml)
- [deployment](./ansible/templates/manifests/stage/deployment.yaml.j2)
- [services](./ansible/templates/manifests/stage/services.yaml.j2)

![3](./attachment/3.jpg)

Проверил запущенность объектов

![1](./attachment/1.jpg)

Проверил интерфейс тестового приложения

![2](./attachment/2.jpg)

---

### Задание 2

Добавил несколько объектов к заданию 1. Получились следующие манифесты:
- [deployment_db](./ansible/files/manifests/prod/deployment_db.yaml)
- [deployment](./ansible/templates/manifests/prod/deployment.yaml.j2)
- [services](./ansible/templates/manifests/prod/services.yaml.j2)

Задеплоил новые манифесты, проверил объекты и перменные

![4](./attachment/4.jpg)

Интерфейс также открылся

---

### Задание 3

Создал Service и Endpoints через [манифест](./ansible/files/manifests/endpoint/service_endpoint.yaml)  
Endpoints указывает на сайт [ident.me](http://ident.me), который просто показывает ваш ip

![5](./attachment/5.jpg)

Открыл NodePort сервиса в браузере

![6](./attachment/6.jpg)

---