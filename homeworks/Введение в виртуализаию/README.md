
### Задача 1

Основное отличие - способ доступа к аппаратным ресурсам хоста. 
Доступ может быть напрямую, через хостовую OS, через саму операионную систему.

---
### Задача 2
> Высоконагруженная база данных, чувствительная к отказу.

Для БД стоит использовать несколько физических серверов

Обычно базы большие и не помещаются в оперативную память. Высоконагруженая БД будет часто обращаться к дискам, и лучше, чтобы она делала это через меньшее число звеньев.

БД легко можно загрузить каким-то тяжелым запросом или служебной операцией (перестройкой индекса или сбором статистики), лучше ей отдать целиком весь сервер, а не делить его при помощи виртуализации с кем-то еще.

> Различные web-приложения.

Думаю, что достаточно использовать виртуализацию уровня OS

Веб приложения не требуют много ресурсов и это скорее процесс, которому достаточно изолированно запуститься на текущей операционной системе сервера.

> Windows системы для использования бухгалтерским отделом.

Тут подойдет паравиртуализация (Hyper-V).

Бухгалтер - сотрудник, который не создает большую нагрузку на железо. Открывает таблички, редактирует документы и умеет работать только на персональной машине.

Точно стоит разделить один железный сервер на несколько одинаковых виртуальных машин.

> Системы, выполняющие высокопроизводительные расчеты на GPU.

Виртуализация уровня OS, либо физический сервер

Залез в настройки VirtualBox. Виртулаке можно выделить только объем памяти, но не количество ядер видеокарты. Как я понимаю, вычисления проводятся именно на ядрах.
Если возможности разделить вычислительные ресурсы нет, то и смысла в виртуалках нет. Процессы можно запустить либо изолированно на текущей OS, либо прямо на серверной OS. У кого из проессов будет сложнее задача, тот возьмет больше ресурсов GPU 
___

### Задача 3

> 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий. 

Hyper-V

Преобладание Windows в инфраструктуре, поддерживает запуск линуксовых машин, есть репликация данных

> Требуется наиболее производительное бесплатное open source решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.

KVM

Наиболее производительное Open Source решение

> Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows инфраструктуры.

Xen PV

Подошел бы Hyper-V, но он не бесплатен. В лекции говорилось, что Xen PV и Windows более совместимы (из-за этого не KVM), и виртуальные машины на основе шаблонов Xen PV имеют высокую производительность

> Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.

KVM

Является нативным для Linux. Поддерживается большинством ядер Linux 
___

### Задача 4

Проблемы и недостатки:  
- нужны сотрудники, умеющие работать с разными гипервизорами
- нужно поддерживать сами гипервизоры, лицензии, обновления
- нужно поддерживать сами сервера, на одном сервере не может быть несколько гипервизоров. Серверов больше
- если учесть, что должно быть резервирование, то для каждого сервера со своим гипервизором должен быть резервный. Их тоже нужно обслуживать

Я бы предположил, что для уменьшения рисков выше, нужно использовать "похожие" гипервизоры.  
К примеру, вместо Hyper-V и KVM использовать хотя бы Xen и KVM,а лучше Xen PV и Xen HVM.  
Еще лучше использовать облачного провайдера, чтобы все проблемы по обслуживанию были скрыты в облаке

Если бы у меня был выбор по созданию гетерогенной среды, то создавать её не хотелось бы.  
К сожалению, нет опыта работы с гипервизоварами. 
Если бы потребовалось создать 80/20 виртуалок на Windows для работы сотрудников и Linux для серверной части, то напрашивается использование Hyper-V. Но для серверной части не поднимается рука использовать виндовый гипервизор. 
Почему-то кажется, что линуксовый будет работать в этом случае лучше. Но стоит ли и его использовать для создания большого количества машин под Windows?

Наверное, в такой ситуации либо пришлось бы использовать гетерогенную среду. Либо только Hyper-V для сотрудников Windows, а серверную часть на Linux поставил бы прямо на хост.
