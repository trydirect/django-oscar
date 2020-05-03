FROM python:3.7
LABEL maintainer="info@optimum-web.com"

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update  && apt-get autoremove -y && apt-get --no-install-recommends -y install locales \
    python-dev \
    supervisor \
    curl \
    gcc \
    libffi-dev \
    uwsgi-src \
    uuid-dev \
    libcap-dev \
    libpq5 \
    git \
    procps \
    libpq-dev \
    uwsgi-src \
    uwsgi \
    && apt-get clean && rm -rf /var/lib/apt/lists/*; \
    groupadd -r -g 2000 flask; useradd -r -u 2000 -g 2000 -m -c "app account" -d /home/flask -s /bin/bash flask

RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales
COPY locale.gen /etc/locale.gen
COPY default.locale /etc/default/locale
RUN locale -a

RUN mkdir /app
RUN chown oscar:oscar /app

USER oscar
ENV APP_VERSION 1.6.7
WORKDIR /app
RUN git clone https://github.com/django-oscar/django-oscar.git .
RUN git checkout tags/${APP_VERSION} -b "${APP_VERSION}"

USER root
RUN pip3 install django-oscar==${APP_VERSION} raven==5.32.0 psycopg2-binary uwsgi supervisor \
    && pip3 install -r requirements.txt

COPY wsgi.ini /app/sandbox/wsgi.ini
COPY oscar.conf /etc/supervisor/conf.d/oscar.conf
COPY settings.py /app/sandbox/settings.py

EXPOSE 8000