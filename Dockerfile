FROM stefanorg/centos-php56

# -----------------------------------------------------------------------------
# php mysql which git intl
# -----------------------------------------------------------------------------
RUN yum -y install php56w-mysql php56w-intl which git

# -----------------------------------------------------------------------------
# Composer
# -----------------------------------------------------------------------------
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin

# -----------------------------------------------------------------------------
# Create the skeleton directory
# -----------------------------------------------------------------------------
RUN rm -rf /var/www/app
RUN composer.phar create-project --stability="dev" --prefer-dist  zendframework/skeleton-application /var/www/app

# -----------------------------------------------------------------------------
# Set permissions (app:app-www === 501:502)
# -----------------------------------------------------------------------------
RUN chown -R 501:502 /var/www/app \
	&& chmod 775 /var/www/app

# -----------------------------------------------------------------------------
# Create the initial directory structure
# -----------------------------------------------------------------------------
RUN mkdir -p /var/www/app/var/{log,session,tmp}

# -----------------------------------------------------------------------------
# Populate the app home directory
# -----------------------------------------------------------------------------
ADD var/www/app/vhost.conf /var/www/app/vhost.conf

RUN rm -rf /var/www/.app-skel
RUN cp -rpf /var/www/app /var/www/.app-skel

ADD etc/apache-bootstrap /etc/
ADD etc/services-config/httpd/apache-bootstrap.conf /etc/services-config/httpd/
ADD etc/services-config/supervisor/supervisord.conf /etc/services-config/supervisor/


CMD ["/usr/bin/supervisord", "--configuration=/etc/supervisord.conf"]
