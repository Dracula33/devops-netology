
_[Ссылка](https://github.com/netology-code/devkub-homeworks/blob/main/12-kubernetes-05-cni.md) на задания_

### Задание 1

Установил кластер при помощи [Kubespray](./ansible/site.yml)  
Создал объекты для тестов

![3](./attachment/3.jpg)

Проверил, что доступны работают согласно [политикам](./ansible/files/manifests/network-policies.yaml)

![1](./attachment/1.jpg)

Единственное, у всех подов остался доступ по localhost

---

### Задание 2

Установил `calicoctl`, ознакомился с объектами

![2](./attachment/2.jpg)

---