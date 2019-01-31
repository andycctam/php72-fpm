FROM phpdockerio/php72-fpm:latest

# Use Local Mirror hk.archive.ubuntu.com 
RUN sed -i -e "s/archive/hk\.archive/" /etc/apt/sources.list

# Copy wkhtmltopdf deb
ADD https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb /tmp/wkhtmltox_0.12.5-1.bionic_amd64.deb

# Install selected extensions and other stuff
RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update \
    && apt-get -y --no-install-recommends install  php7.2-mysql php7.2-intl php7.2-mbstring php7.2-sqlite3 \
	# For wkhtmltopdf
    && apt-get -y --no-install-recommends install  /tmp/wkhtmltox_0.12.5-1.bionic_amd64.deb \
	# PDF Chinese Font
    && apt-get -y --no-install-recommends install  fonts-wqy-zenhei \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# php-ini-overrides.ini
#ADD php-ini-overrides.ini /etc/php/7.2/fpm/conf.d/99-overrides.ini
