# tutor-openedx

Tutor is a Docker-based distribution of Open edX, designed to simplify the deployment and management of Open edX platforms. Each Tutor version corresponds to a specific Open edX release. Here's a list of Tutor versions and their associated Open edX releases:
```
Tutor Version 10.x.x: Corresponds to Open edX Juniper release.
Tutor Version 11.x.x: Corresponds to Open edX Koa release.
Tutor Version 12.x.x: Corresponds to Open edX Lilac release.
Tutor Version 13.x.x: Corresponds to Open edX Maple release.
Tutor Version 14.x.x: Corresponds to Open edX Nutmeg release.
Tutor Version 15.x.x: Corresponds to Open edX Olive release.
Tutor Version 16.x.x: Corresponds to Open edX Palm release.
Tutor Version 17.x.x: Corresponds to Open edX Quince release.
Tutor Version 18.x.x: Corresponds to Open edX Redwood release.
```
To install a specific version of Tutor that matches a particular Open edX release, you can use the following pip commands:

# Install using bash
```
pip install 'tutor[full]>=10.0.0,<11.0.0'  # For Juniper
pip install 'tutor[full]>=11.0.0,<12.0.0'  # For Koa
pip install 'tutor[full]>=12.0.0,<13.0.0'  # For Lilac
pip install 'tutor[full]>=13.0.0,<14.0.0'  # For Maple
pip install 'tutor[full]>=14.0.0,<15.0.0'  # For Nutmeg
pip install 'tutor[full]>=15.0.0,<16.0.0'  # For Olive
pip install 'tutor[full]>=16.0.0,<17.0.0'  # For Palm
pip install 'tutor[full]>=17.0.0,<18.0.0'  # For Quince
pip install 'tutor[full]>=18.0.0,<19.0.0'  # For Redwood
```
For example, to install Tutor version 11.x.x (which corresponds to Open edX Koa), you would run:

```
pip install 'tutor[full]>=11.0.0,<12.0.0'
```

# Tutor Open edX useful commands

### Tutor Installation

