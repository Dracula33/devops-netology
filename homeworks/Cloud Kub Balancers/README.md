
_[Ссылка](https://github.com/netology-code/clokub-homeworks/blob/clokub-5/15-2.md) на задания_

### Задание 1

1. Создадим [бакет](./terraform_host/backet.tf) и [объект](./terraform_host/bucket_object.tf) в нем

Бакет с одним объектом  
![1](./attachment/1.jpg)

Объект-картинка лежит внутри  
![2](./attachment/2.jpg)

Проверим доступность. Информация об объекте отображается. Картинка открывается  
![3](./attachment/3.jpg)

2. Создадим [группу ВМ](./terraform_host/instance_group.tf) со [стартовой страничкой](./terraform_host/cloud-init.yaml)

Группа  
![4](./attachment/4.jpg)

2 машины с образом LAMP  
![5](./attachment/5.jpg)

У группы настроена проверка состояния  
![6](./attachment/6.jpg)

По "/" возвращается стартовая страница образа  
![7](./attachment/7.jpg)

3. Создадим [сетевой балансировщик](./terraform_host/network_load_balancer.tf.bak)

Балансировщик  
![8](./attachment/8.jpg)

Целевая группа для балансировщика  
Для её создания необходимо использовать параметр _load_balancer_ при создании группы ВМ  
![9](./attachment/9.jpg)

Проверим доступность объекта из бакета  
![10](./attachment/10.jpg)

Остановим одну из ВМ и проверим доступность картинки  
![11](./attachment/11.jpg)

Политики группы ВМ через какое-то время подняли остановленный узел. Пока он лежал, картинка также открывалась  

4. Удалим сетевой балансировщик и настроим балансировщик уровня L7.  
Для этого создадим:

Целевую группу для балансировщика уровня L7  
Для её создания необходимо использовать параметр _application_load_balancer_ при создании группы ВМ  
![15](./attachment/15.jpg)

[Группу бэкендов](./terraform_host/application_backend_group.tf)  
![14](./attachment/14.jpg)

[Http-роутер](./terraform_host/application_http_router.tf) и виртуальный [хост](./terraform_host/application_virt_host.tf)  
![13](./attachment/13.jpg)

Сам [балансировщик](./terraform_host/application_load_balancer.tf)  
![12](./attachment/12.jpg)

Проверим доступность страницы через IP балансировщика уровня L7  
![16](./attachment/16.jpg)

---