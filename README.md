# Serve a Symfony app with FrankenPHP on Clever Cloud

This is a simple demo of how to deploy a Symfony application served by [FrankenPHP](https://frankenphp.dev/) in a Docker container on Clever Cloud. You'll need a [Clever Cloud account](https://console.clever-cloud.com/) and [Clever Tools](https://github.com/CleverCloud/clever-tools).

## Setup Clever Tools

```bash
npm i -g clever-tools
clever login
```
## Create the local application

To create the Symfony application, you'll need [the CLI](https://symfony.com/download), then:

```bash
symfony new FrankenSymfony --demo 
cd FrankenSymfony
``` 

## Create and configure the Clever Cloud application

We set the port (`8080`) of FrankenPHP via `SERVER_NAME`:

```bash
clever create -t docker 
clever env set SERVER_NAME ":8080"
```

## Create the Dockerfile

We need to install the `intl` extension for the Symfony demo application:

```Bash
cat << 'EOF' > Dockerfile
FROM dunglas/frankenphp

COPY . /opt/app/

WORKDIR /opt/app/

# Install dependencies
RUN apt-get update && \
    apt-get install -y git zip && \
    install-php-extensions intl

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    php composer.phar install
EOF
```

You can also choose to download the Dockerfile from this repository:

```Bash
wget -q https://raw.githubusercontent.com/davlgd/frankenphp-symfony-demo/main/Dockerfile
```

## Git push!

```Bash
git add . && git commit -m "Initial commit"
clever deploy
clever open
```

After the deployment, you should see the Symfony application running on Clever Cloud.
