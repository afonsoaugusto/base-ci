# base-ci

[![CircleCI](https://circleci.com/gh/afonsoaugusto/base-ci?style=svg)](https://circleci.com/gh/afonsoaugusto/base-ci)

[![CircleCI](https://circleci.com/gh/afonsoaugusto/base-ci/tree/master.svg?style=svg)](https://circleci.com/gh/afonsoaugusto/base-ci/tree/master)

Image base to execute pipelines

## Itens in this image

* TERRAFORM 0.12.24
* GCLOUD 266.0.0
* Ansible
* AWS CLI
* Python3
* Ruby

```sh
> $ docker run --rm -it base-ci bash
[ci@055f78b59d47 /]$ ansible --version
ansible 2.9.7
  config file = None
  configured module search path = ['/home/ci/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.6/site-packages/ansible
  executable location = /usr/local/bin/ansible
  python version = 3.6.8 (default, Apr  2 2020, 13:34:55) [GCC 4.8.5 20150623 (Red Hat 4.8.5-39)]

[ci@055f78b59d47 /]$ terraform version
Terraform v0.12.24

[ci@055f78b59d47 /]$ aws --version

aws-cli/2.0.12 Python/3.7.3 Linux/5.0.0-38-generic botocore/2.0.0dev16
[ci@055f78b59d47 /]$ gcloud version
Google Cloud SDK 266.0.0
bq 2.0.48
core 2019.10.04
gsutil 4.44
[ci@055f78b59d47 /]$
```
