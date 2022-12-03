FROM php:8.0-cli-alpine

MAINTAINER Romano Schoonheim <romano@romanoschoonheim.nl>

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

# Create user and group & switch context
# to run this container as non-root.
#
RUN addgroup -g 1000 -S qualityContainer && \
    adduser -u 1000 -S qualityContainer -G qualityContainer
USER qualityContainer
WORKDIR /home/qualityContainer

# Adding the composer bin directory to the PATH
#
ENV PATH="/home/qualityContainer/.composer/vendor/bin:${PATH}"

# PHP Analysis Tools
#
RUN composer global require phpmd/phpmd

# PHP Testing Tools
#
RUN composer global require phpunit/phpunit
RUN composer global require johnkary/phpunit-speedtrap

# Laravel tools
#
# Code styling: Laravel pint - docs: https://laravel.com/docs/9.x/pint
RUN composer global require laravel/pint

# Larastan - repository: https://github.com/nunomaduro/larastan
RUN composer global require nunomaduro/larastan



