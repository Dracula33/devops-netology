_[Ссылка](https://github.com/netology-code/devkub-homeworks/blob/main/13-kubernetes-config-05-qbec.md) на задания_

### Задание 1

Описал [конфигурацию](./ansible/files/qbec-hw/qbec.yaml) qbec для двух окружений  
Добился, чтобы она была валидной

![1](./attachment/1.jpg)

Попробовал команды вывода компонентов и параметров

![2](./attachment/2.jpg)

Задал для _prod_ большее количество реплик

![3](./attachment/3.jpg)

Отдельно задеплоил _statefulset_, так как БД поднимается дольше backend  

![4](./attachment/4.jpg)

Потом задеплоил все оставшееся кроме БД

![5](./attachment/5.jpg)

Очень удобно, интерфейс открылся без перезапуска подов _backend_)

![6](./attachment/6.jpg)

Освоил команду удаления окружения

![7](./attachment/7.jpg)

Аналогичным образом задеплоил _prod_, с списке объектов появились _Endpoints_ и _Service_ для него

![8](./attachment/8.jpg)

---