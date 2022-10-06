_[Ссылка](https://github.com/netology-code/mnt-homeworks/tree/MNT-13/09-ci-06-gitlab) на задания_

### Подготовка

Репозиторий в GitLab доступен по адресу https://isoldatov.gitlab.yandexcloud.net/isoldatov/homework-gitlab

Поднял GitLab и все остальное по инструкции.  
Подключил Runner  

![1](./attachment/1.jpg)

Добавил переменные  
![7](./attachment/7.jpg)

---
### DevOps часть

Сделал [Dockerfile](./gitlab-repo/Dockerfile) по сборке контейнера. Описал стейджи build и deploy сборки в [CI файле](./gitlab-repo/.gitlab-ci.yml)  

Проверил, что оно работает правильно. На main выполняются два стейджа
![4](./attachment/4.jpg)

Проверил, что образ попадает в Container Registry  
![3](./attachment/3.jpg)  

---  
### Product Owner часть

Создал Issue, поставил зеленый label  

![5](./attachment/5.jpg)

---
### Developer часть

Внес изменения в код, закоммитил в новую ветку, создал Merge request

![6](./attachment/6.jpg)

Проверил, что на ветке `issue1` все собралось корректно.  
Принял Merge request.  
На main все также собралось и задеплоилось корректно

![8](./attachment/8.jpg)

---
### Tester часть

Добавил в [CI](./gitlab-repo/.gitlab-ci.yml) stage `test`. После некоторых итераций в ветке `autotest` удалось получить результат от приложения  
![9](./attachment/9.jpg)

Добавил его автоматическую обработку и выход с кодом 1, если подстроки Running в ответе не найдено.  
Проверил работу в ветке `autotest-check` (изменил ответ сервиса на другой в .py файле), сборка завалилась на стейдже `test`  
Смерджил изменения в `main`, отработало 3 стейджа  
![10](./attachment/10.jpg)

Закрыл задачу с комментарием  
![11](./attachment/11.jpg)

---