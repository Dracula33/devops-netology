
_[Ссылка](https://github.com/netology-code/clokub-homeworks/tree/clokub-5/15.1) на задания_

### Задание 1

Создал [объекты](./terraform_host) через terraform

Nat-инстанс, 2 тестовые виртуалки

![1](./attachment/1.jpg)

public и private подсети с таблицей маршрутизации

![2](./attachment/2.jpg)

Подключился к первой тестовой виртуалке  
Доступ к интернету есть. Трафик идет напрямую со своего внешнего адреса

![3](./attachment/3.jpg)

Подключился ко второй тестовой виртуалке через первую в качестве _JumpHost_  
Доступ к интернету есть. Трафик идет с IP Nat-инстанса

![4](./attachment/4.jpg)

---