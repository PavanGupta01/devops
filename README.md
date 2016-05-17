# edmarket

edMarket is an app where educators and learners can collaboratively build, sell, buy and rate learning content.

#############################################
#############################################
## Django Nomenclature and code organization

1. edmarket is the project name

2. Most folders within edmarket are app folders

3a. The settings folder is edmarket/ and contaings the global settings files settings.py

3b. The local config files for dev, qa, prod are in config/ 

4. The CSS files are in edmarket/static/css/

5. All the backbone + handlebar files are in edmarket/static/js/

6. The rest of the code is backend + some server side templating

7. Various celery tasks are in app_name/tasks.py

8. The API url routing are in app_name/urls_api.py and the view routes are in app_name/urls.py

9. Server side templates are in app_name/templates/app_name/ folder

10. Custom template filters and tags are in app_name/templatetags


################### Mac OSX ##########################
#############################################
## Software you will need on Mac OSX

1. http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.23-osx10.9-x86_64.dmg
2. http://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-utilities-1.5.3-osx10.9.dmg
3. https://sequel-pro.googlecode.com/files/sequel-pro-1.0.2.dmg
5. https://www.python.org/ftp/python/3.4.0/python-3.4.0-macosx10.6.dmg - Installation of Python 3.4.3
6. Brew: http://brew.sh/

Once you have brew up and running, run the following:

