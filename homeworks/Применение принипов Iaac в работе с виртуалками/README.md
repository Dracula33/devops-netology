
### Задача 1

1. Основные преимущества в использовании CI/CD - скорость вывода изменений в прод.  
Все могут быстро получить аналогичную проду среду для реализации/исправления/тестирования функионала.  
Готовые изменения могут быстро быть выкачены и проверены на тестовых средах.  
Проверенные изменения могут быстро включиться в работу или откатиться.
2. Основополагающий принип - идемпотентность. Способность получить тоже самое при повторном выполнении.
---

### Задача 2

1. Ansible использует стандартное, имеющееся на каждом *nix сервере SSH соединение. Не нужно ничего дополнительного настраивать, сразу можно разворачиваться
2. На мой взгляд push надежнее. Разработчик сам решает, когда можно выкатывать конфигураию. Кажется, что при pull может возникнуть ситуация, когда сервер подтянет изменения до того, как они будут одобрены для установки. Даже если изменения будут одобрены, хост может применить изменения в неподходящее время из-за того, что были проблемы с доступом или чем-то еще, и он выкачал их поздно.  
При push сразу можно нажать кнопку и понять, кто применил, кто не применил.

---

### Задача 3
```
igor@IgorSoldatov:/mnt/c/Users/dracu$ VBoxManage --version
5.2.44r139111
igor@IgorSoldatov:/mnt/c/Users/dracu$ vagrant --version
Vagrant 2.0.2
igor@IgorSoldatov:/mnt/c/Users/dracu$ ansible --version
ansible 2.5.1
...
```
---

### Задача 4

```
root@server1:~# docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

Получилось на WSL Ubuntu 18.04 с бубном, подпиливанием Vagrantfile, предварительного создания ссылки на Python и ручного запуска provision

```commandline
igor@IgorSoldatov:/mnt/c/Users/dracu/Documents/devops16_vagr_wsl/vagrant$ export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
igor@IgorSoldatov:/mnt/c/Users/dracu/Documents/devops16_vagr_wsl/vagrant$ vagrant up
/usr/lib/ruby/vendor_ruby/rbnacl/libsodium/version.rb:5: warning: Insecure world writable dir /mnt/c in PATH, mode 040777
Bringing machine 'server1.netology' up with 'virtualbox' provider...
==> server1.netology: Importing base box 'bento/ubuntu-20.04'...
==> server1.netology: Matching MAC address for NAT networking...
==> server1.netology: Checking if box 'bento/ubuntu-20.04' is up to date...
==> server1.netology: There was a problem while downloading the metadata for your box
==> server1.netology: to check for updates. This is not an error, since it is usually due
==> server1.netology: to temporary network problems. This is just a warning. The problem
==> server1.netology: encountered was:
==> server1.netology:
==> server1.netology: The requested URL returned error: 404 Not Found
==> server1.netology:
==> server1.netology: If you want to check for box updates, verify your network connection
==> server1.netology: is valid and try again.
==> server1.netology: Setting the name of the VM: server1.netology
==> server1.netology: Clearing any previously set network interfaces...
==> server1.netology: Preparing network interfaces based on configuration...
    server1.netology: Adapter 1: nat
    server1.netology: Adapter 2: hostonly
==> server1.netology: Forwarding ports...
    server1.netology: 22 (guest) => 20011 (host) (adapter 1)
    server1.netology: 22 (guest) => 2222 (host) (adapter 1)
==> server1.netology: Running 'pre-boot' VM customizations...
==> server1.netology: Booting VM...
==> server1.netology: Waiting for machine to boot. This may take a few minutes...
    server1.netology: SSH address: 127.0.0.1:2222
    server1.netology: SSH username: vagrant
    server1.netology: SSH auth method: password
    server1.netology:
    server1.netology: Inserting generated public key within guest...
    server1.netology: Removing insecure key from the guest if it's present...
    server1.netology: Key inserted! Disconnecting and reconnecting using new SSH key...
==> server1.netology: Machine booted and ready!
==> server1.netology: Checking for guest additions in VM...
    server1.netology: The guest additions on this VM do not match the installed version of
    server1.netology: VirtualBox! In most cases this is fine, but in rare cases it can
    server1.netology: prevent things such as shared folders from working properly. If you see
    server1.netology: shared folder errors, please make sure the guest additions within the
    server1.netology: virtual machine match the version of VirtualBox you have installed on
    server1.netology: your host and reload your VM.
    server1.netology:
    server1.netology: Guest Additions Version: 6.1.30
    server1.netology: VirtualBox Version: 5.2
==> server1.netology: Setting hostname...
==> server1.netology: Configuring and enabling network interfaces...
#<Thread:0x00007fffcfecf2a8@/usr/share/rubygems-integration/all/gems/vagrant-2.0.2/lib/vagrant/batch_action.rb:71 run> terminated with exception (report_on_exception is true):
Traceback (most recent call last):
        117: from /usr/share/rubygems-integration/all/gems/vagrant-2.0.2/lib/vagrant/batch_action.rb:82:in `block (2 levels) in run'
        116: from /usr/share/rubygems-integration/all/gems/vagrant-2.0.2/lib/vagrant/machine.rb:188:in `action'
        ...
        
