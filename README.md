# 🚀  Management Aws

- [1) Qual Propósito do Projeto](#1-qual-propósito-do-projeto)
- [2) O que é necessário para rodar o projeto](#2-o-que-é-necessário-para-rodar-o-projeto)
  - [2.1) AWS cli](#21-aws-cli)
  - [2.2) Gerenciador de Versões de Ruby](#22-gerenciador-de-versões-de-ruby)
- [3) Running](#3-running)
  - [3.1) Help dos Parametros Suportados](#3.1-help-dos-parametros-suportados)
  - [3.2) Executando](#3.2-executando)  

## 1) Qual Propósito do Projeto

O objetivo do projeto é facilitar a vida do **Devops**, centralizando em uma única ferramenta informações de multiplas clouds. Os dados coletadas são obtidos através da própria **API** que a **Cloud Provider** disponibiliza, ou seja, a ferramenta apenas cuida de apresentar os dados e em forma de tabela.

Atualmente o projeto suporta apenas a **Cloud AWS**, mas o projeto foi preparado para suportar multiplas clouds.

## 2) O que é necessário para rodar o projeto
- AWS Cli
- Gerenciador de Ruby (Rbenv | Rvm | Asdf | Compilar Ruby Desejado ( Veja arquivo .ruby-version ))

#### 2.1) AWS cli

- AWS Cli 
Será necessário pois ele será responsável por consumir a API da AWS. Caso não tenha instalado em sua máquina, basta seguir esses passos listados [AQUI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

#### 2.2) Gerenciador de Versões de Ruby
- Gerenciador de Ruby
Aqui você tem a liberdade para usar o gerenciador que mais atende suas necessidades. Particularmente gosto e uso **rbenv**, mas isso não é relevante, o importante é ter o **Ruby** certo instalado na máquina.

```bash
▶rbenv versions  
  2.5.1
  2.6.6
  2.7.4
  2.7.5
  2.7.6
* 3.0.1 (set by /home/paulo/Documents/Projetos/sistemas/github-paulo/management-aws/.ruby-version)
```

#### Instalando Bundler

```bash
▶gem install bundler -v $(cat Gemfile.lock | grep "BUNDLED WITH" -A1 | tail -n1)
```

#### Instalando Gems

```bash
▶bundle install         
Fetching gem metadata from https://rubygems.org/.
Resolving dependencies...
Using bundler 2.3.14
Using json 2.6.2
Using text-table 1.2.4
Bundle complete! 2 Gemfile dependencies, 3 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```

## 3) Running

Agora que as libs estão instaladas vamos consumir o projeto.

#### 3.1) Help dos Parametros Suportados

Ao executar o script **cloud.rb** um Helper é mostrado de como usar o script. No exemplo abaixo será listado as **EC2** localizada na região de **São Paulo**.

```rb
▶ruby cloud.rb 
+--------------------+-----------------------------------------------------------------+
|      Serviço       |                             Comando                             |
+--------------------+-----------------------------------------------------------------+
| AWS EC2            | ruby cloud.rb --cloud=aws --region=sa-east-1 --resource=aws-ec2 |
| AWS Security Group | ruby cloud.rb --cloud=aws --region=sa-east-1 --resource=aws-sg  |
+--------------------+-----------------------------------------------------------------+
```

#### 3.2) Executando

Coletando dados da **EC2**

```rb
▶ruby cloud.rb --cloud=aws --region=sa-east-1 --resource=aws-ec2


Getting data AWS !!! Waiting....

+---------------------+------------------+------------------+---------------------------------+------------------------------+
|   InstanceId        | PrivateIpAddress | PublicIpAddress  |     SecurityGroupsId            |             Tags             |
+---------------------+------------------+------------------+---------------------------------+------------------------------+
| i-00000000000000001 | 10.100.0.100     | NOT IP PUBLIC    | sg-00000001, sg-00000002        |           Thumbor            |
| i-00000000000000002 | 10.100.99.99     | 200.200.200.200  | sg-00000099                     |           Bastion            |
+---------------------+------------------+------------------+---------------------------------+------------------------------+
```

Coletando dados da **Security Group**

```rb
▶ruby cloud.rb --cloud=aws --region=sa-east-1 --resource=aws-sg


Getting data AWS !!! Waiting....

+----------------------+--------------------+-----------+---------------+-----------+---------------------------+
|       GroupId        |    GroupName       | From Port |  Ip Origin    |  To Port  |        Description        |
+----------------------+--------------------+-----------+---------------+-----------+---------------------------+
| sg-00000000000000001 | ggr-apps-ruby      |    3000   | 10.100.0.0/16 |    3000   | Allow 3000 Local Network  |
| ____________________ | ___________________|___________|_______________|___________|___________________________|
| sg-00000000000000002 | ggr-postgres-dev   |    5432   | 10.100.0.0/16 |    5432   | Allow 5432 Local Network  |
+----------------------+--------------------+-----------+---------------+-----------+---------------------------+


```