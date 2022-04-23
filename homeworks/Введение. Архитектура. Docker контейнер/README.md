### Задача 1

https://hub.docker.com/repository/docker/dracula33/my-nginx

---
### Задача 2

Мне кажется что использовать контейнеры в такой схеме можно, но не стоит. По крайней мере не под все компоненты.  
Смущает много обращений к диску. MongoDb, Elasticsearch, Gitlab и Docker Registry. Появляется лишнее звено отказоустойчивости в виде монтирования каталога внутрь контейнера.  
Также не понятно, как поведет себя система, если повредятся образы контейнеров, и потребуется сделать `docker pull` из Docker registry. Но его контейнер в это время тоже работать не будет.

Если допустить, что я просто не знаю, как на самом деле надежны Stateful контейнеры, то я бы все равно Gitlab и Docker Registry оставил на виртуалках, а не в контейнерах. 

---
### Задача 3

```commandline
vagrant@vagrant:~/data$ docker run -t --name=debian -v /home/vagrant/data:/data:rw -d debian
5c53e0c0ce36cf6ab8a838ae6bb629d116e90b7ce88bc0a598d4c415563110ac
vagrant@vagrant:~/data$ docker run -t --name=centos -v /home/vagrant/data:/data:rw -d centos
da6a253f950b0b2e41d18bcfea0621ba37b226b3046f872ddbf1e70371c4314a
vagrant@vagrant:~/data$ docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED          STATUS          PORTS     NAMES
da6a253f950b   centos    "/bin/bash"   2 seconds ago    Up 1 second               centos
5c53e0c0ce36   debian    "bash"        17 seconds ago   Up 16 seconds             debian
vagrant@vagrant:~/data$ docker exec -ti centos bash
[root@da6a253f950b /]# echo "from centos" > /data/centos.txt
[root@da6a253f950b /]# exit
vagrant@vagrant:~/data$ echo "from host" > host.txt
vagrant@vagrant:~/data$ docker exec -ti debian bash
root@5c53e0c0ce36:/# cd /data
root@5c53e0c0ce36:/data# ls
centos.txt  host.txt
root@5c53e0c0ce36:/data# cat *
from centos
from host
root@5c53e0c0ce36:/data#
```

---
### Задача 4

https://hub.docker.com/r/dracula33/my-ansible/tags

---
