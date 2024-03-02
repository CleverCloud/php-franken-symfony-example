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