igor@IgorSoldatov:/mnt/c/Users/dracu/Documents/devops16_vagr_wsl/vagrant$ vagrant ssh
/usr/lib/ruby/vendor_ruby/rbnacl/libsodium/version.rb:5: warning: Insecure world writable dir /mnt/c in PATH, mode 040777
vagrant@127.0.0.1's password:
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-91-generic x86_64)
...
Last login: Sun Apr 17 19:00:59 2022 from 10.0.2.2
vagrant@server1:~$ sudo -i
root@server1:~# ln -s /usr/bin/python3 /usr/bin/python
root@server1:~# logout
vagrant@server1:~$ logout
Connection to 127.0.0.1 closed.

igor@IgorSoldatov:/mnt/c/Users/dracu/Documents/devops16_vagr_wsl/vagrant$ vagrant provision
/usr/lib/ruby/vendor_ruby/rbnacl/libsodium/version.rb:5: warning: Insecure world writable dir /mnt/c in PATH, mode 040777
==> server1.netology: Running provisioner: ansible...
Vagrant has automatically selected the compatibility mode '2.0'
according to the Ansible version installed (2.5.1).

Alternatively, the compatibility mode can be specified in your Vagrantfile:
https://www.vagrantup.com/docs/provisioning/ansible_common.html#compatibility_mode

    server1.netology: Running ansible-playbook...
 [WARNING] Ansible is in a world writable directory (/mnt/c/Users/dracu/Documents/devops16_vagr_wsl/vagrant), ignoring it as an ansible.cfg source.

PLAY [nodes] *******************************************************************

TASK [Gathering Facts] *********************************************************
 [WARNING]: Module invocation had junk after the JSON data:
AttributeError("module 'platform' has no attribute 'dist'")

ok: [server1.netology]

TASK [Create directory for ssh-keys] *******************************************
ok: [server1.netology]

TASK [Adding rsa-key in /root/.ssh/authorized_keys] ****************************
changed: [server1.netology]

TASK [Checking DNS] ************************************************************
changed: [server1.netology]

TASK [Installing tools] ********************************************************
ok: [server1.netology] => (item=[u'git', u'curl'])

TASK [Installing docker] *******************************************************
 [WARNING]: Consider using the get_url or uri module rather than running curl.
If you need to use command because get_url or uri is insufficient you can add
warn=False to this command task or set command_warnings=False in ansible.cfg to
get rid of this message.

changed: [server1.netology]

TASK [Add the current user to docker group] ************************************
fatal: [server1.netology]: FAILED! => {"changed": false, "module_stderr": "Shared connection to 127.0.0.1 closed.\r\n", "module_stdout": "Traceback (most recent call last):\r\n  File \"/tmp/ansible_6wmfz5kc/ansible_modlib.zip/ansible/module_utils/basic.py\", line 274, in get_distribution\r\nAttributeError: module 'platform' has no attribute '_supported_dists'\r\n\r\nDuring handling of the above exception, another exception occurred:\r\n\r\nTraceback (most recent call last):\r\n  File \"/tmp/ansible_6wmfz5kc/ansible_module_user.py\", line 2300, in <module>\r\n    main()\r\n  File \"/tmp/ansible_6wmfz5kc/ansible_module_user.py\", line 2205, in main\r\n    user = User(module)\r\n  File \"/tmp/ansible_6wmfz5kc/ansible_module_user.py\", line 264, in __new__\r\n    return load_platform_subclass(User, args, kwargs)\r\n  File \"/tmp/ansible_6wmfz5kc/ansible_modlib.zip/ansible/module_utils/basic.py\", line 332, in load_platform_subclass\r\n  File \"/tmp/ansible_6wmfz5kc/ansible_modlib.zip/ansible/module_utils/basic.py\", line 284, in get_distribution\r\nAttributeError: module 'platform' has no attribute 'dist'\r\n", "msg": "MODULE FAILURE", "rc": 1}
        to retry, use: --limit @/mnt/c/Users/dracu/Documents/devops16_vagr_wsl/ansible/provision.retry

PLAY RECAP *********************************************************************
server1.netology           : ok=6    changed=3    unreachable=0    failed=1

Ansible failed to complete successfully. Any error output should be
visible above. Please fix these errors and try again.



igor@IgorSoldatov:/mnt/c/Users/dracu/Documents/devops16_vagr_wsl/vagrant$ ssh vagrant@127.0.0.1 -p 20011
vagrant@127.0.0.1's password:
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-91-generic x86_64)
...
Last login: Sun Apr 17 19:06:07 2022 from 10.0.2.2
vagrant@server1:~$ docker ps
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/json": dial unix /var/run/docker.sock: connect: permission denied
vagrant@server1:~$ sudo -i
root@server1:~# docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
root@server1:~#
```
---