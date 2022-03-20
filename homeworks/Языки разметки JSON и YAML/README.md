### Как сдавать задания

Вы уже изучили блок «Системы управления версиями», и начиная с этого занятия все ваши работы будут приниматься ссылками на .md-файлы, размещённые в вашем публичном репозитории.

Скопируйте в свой .md-файл содержимое этого файла; исходники можно посмотреть [здесь](https://raw.githubusercontent.com/netology-code/sysadm-homeworks/devsys10/04-script-03-yaml/README.md). Заполните недостающие части документа решением задач (заменяйте `???`, ОСТАЛЬНОЕ В ШАБЛОНЕ НЕ ТРОГАЙТЕ чтобы не сломать форматирование текста, подсветку синтаксиса и прочее, иначе можно отправиться на доработку) и отправляйте на проверку. Вместо логов можно вставить скриншоты по желани.

# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
{
    "info" : "Sample JSON output from our service\t",
    "elements" :
    [
        { 
            "name" : "first",
            "type" : "server",
            "ip" : 7175 
        },
        { 
            "name" : "second",
            "type" : "proxy",
            "ip" : "71.78.22.43"
        }
    ]
}
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
import socket
import time
import json
import yaml

file_name_json = "test.json"
file_name_yml = "test.yml"

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

            hosts_for_save = []
            for host_name, ip in hosts.items():
                temp = {host_name: ip}
                hosts_for_save.append(temp)

            with open(file_name_json, 'w') as js:
                js.write(json.dumps(hosts_for_save))

            with open(file_name_yml, 'w') as ym:
                ym.write(yaml.dump(hosts_for_save, explicit_start=True, explicit_end=True))

        time.sleep(3)
```

### Вывод скрипта при запуске при тестировании:
```
google.com - 216.58.207.238
drive.google.com - 74.125.131.194
mail.google.com - 173.194.222.19
google.com - 216.58.207.238
[ERROR] drive.google.com IP mismatch: 74.125.131.194 64.233.165.194
mail.google.com - 173.194.222.19
google.com - 216.58.207.238
drive.google.com - 64.233.165.194
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
[{"drive.google.com": "64.233.165.194"}, {"mail.google.com": "173.194.222.19"}, {"google.com": "216.58.207.238"}]
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
---
- drive.google.com: 64.233.165.194
- mail.google.com: 173.194.222.19
- google.com: 216.58.207.238
...
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так как команды в нашей компании никак не могут прийти к единому мнению о том, какой формат разметки данных использовать: JSON или YAML, нам нужно реализовать парсер из одного формата в другой. Он должен уметь:
   * Принимать на вход имя файла
   * Проверять формат исходного файла. Если файл не json или yml - скрипт должен остановить свою работу
   * Распознавать какой формат данных в файле. Считается, что файлы *.json и *.yml могут быть перепутаны
   * Перекодировать данные из исходного формата во второй доступный (из JSON в YAML, из YAML в JSON)
   * При обнаружении ошибки в исходном файле - указать в стандартном выводе строку с ошибкой синтаксиса и её номер
   * Полученный файл должен иметь имя исходного файла, разница в наименовании обеспечивается разницей расширения файлов

### Ваш скрипт:
```python
#!/usr/bin/env python3

import sys
import json
import yaml

if len(sys.argv) < 2:
    print("There are not filename in the first param")
    exit(1)

filename = "test"
file_type = ''
doc = {}

with open(filename, 'r') as fn:
    first_line = fn.read(3)
    if first_line == '---':
        file_type = 'yml'
    elif first_line[:1] in ('{', '['):
        file_type = 'json'

if file_type == '':
    print('Can not identify file type')
    exit(2)

try:
    with open(filename, 'r') as fn:
        if file_type == 'yml':
            doc = yaml.safe_load(fn)
        else:
            doc = json.load(fn)
except Exception as ex:
    print(f"Input file is incorrect {file_type}. The error is:\n{ex}")
    exit(3)

new_file_type = 'json' if file_type == 'yml' else 'yml'

with open(f'{filename}.{new_file_type}', 'w') as fn:
    if file_type == 'json':
        fn.write(yaml.dump(doc, explicit_start=True, explicit_end=True))
    else:
        fn.write(json.dumps(doc))

print(f'{filename}.{new_file_type} created')

```

### Пример работы скрипта:
```
vagrant@vagrant:~$ ./2.py
There are not filename in the first param
vagrant@vagrant:~$ echo 'test' > test
vagrant@vagrant:~$ ./2.py test
Can not identify file type
vagrant@vagrant:~$ echo '[{"drive.google.com": "74.125.205.194"},' > test
vagrant@vagrant:~$ ./2.py test
Input file is incorrect json. The error is:
Expecting value: line 2 column 1 (char 41)
vagrant@vagrant:~$ echo '[{"drive.google.com": "74.125.205.194"}]' > test
vagrant@vagrant:~$ ./2.py test
test.yml created
vagrant@vagrant:~$ cat test.yml
---
- drive.google.com: 74.125.205.194
...
vagrant@vagrant:~$ echo -e "---
> - drive.google.com: 74.125.205.194
> ..." > test
vagrant@vagrant:~$ ./2.py test
test.json created
vagrant@vagrant:~$ cat test.json
[{"drive.google.com": "74.125.205.194"}]
```
