### Задача 1

1. Файлы для создания контейнера  

Dockerfile
```
FROM elasticsearch:7.17.4

COPY elasticsearch.yml /usr/share/elasticsearch/config/

RUN mkdir /var/lib/{data,logs} && \
    chown -R elasticsearch:root /var/lib/* && \
    mkdir /usr/share/elasticsearch/snapshots && \
    chown elasticsearch:root /usr/share/elasticsearch/snapshots
```

elasticsearch.yml
```yaml
---
cluster.name: "docker-cluster"
network.host: 0.0.0.0

path:
  repo: "/usr/share/elasticsearch/snapshots"
  data: "/var/lib/data"
#  work: "/var/lib/work"
  logs: "/var/lib/logs"

node.name: "netology_test"
...
```
2. Ссылка на докерхаб  

https://hub.docker.com/r/dracula33/elasticsearch/tags

3. Ответ на запрос http://127.0.0.1:9200/
```json
{
  "name" : "netology_test",
  "cluster_name" : "docker-cluster",
  "cluster_uuid" : "rkYTVbjKQb2mtYujvmlS7w",
  "version" : {
    "number" : "7.17.4",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "79878662c54c886ae89206c685d9f1051a9d6411",
    "build_date" : "2022-05-18T18:04:20.964345128Z",
    "build_snapshot" : false,
    "lucene_version" : "8.11.1",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```

---
### Задача 2

1. Информация об индексах

`vagrant@vagrant:~/elasticsearch-hw$ curl -s http://127.0.0.1:9200/ind* | jq`

```json
{
  "ind-1": {
    "aliases": {},
    "mappings": {},
    "settings": {
      "index": {
        "routing": {
          "allocation": {
            "include": {
              "_tier_preference": "data_content"
            }
          }
        },
        "number_of_shards": "1",
        "provided_name": "ind-1",
        "creation_date": "1654197152596",
        "number_of_replicas": "0",
        "uuid": "NoVKHukUTRunw-HuQ96nnQ",
        "version": {
          "created": "7170499"
        }
      }
    }
  },
  "ind-2": {
    "aliases": {},
    "mappings": {},
    "settings": {
      "index": {
        "routing": {
          "allocation": {
            "include": {
              "_tier_preference": "data_content"
            }
          }
        },
        "number_of_shards": "2",
        "provided_name": "ind-2",
        "creation_date": "1654196705648",
        "number_of_replicas": "1",
        "uuid": "RRZ044ZDRwq-eINwEYKYaA",
        "version": {
          "created": "7170499"
        }
      }
    }
  },
  "ind-3": {
    "aliases": {},
    "mappings": {},
    "settings": {
      "index": {
        "routing": {
          "allocation": {
            "include": {
              "_tier_preference": "data_content"
            }
          }
        },
        "number_of_shards": "4",
        "provided_name": "ind-3",
        "creation_date": "1654196734387",
        "number_of_replicas": "2",
        "uuid": "yIJkRDbeTpiYIVrl8jFe0Q",
        "version": {
          "created": "7170499"
        }
      }
    }
  }
}
```
2. Состояние кластера

`vagrant@vagrant:~/elasticsearch-hw$ curl -s http://127.0.0.1:9200/_cluster/health | jq`

```json
{
  "cluster_name": "docker-cluster",
  "status": "yellow",
  "timed_out": false,
  "number_of_nodes": 1,
  "number_of_data_nodes": 1,
  "active_primary_shards": 10,
  "active_shards": 10,
  "relocating_shards": 0,
  "initializing_shards": 0,
  "unassigned_shards": 10,
  "delayed_unassigned_shards": 0,
  "number_of_pending_tasks": 0,
  "number_of_in_flight_fetch": 0,
  "task_max_waiting_in_queue_millis": 0,
  "active_shards_percent_as_number": 50
}
```
Состояние индексов и шардов
```commandline
vagrant@vagrant:~/elasticsearch-hw$ curl -s http://127.0.0.1:9200/_cat/indices
green  open .geoip_databases C9Q17weqSjqrsUVXX8eBqA 1 0 40 0 38.1mb 38.1mb
green  open ind-1            NoVKHukUTRunw-HuQ96nnQ 1 0  0 0   226b   226b
yellow open ind-3            yIJkRDbeTpiYIVrl8jFe0Q 4 2  0 0   904b   904b
yellow open ind-2            RRZ044ZDRwq-eINwEYKYaA 2 1  0 0   452b   452b
        
vagrant@vagrant:~/elasticsearch-hw$ curl -s http://127.0.0.1:9200/_cat/shards
ind-2                                                         1 p STARTED     0   226b 172.18.0.2 netology_test
ind-2                                                         1 r UNASSIGNED
ind-2                                                         0 p STARTED     0   226b 172.18.0.2 netology_test
ind-2                                                         0 r UNASSIGNED
.ds-ilm-history-5-2022.06.02-000001                           0 p STARTED              172.18.0.2 netology_test
.ds-.logs-deprecation.elasticsearch-default-2022.06.02-000001 0 p STARTED              172.18.0.2 netology_test
ind-1                                                         0 p STARTED     0   226b 172.18.0.2 netology_test
.geoip_databases                                              0 p STARTED    40 38.1mb 172.18.0.2 netology_test
ind-3                                                         1 p STARTED     0   226b 172.18.0.2 netology_test
ind-3                                                         1 r UNASSIGNED
ind-3                                                         1 r UNASSIGNED
ind-3                                                         2 p STARTED     0   226b 172.18.0.2 netology_test
ind-3                                                         2 r UNASSIGNED
ind-3                                                         2 r UNASSIGNED
ind-3                                                         3 p STARTED     0   226b 172.18.0.2 netology_test
ind-3                                                         3 r UNASSIGNED
ind-3                                                         3 r UNASSIGNED
ind-3                                                         0 p STARTED     0   226b 172.18.0.2 netology_test
ind-3                                                         0 r UNASSIGNED
ind-3                                                         0 r UNASSIGNED

```
Кластер yellow, потому что есть yellow индексы.  
А индексы yellow, потому что все реплики в статусе UNASSIGNED

