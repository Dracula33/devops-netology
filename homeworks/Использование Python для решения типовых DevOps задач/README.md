### Как сдавать задания

Вы уже изучили блок «Системы управления версиями», и начиная с этого занятия все ваши работы будут приниматься ссылками на .md-файлы, размещённые в вашем публичном репозитории.

Скопируйте в свой .md-файл содержимое этого файла; исходники можно посмотреть [здесь](https://raw.githubusercontent.com/netology-code/sysadm-homeworks/devsys10/04-script-02-py/README.md). Заполните недостающие части документа решением задач (заменяйте `???`, ОСТАЛЬНОЕ В ШАБЛОНЕ НЕ ТРОГАЙТЕ чтобы не сломать форматирование текста, подсветку синтаксиса и прочее, иначе можно отправиться на доработку) и отправляйте на проверку. Вместо логов можно вставить скриншоты по желани.

# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ                                               |
| ------------- |-----------------------------------------------------|
| Какое значение будет присвоено переменной `c`?  | Никакое. Будет TypeError из-за несоответствия типов |
| Как получить для переменной `c` значение 12?  | добавить преобразование типа `c = str(a) + b`       |
| Как получить для переменной `c` значение 3?  | добавить преобразование типа `c = a + int(b)`       |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os

repository_home = '~/netology-code/sysadm-homeorks'
bash_command = ["cd " + repository_home, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', repository_home + '/')
        print(prepare_result)
```

### Вывод скрипта при запуске при тестировании:
```
~/netology-code/sysadm-homeorks/01-intro-01/img/bash.png
~/netology-code/sysadm-homeorks/README.md
```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os
import sys

if len(sys.argv) < 2:
    print('First parameter must be a repository path')
    exit(1)
else:
    repository_home = sys.argv[1]
    bash_command = ["cd " + repository_home + ' 2>&1', "git status 2>&1"]
    result_os = os.popen(' && '.join(bash_command)).read()
    if result_os.find('not a git repository') != -1:
        print('This is not a GIT repository')
        exit(2)
    elif result_os.find('can\'t cd') != -1:
        print('Invalid directory')
        exit(3)
    is_change = False
    for result in result_os.split('\n'):
        if result.find('modified') != -1:
            prepare_result = result.replace('\tmodified:   ', repository_home + '/')
            print(prepare_result)
```

### Вывод скрипта при запуске при тестировании:
```
vagrant@vagrant:~$ ./1.py ~/netology
Invalid directory
vagrant@vagrant:~$ ./1.py ~/netology-code
This is not a GIT repository
vagrant@vagrant:~$ ./1.py ~/netology-code/sysadm-homeorks
/home/vagrant/netology-code/sysadm-homeorks/01-intro-01/img/bash.png
/home/vagrant/netology-code/sysadm-homeorks/README.md
```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
import socket
import time

hosts_temp = ('drive.google.com', 'mail.google.com', 'google.com')

hosts = {}
for host in hosts_temp:
    current_ip = socket.gethostbyname(host)
    hosts[host] = current_ip

while True:
    for hostname, ip in hosts.items():
        current_ip = socket.gethostbyname(hostname)
        if ip == current_ip:
            print(f'{hostname} - {current_ip}')
        else:
            print(f'[ERROR] {hostname} IP mismatch: {ip} {current_ip}')
            hosts[hostname] = current_ip
        time.sleep(3)
```

### Вывод скрипта при запуске при тестировании:
```
google.com - 173.194.73.139
drive.google.com - 64.233.165.194
mail.google.com - 173.194.222.19
google.com - 173.194.73.139
drive.google.com - 64.233.165.194
mail.google.com - 173.194.222.19
[ERROR] google.com IP mismatch: 173.194.73.139 173.194.73.138
drive.google.com - 64.233.165.194
mail.google.com - 173.194.222.19
google.com - 173.194.73.138
drive.google.com - 64.233.165.194
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так получилось, что мы очень часто вносим правки в конфигурацию своей системы прямо на сервере. Но так как вся наша команда разработки держит файлы конфигурации в github и пользуется gitflow, то нам приходится каждый раз переносить архив с нашими изменениями с сервера на наш локальный компьютер, формировать новую ветку, коммитить в неё изменения, создавать pull request (PR) и только после выполнения Merge мы наконец можем официально подтвердить, что новая конфигурация применена. Мы хотим максимально автоматизировать всю цепочку действий. Для этого нам нужно написать скрипт, который будет в директории с локальным репозиторием обращаться по API к github, создавать PR для вливания текущей выбранной ветки в master с сообщением, которое мы вписываем в первый параметр при обращении к py-файлу (сообщение не может быть пустым). При желании, можно добавить к указанному функционалу создание новой ветки, commit и push в неё изменений конфигурации. С директорией локального репозитория можно делать всё, что угодно. Также, принимаем во внимание, что Merge Conflict у нас отсутствуют и их точно не будет при push, как в свою ветку, так и при слиянии в master. Важно получить конечный результат с созданным PR, в котором применяются наши изменения. 

### Ваш скрипт:
```python
 #!/usr/bin/env python3

#должна быть настроена авторизация по ключу на удаленный сервер
remote_host_credentials = 'vagrant@127.0.0.1'
remote_host_repo_path = '/home/vagrant/GIT/remote_server'

local_repo_path = '/home/vagrant/GIT/local_repos'

github_access_token = '***************'
github_repository_name = 'devops-netology'


import sys
from subprocess import Popen, PIPE, STDOUT
from datetime import datetime
from github import Github

#проверяем значение первого параметра, передано ли сообщение для коммита
if len(sys.argv) < 2:
    print('First parameter must be a message for commit')
    exit(1)

#создаем в локальном репозитории новую ветку для заливки изменений с прода
temp_branch_name = 'from_prod_' + datetime.now().strftime("%Y%m%d%H%M%S")
print(f"Creating new local branch {temp_branch_name}")

bash_command = ['cd ' + local_repo_path, 'git checkout main', 'git pull', 'git checkout -b ' + temp_branch_name]
result_os = Popen(' && '.join(bash_command), shell=True, stdout=PIPE, stderr=STDOUT).communicate()[0].decode("utf-8")
if result_os.find("Switched to a new branch") == -1:
    print('Can not create temp branch in local repo')
    exit(2)

print("Checking remote repo changes")
#проверяем изменения на удаленном сервере
bash_command = f"ssh {remote_host_credentials} 'cd {remote_host_repo_path} && git status -s | cut -c 4-'"
result_os = Popen(bash_command, shell=True, stdout=PIPE, stderr=STDOUT).communicate()[0].decode("utf-8")
if len(result_os) == 0:
    print('There are not any changes in remote server')
    exit(3)

print("Preparing archive with changes")
#готовим архив с изменениями
changed_files = ','.join(result_os.split('\n'))
changed_files = changed_files[:-1]
bash_command = [f'mkdir /tmp/{temp_branch_name}', f'cd {remote_host_repo_path}', "bash -c 'cp --parents {" + changed_files + '} /tmp/' + temp_branch_name + "'", 'cd /tmp/', f'tar -czf {temp_branch_name}.tgz {temp_branch_name}']
result_os = Popen(' && '.join(bash_command), shell=True, stdout=PIPE, stderr=STDOUT).communicate()[0].decode("utf-8")
if len(result_os) != 0:
    print('Can not get archive with changed files')
    exit(4)

print("Receiving archive from remote server")
#копируем архив с прода
bash_command = f'scp {remote_host_credentials}:/tmp/{temp_branch_name}.tgz /tmp/'
result_os = Popen(bash_command, shell=True, stdout=PIPE, stderr=STDOUT).communicate()[0].decode("utf-8")

print("Applying remote changes on local repo")
#применяем изменения с прода на локальном репозитории и отправляем на гитхаб
#на гитхабе нужна авторизация по ключу
bash_command = f'cd /tmp && tar -xzf {temp_branch_name}.tgz && cp -rf {temp_branch_name}/* {local_repo_path} && cd {local_repo_path} && git add -A && git commit -m "auto commit:{temp_branch_name}" && git push origin {temp_branch_name}'
result_os = Popen(bash_command, shell=True, stdout=PIPE, stderr=STDOUT).communicate()[0].decode("utf-8")
if result_os.find("new branch") == -1:
    print("Can not apply changes to local repo")
    exit(5)

print("Creating PR on GinHub")
#создаем pull-request
try:
    gh = Github(github_access_token)
    pr = gh.get_user().get_repo(github_repository_name).create_pull(f'PR for {temp_branch_name}', sys.argv[1], 'main', temp_branch_name)
except Exception:
    print('Error while connecting GitHub')
    exit(6)

print(f'Pull Request with number={pr.number} created')

```

### Вывод скрипта при запуске при тестировании:
```
vagrant@vagrant:~$ cd GIT/local_repos/
vagrant@vagrant:~/GIT/local_repos$ git status
On branch from_prod_20220316195623
nothing to commit, working tree clean
vagrant@vagrant:~/GIT/local_repos$ cd ../remote_server/
vagrant@vagrant:~/GIT/remote_server$ git status -s
 M README.md
?? terraform/test.txt
vagrant@vagrant:~/GIT/remote_server$

vagrant@vagrant:~$ ./sync_repos.py "Подготовка к установке 16.03.22 в 23:02"
Creating new local branch from_prod_20220316200306
Checking remote repo changes
Preparing archive with changes
Receiving archive from remote server
Applying remote changes on local repo
Creating PR on GinHub
Pull Request with number=5 created
vagrant@vagrant:~$
```