7. brew update
8. brew install rabbitmq (See https://www.rabbitmq.com/install-homebrew.html)
9. brew install redis (See http://www.richardsumilang.com/blog/2014/04/04/how-to-install-redis-on-os-x/)
10. brew install elasticsearch __(Make sure it is elasticsearch 1.4.4 or above)__
11. brew install swig (See http://brewformulas.org/Swig)
12. Update your XCode and run "xcode-select --install" to install the command line utilities.
13. gem install sass
14. brew install libtiff libjpeg webp little-cms2

PyCharm as an editor is highly recommended. Get one from https://www.jetbrains.com/pycharm/download/

################### Ubuntu/Debian ##########################
## Steps To Configure On Ubuntu/Debian

   1. Install Python3-dev dependencies

      `sudo apt-get install python3-dev libxml2-dev libxslt1-dev`

   2. Install Mysql

      `sudo apt-get install mysql-server-5.6`

   3. Install RabbitMQ(https://www.rabbitmq.com/install-debian.html)

      `wget -O- https://www.rabbitmq.com/rabbitmq-signing-key-public.asc | sudo apt-key add -`

      `sudo apt-get update`

      `sudo apt-get install rabbitmq-server`

   4. Install Redis Server

      `sudo apt-get install redis-server`

   5. Install elasticsearch 1.4.4 or above

      `add-apt-repository -y ppa:webupd8team/java`

      `apt-get update`

      `apt-get install oracle-java8-installer`
    
      `wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -`

      `echo "deb http://packages.elastic.co/elasticsearch/1.7/debian stable main" | sudo tee -a` 

      `/etc/apt/sources.list.d/elasticsearch-1.7.list`

      `apt-get update`
      
      `apt-get install elasticsearch`
      
#############################################
#############################################
## Overall steps to get development server up and running. See below for details on some of these

1. git clone this repo
2. run command to install virtual environment
  ```
  pip install virtualenv
  ```
3. Setup your python virtualenv by running "pyvenv-3.4 /path/to/virtualenv"
4. Get into the virtualenv by running "source /path/to/virtualenv/bin/activate"
5. Do a "pip install -r requirements.txt" to install all the requirements
6. run "mkdir config"
7. run "touch config/\_\_init\_\_.py"
8. get the config file from VaultModo - to approach OPS team to acquire security access
  ```
  /vaultmodo/dev-spotlight/home/root/edmarket/config/local_config.py
  /vaultmodo/dev-spotlight/home/root/edmarket/config/__init__.py
  ```
9. run "chmod 755 config/*.py"
10. run commands to setup log
  ```
  sudo mkdir /var/log/edmarket
  sudo chown [[YOU_USER_ID]] /var/log/edmarket/
  touch /var/log/edmarket/target_url.log
  ```
11. modify local_config.py to setup proper static ROOT path
  ```
  STATIC_ROOT= 'static/'
  ```

  create corresponding static folder and ensure owner is the one running server
  ```
  mkdir static
  ```

Once all the requirements are setup __make sure you have rabbitmq, redis and elasticsearch servers are running__.

#### Starting dependent servers
```
# RabbitMQ
sh /usr/local/sbin/rabbitmq-server

# Redis
redis-server

# elastic search
elasticsearch
```

#### Starting Web Server
Run webserver 
  ```
  python manage.py runserver 0.0.0.0:8001
  ```

Navigate to your browser at http://127.0.0.1:8001

#### Background Jobs
Run celery background workers
```
# Worker 1
celery -A edmarket worker

#Worker 2
celery -A edmarket beat
```

#### Reindexing elastic search
```
# To check if elastic search is runnin
nc -vz localhost 9200
```

Install the following chrome extension
https://chrome.google.com/webstore/detail/sense-beta/lhjgkmllcaadmopgmanpapmpjgmfcfig/related?hl=en

Once elasticsearch is running install Chrome extension for ES
and run the following to create the index 
```
# Step 1: create the dummy index in ElasticSearch
PUT /edmarket_dev_0 to make a starter index

# Step 2: Make an alias and point to the dummy
POST /_aliases
{
    "actions": [
       {
          "add": {
             "index": "edmarket_dev_0",
             "alias": "edmarket_dev"
          }
       }
    ]
}
```

# To reindex
```
python search/index.py --write_settings
```


If requirements.txt throws a swig error follow instructions at
http://stackoverflow.com/questions/33005354/trouble-installing-m2crypto-with-pip-on-el-capitan
LDFLAGS="-L$(brew --prefix openssl)/lib" CFLAGS="-I$(brew --prefix openssl)/include"

LDFLAGS="-L$(brew --prefix openssl)/lib" \
CFLAGS="-I$(brew --prefix openssl)/include" \
SWIG_FEATURES="-cpperraswarn -includeall -I$(brew --prefix openssl)/include"
export CC=gcc

#############################################
#############################################
## Development database

1. Make a local DB called edmarket with UTF-8 encoding
2. Unzip edmarket_2015-07-11.sql.zip and import the DB


#############################################
#############################################
## Updating local_config.py on QA and PROD. PhPStorm makes it convenient 

1. svn checkout https://svn.clubmodo.com/confman-ubuntu/trunk/
2. Open trunk in PhPStorm
3. Cmd-Shift-O is the shortcut to open a file. Enter local_config for example. 
4. After the file is updated right-click on trunk -> Subversion -> Commit Directory


## Deploying setup

Buildbot
```
http://buildbot-master.clubmodo.com/spotlight/waterfall
```

Make sure you have the catapult submodule:
```
git submodule init
git submodule update
```

Make sure you have docker setup via these sets of instructions
https://edmodo.atlassian.net/wiki/display/DOCKER/Getting+Started+with+Docker

Pre-requisities:
  - docker version 1.8.0

#### Using Buildbot
Use the functions available here
```
http://buildbot-master.clubmodo.com/spotlight/waterfall
```

Ask Gary or the rest of the team for the ID and Password

#### For QA environment
```
docker build -t registry.edmodo.io/spotlight-qa
docker push registry.edmodo.io/spotlight-qa
python ./catapult/deploy.py -i ~/.ssh/deployer_dsa -f docker/app/Deployfile -e qa --setup
```

#### For Production environment
```
docker build -t registry.edmodo.io/spotlight-prod
docker push registry.edmodo.io/spotlight-prod
python ./catapult/deploy.py -i ~/.ssh/deployer_dsa -f docker/app/Deployfile -e production --setup
```

## Running Unit Test Cases
```
make spotlight-test
```

## Clearing caches
Useful when we are adding items to the sub-filters. TODO: We should refactor this moving forward and stop harding stuff. Example:
```
# FILE: buy/handlers/common_handler.py

Line: 330 - from django.core.cache import cache
Line: 335 - cache_key = '_new_browse_filters_'
Line: 336 - browse_dict = cache.get(cache_key)
```

Go into shell mode
```
python manage.py shell
```

In the Django shell run the following
```
from django.core.cache import cache
cache.clear()
```

## Re-generating Full Compound SiteMap
Proceed into shell in the environment and then run the following commands

```
import product.sitemap as sm
sm.CompoundSiteMapEntry.get_compound_list_from_cache(True)
```