3. Удаление индексов

```commandline
vagrant@vagrant:~/elasticsearch-hw$ curl -s -X DELETE http://127.0.0.1:9200/ind*
{"acknowledged":true}
```
---
### Задача 3

* Регистрация репозитория

```commandline
vagrant@vagrant:~/elasticsearch-hw$ curl -X PUT "localhost:9200/_snapshot/netology_backup" -H 'Content-Type: application/json' -d'
> {
>   "type": "fs",
>   "settings": {
>     "location": "/usr/share/elasticsearch/snapshots"
>   }
> }
> '
{"acknowledged":true}
```

* Список индексов

```commandline
vagrant@vagrant:~/elasticsearch-hw$ curl -s http://127.0.0.1:9200/_cat/indices
green open .geoip_databases pPaQjZFqTrKS3ivTOKzpqg 1 0 40 0 38.1mb 38.1mb
green open test             0vPf_uETRDqBNM0_uHcr1A 1 0  0 0   226b   226b
```

* Создание snapshot

```commandline
vagrant@vagrant:~/elasticsearch-hw$ curl -X PUT -s http://127.0.0.1:9200/_snapshot/netology_backup/test_2206022255
{"accepted":true}
```

* Список файлов в каталоге со Snapshot

```commandline
root@4ca66abcf1d9:/usr/share/elasticsearch# ls -la snapshots/*
-rw-rw-r-- 1 elasticsearch root  1427 Jun  2 19:55 snapshots/index-0
-rw-rw-r-- 1 elasticsearch root     8 Jun  2 19:55 snapshots/index.latest
-rw-rw-r-- 1 elasticsearch root 29277 Jun  2 19:55 snapshots/meta-LJxb6NrqRuakWsRdWEUQZw.dat
-rw-rw-r-- 1 elasticsearch root   714 Jun  2 19:55 snapshots/snap-LJxb6NrqRuakWsRdWEUQZw.dat

snapshots/indices:
total 24
drwxrwxr-x 6 elasticsearch root 4096 Jun  2 19:55 .
drwxrwxr-x 3 elasticsearch root 4096 Jun  2 19:55 ..
drwxrwxr-x 3 elasticsearch root 4096 Jun  2 19:55 2lbobS8HS9-Ai0R08JwCnw
drwxrwxr-x 3 elasticsearch root 4096 Jun  2 19:55 LImrNeTPQ8ym1g92FD-6Kw
drwxrwxr-x 3 elasticsearch root 4096 Jun  2 19:55 WWDwwIPGRf2pzm1FVp8SNg
drwxrwxr-x 3 elasticsearch root 4096 Jun  2 19:55 qm1YdDH5QkWp2wO1fqY1tg
```

* Пересоздание индекса на test-2

```commandline
vagrant@vagrant:~/elasticsearch-hw$ curl -s -X DELETE http://127.0.0.1:9200/test
{"acknowledged":true}
        
vagrant@vagrant:~/elasticsearch-hw$ curl -X PUT "localhost:9200/test-2" -H 'Content-Type: application/json' -d'
> {
>   "settings": {
>     "index": {
>       "number_of_shards": 1,
>       "number_of_replicas": 0
>     }
>   }
> }
> '
{"acknowledged":true,"shards_acknowledged":true,"index":"test-2"}
        
vagrant@vagrant:~/elasticsearch-hw$ curl -s http://127.0.0.1:9200/_cat/indices
green open test-2           cX5XxGDFS9693CnnONk-gQ 1 0  0 0   226b   226b
green open .geoip_databases pPaQjZFqTrKS3ivTOKzpqg 1 0 40 0 38.1mb 38.1mb
```

* Восстановление индекса test

```commandline
vagrant@vagrant:~/elasticsearch-hw$ curl -X POST -s http://127.0.0.1:9200/_snapshot/netology_backup/test_2206022255/_restore -H 'Content-Type: application/json' -d'
> {
>  "indices": "test"
> }
'
{"accepted":true}
```

* Список индексов после восстановления

```commandline
vagrant@vagrant:~/elasticsearch-hw$ curl -s http://127.0.0.1:9200/_cat/indices
green open test-2           cX5XxGDFS9693CnnONk-gQ 1 0  0 0   226b   226b
green open .geoip_databases pPaQjZFqTrKS3ivTOKzpqg 1 0 40 0 38.1mb 38.1mb
green open test             4K8OTpB5SOWQUG46FPsXLw 1 0  0 0   226b   226b
```

---