#### Requirements
-   [Docker](https://docs.docker.com/engine/install/ubuntu/): v24.0.5+ (with BuildKit 0.11+)
-   [Docker Compose](https://docs.docker.com/compose/install/): v2.0.0+
- Ports 80 and 443 should be open
- Hardware:
  -   Minimum configuration: 4 GB RAM, 2 CPU, 8 GB disk space
  -   Recommended configuration: 8 GB RAM, 4 CPU, 25 GB disk space
- Other requirements:
  ```
  sudo apt install python3 python3-pip libyaml-dev
  ```
#### Docker and Docker compose installation
```
sudo apt-get update
sudo apt-get install -y     apt-transport-https     ca-certificates     curl     gnupg-agent     software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo gpasswd -a $USER docker
sudo usermod -a -G docker $USER
sudo -H -u root bash << EOF
# test Docker installation
docker run hello-world
EOF
```

#### Installation
There are 2 ways to install Tutor:
1. Install with pip:
    ```
    pip install "tutor[full]"
    ```
    Or download the pre-compiled binary and place the `tutor` executable in your path:
    ```
    sudo curl -L "https://github.com/overhangio/tutor/releases/download/v19.0.0/tutor-$(uname -s)_$(uname -m)" -o /usr/local/bin/tutor
    sudo chmod 0755 /usr/local/bin/tutor
    ```
2. Run `tutor local quickstart`
    - Answer a few questions
3. And Open edX is installed!

### Useful Commands
- #### List down all available commands under tutor
    ```
    tutor local help
    ```
- #### Stop, Start, Restart
    ```
    tutor local stop
    tutor local start -d
    tutor local restart
    tutor local restart lms
    ```
- #### Check logs
    ```
    # Change lms with the service name for which you want to check logs
    tutor local logs lms -f --tail 100
    ```
- #### Tracking logs directory
    ```
    (tutor config printroot)/data/lms/logs/tracking.log
    (tutor config printroot)/data/cms/logs/tracking.log
    ```
- #### Check all container status
    ```
    tutor local status
    ```
- #### Create a user with staff and admin access
    ```
    tutor local createuser --staff --superuser -pedx edx edx@example.com
    ```
- #### Import the demo course
    ```
    tutor local do importdemocourse
    ```

- #### Enable xqueue and forum plugins
    ```
    tutor local stop
    tutor plugins enable xqueue
    tutor plugins enable forum
    tutor local start -d
    ```

- #### Enable xblock-poll  plugin
    ```  
    tutor local stop
    tutor config save --append OPENEDX_EXTRA_PIP_REQUIREMENTS=git+https://github.com/open-craft/xblock-poll.git
    tutor config save --append OPENEDX_EXTRA_PIP_REQUIREMENTS=git+https://github.com/open-craft/problem-builder.git
    tutor config save --append OPENEDX_EXTRA_PIP_REQUIREMENTS=git+https://github.com/openedx/xblock-image-explorer.git
    tutor images build openedx
    tutor local start -d
    ```    

- ####  User creation
    ```  
    tutor local do createuser --staff --superuser prasaths prasath.sivasubramaniyan@trigyn.com
    tutor local do createuser --staff --superuser sivac sivachidambaram.dhanushkodi@trigyn.com
    tutor local do createuser --staff --superuser balak balasaheb.karjule@trigyn.com
    tutor local do createuser --staff --superuser kirang kiran.gavali@trigyn.com
    ```  
- ####  clean up the docker containers and images, run the following command:
    ```
    tutor local dc down --remove-orphans
    sudo rm -rf "$(tutor config printroot)"
    ```  

    
- #### Set theme
    ```
    # For first time only
    git clone https://github.com/jramnai/mytheme.git
    cp -r /home/ubuntu/mytheme "$(tutor config printroot)/env/build/openedx/themes/"
    tutor local settheme mytheme

    # If there is some change in `mytheme`
    cd mytheme
    git pull origin main
    rm -rf "$(tutor config printroot)/env/build/openedx/themes/mytheme"
    cp -r /home/ubuntu/mytheme "$(tutor config printroot)/env/build/openedx/themes/"
    tutor local settheme mytheme
    ```
- #### Running management commands, find some useful management commands [here](https://gist.github.com/jramnai/94e8aa05763df53795c8349dc76b431b#managepy-commands)
    ```
    tutor local run cms ./manage.py cms reindex_course --all --setup --settings tutor.production
    tutor local run lms ./manage.py lms compile_sass --settings tutor.production
    ```
- #### Reloading Open edX settings
    ```
    tutor local exec lms reload-uwsgi
    ```
- #### Open service/container shell
    ```
    # replace lms with your service/container name
    tutor local exec lms bash
    tutor local exec mysql bash
    ```
- #### Installing extra requirement
    ```
    # For first time only
    cd $(tutor config printroot)/env/build/openedx/requirements/
    git clone https://github.com/dicdiksha/my_package.git
    echo "-e ./my_package" >> "$(tutor config printroot)/env/build/openedx/requirements/private.txt"
    tutor images build openedx --build-arg EDX_PLATFORM_REPOSITORY=https://github.com/openedx/edx-platform.git --build-arg EDX_PLATFORM_VERSION=open-release/maple.master
    tutor local stop
    tutor local start -d

    # If there is some change in `my_package`
    cd $(tutor config printroot)/env/build/openedx/requirements/my_package
    git pull origin main
    tutor images build openedx --build-arg EDX_PLATFORM_REPOSITORY=https://github.com/openedx/edx-platform.git --build-arg EDX_PLATFORM_VERSION=open-release/maple.master
    tutor local stop
    tutor local start -d
    ```
    or simple
    ```
    echo "git+https://github.com/open-craft/xblock-pdf@b4e404b1f94ffab15c52de5c1382d61235cd8c81#egg=xblock-pdf==1.1.0" >> "$(tutor config printroot)/env/build/openedx/requirements/private.txt"
    tutor images build openedx --build-arg EDX_PLATFORM_REPOSITORY=https://github.com/openedx/edx-platform.git --build-arg EDX_PLATFORM_VERSION=open-release/maple.master
    tutor local stop
    tutor local start -d
    ```
- #### View `config.yml` file content
    ```
    cat "$(tutor config printroot)/config.yml"
    ```
- #### Set parameter in `config.yml` file
    ```
    tutor config save --set PARAM1=VALUE1 --set PARAM2=VALUE2
    ```
- #### Print config value
    ```
    tutor config printvalue OPENEDX_COMMON_VERSION
    ```
- #### Create tutor image build
    ```
    tutor images build openedx --build-arg EDX_PLATFORM_REPOSITORY=https://github.com/openedx/edx-platform.git --build-arg EDX_PLATFORM_VERSION=open-release/maple.master
    or
    tutor images build openedx --no-cache --build-arg EDX_PLATFORM_REPOSITORY=https://github.com/openedx/edx-platform.git --build-arg EDX_PLATFORM_VERSION=open-release/maple.master
    ```
- #### Install and enable plugin
    ```
    pip install tutor-myapp
    tutor plugins enable myapp
    tutor local quickstart
    ```
- #### List installed plugins
    ```
    tutor plugins list
    ```
- #### Enable/disable a plugin
    ```
    tutor plugins enable myplugin
    tutor plugins disable myplugin
    tutor config save
    ```
- #### Print location of plugin root
    ```
    tutor plugins printroot
    ```
- #### Using Gmail as an SMTP server
  - Check connectivity
    ```
    telnet smtp.gmail.com 587
    ```
  - Disable Tutor SMTP server
       ```
    tutor config save --set RUN_SMTP=false
      ```
  - Configure SMTP credentials
      ```
    tutor config save \
      --set SMTP_HOST=smtp.gmail.com \
      --set SMTP_PORT=587 \
      --set SMTP_USE_SSL=false  \
      --set SMTP_USE_TLS=true \
      --set SMTP_USERNAME=YOURUSERNAME@gmail.com \
      --set SMTP_PASSWORD='YOURPASSWORD'
    ```
  - Restart your platform
    ```
    tutor local quickstart
    ```
  - Test it
    ```
    tutor local run --no-deps lms ./manage.py lms shell -c \
      "from django.core.mail import send_mail; send_mail('test subject', 'test message', 'YOURUSERNAME@gmail.com', ['YOURRECIPIENT@domain.com'])"
    ```
- #### Creating MYSQL DB Backup
    ```
    tutor local exec \
        -e USERNAME="$(tutor config printvalue MYSQL_ROOT_USERNAME)" \
        -e PASSWORD="$(tutor config printvalue MYSQL_ROOT_PASSWORD)" \
        mysql sh -c 'mysqldump --all-databases --user=$USERNAME --password=$PASSWORD > /var/lib/mysql/dump.sql'
    ```
    The `dump.sql`  files will be located in `$(tutor  config  printroot)/data/mysql`
  
- #### CreatingMONGO DB dumps
    ``` 
    tutor local exec mongodb mongodump --out=/data/db/dump.mongodb
    ```
    The `dump.mongodb` files will be located in  `$(tutor  config  printroot)/data/mongodb`.

- #### Changing Open edX settings (or Creating a Tutor plugin)
    - Create plugins root folder
      ```
      mkdir -p "$(tutor plugins printroot)"
      ```
    - Create an empty “myplugin.py” file in this folder
      ```
      touch "$(tutor plugins printroot)/myplugin.py"
      ```
    - Verify plugin is correctly detected
      ```
      tutor plugins list
      ```
    - Add content in  myplugin.py file (the setting which you want to set/modify)
      ```
      from tutor import hooks

      hooks.Filters.ENV_PATCHES.add_item(
          (
              "openedx-common-settings",
              """
      X_FRAME_OPTIONS = "ALLOWALL"
      """
          )
      )
      ```
    - Enable the myplugin
      ```
      tutor plugins enable myplugin
      ```
    - Re-render your environment
      ```
      tutor config save
      ```
    - Restart the platform
      ```
      tutor local restart
      ```

- #### Run Open edX behind the Nginx

  - Setup nginx in ubuntu

    ```  
    sudo apt-get install nginx -y
    ```
  - To set up Open edX with Tutor behind a web proxy and enable HTTPS, follow these steps:

   - Disable the default web proxy: Run the following command to disable the default Caddy web proxy and change its port:

        ```
        tutor config save --set ENABLE_WEB_PROXY=false --set CADDY_HTTP_PORT=81
        ```
    - Create a new folder `ssl` in the path `/etc/nginx/` and add the ssl content in `cert.pem`  `private.key`
  
        ```
        sudo mkdir /etc/nginx/ssl
        cd /etc/nginx/ssl
        sudo touch cert.pem private.key
        ```

        ```
        cd /etc/nginx/site-available
        sudo vi ncertx
        ```

    - Configure your external web proxy: Set up your external web proxy (e.g., Nginx) to forward traffic to the Caddy container. Here is an example configuration for Nginx:
      
        ```
        server {
            listen 80;
            server_name  learning.ncert.gov.in studio.learning.ncert.gov.in  apps.learning.ncert.gov.in;
            client_max_body_size 900M;


            location / {
                proxy_pass http://127.0.0.1:81;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
            }
        }

        server {
            listen 443 ssl;
            server_name  learning.ncert.gov.in studio.learning.ncert.gov.in  apps.learning.ncert.gov.in;
            client_max_body_size 900M;
            ssl_certificate /etc/nginx/ssl/cert.pem;
            ssl_certificate_key /etc/nginx/ssl/private.key;

            location / {
                proxy_pass http://127.0.0.1:81;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
            }
        }

        ```
    - To enable your ncertx site configuration in Nginx, you need to create a symbolic link from the sites-available directory to the sites-enabled directory. Here are the steps:


        ```
        sudo ln -s /etc/nginx/sites-available/ncertx /etc/nginx/sites-enabled/
        ```
    - Test the Nginx configuration: Ensure there are no syntax errors in your configuration files:    
        ```
        sudo nginx -t
        ```
    - Reload Nginx: Apply the changes by reloading Nginx:    
        ```
        sudo systemctl reload nginx
        ```
    - Enable HTTPS in Tutor: Ensure that HTTPS is enabled in Tutor by setting the `ENABLE_HTTPS` flag to `true`:
    
        ```
        cd /home/ncertx_prod_user/.local/share/tutor/env/
        tutor config save --set ENABLE_HTTPS=true
        ```
    - Restart Tutor: Apply the new configuration by restarting Tutor
        ```  
        tutor local restart
        ```

### References
- https://github.com/overhangio/tutor/releases
- https://docs.tutor.overhang.io/
- https://docs.tutor.edly.io/tutorials/proxy.html
- https://discuss.openedx.org/t/how-to-reverse-proxy-to-open-edx-sites-deployed-with-tutor-from-another-server/8324/3
- https://discuss.overhang.io/t/running-tutor-behind-web-proxy-not-working/1572/2
