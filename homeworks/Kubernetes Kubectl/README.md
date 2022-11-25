
_[Ссылка](https://github.com/netology-code/devkub-homeworks/blob/main/13-kubernetes-config-03-kubectl.md) на задания_

### Задание 1

Задеплоил приложение на кластере из трех нод. 

![9](./attachment/9.jpg)

Оказалось, сложнее чем на одной.
- из сервисов убрал `externalIp`, чтобы воркеры не падали после деплоя
- добавил [secret](./ansible/templates/manifests/secret_registry.yaml.j2), чтобы воркеры могли забрать образы из Container Registry

![1](./attachment/1.jpg)

Попробовал подключиться к backend через `exec`, получил ответ

![2](./attachment/2.jpg)

Пробросил порт через `port-forward` к frontend

![3](./attachment/3.jpg)

В соседнем терминале выполнил запрос на проброшенный порт, получил ответ

![4](./attachment/4.jpg)

Через интерактивный режим `exec -ti` получил число записей в таблице _news_

![5](./attachment/5.jpg)

---

### Задание 2

Через `scale` увеличил число реплик _frontend_ и _backend_. Поды разбежались по всем нодам

![6](./attachment/6.jpg)

Уменьшил число реплик до одной. Все лишние остановились

![7](./attachment/7.jpg)

Проверил также через `describe`, где остались поды. Оказалось, на _node2_ подов приложения не осталось

![8](./attachment/8.jpg)

---