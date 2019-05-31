FROM python:3.6

LABEL maintainer="info@optimum-web.com"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update  && apt-get autoremove -y && apt-get --no-install-recommends -y install locales supervisor curl \
 gcc libpq5 git lsof procps net-tools libpq-dev uwsgi uwsgi-src uuid-dev libcap-dev

RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales
COPY locale.gen /etc/locale.gen
COPY default.locale /etc/default/locale
RUN locale -a

# compile uwsgi plugin for python3.6
RUN PYTHON=python3.6 uwsgi --build-plugin "/usr/src/uwsgi/plugins/python python36"
RUN mv python36_plugin.so /usr/lib/uwsgi/plugins/python36_plugin.so

RUN groupadd -r -g 2000 oscar; useradd -r -u 2000 -g 2000 -m -c "app account" -d /home/oscar -s /bin/bash oscar;

RUN mkdir /app
RUN chown oscar:oscar /app

USER oscar
WORKDIR /app
RUN git clone https://github.com/django-oscar/django-oscar.git .
RUN git checkout tags/1.6.7 -b "1.6.7"

USER root
RUN pip3 install django-oscar==1.6.7 raven==5.32.0 psycopg2-binary uwsgi supervisor && pip3 install -r requirements.txt

COPY wsgi.ini /app/sandbox/wsgi.ini
COPY oscar.conf /etc/supervisor/conf.d/oscar.conf
COPY settings.py /app/sandbox/settings.py

EXPOSE 8000
