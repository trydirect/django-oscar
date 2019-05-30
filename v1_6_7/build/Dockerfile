FROM python:3.6

MAINTAINER Optimum "info@optimum-web.com"

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

WORKDIR /app
RUN git clone -b stable --single-branch https://github.com/taigaio/taiga-back.git .

COPY wsgi.ini /app/sandbox/wsgi.ini
COPY oscar.conf /etc/supervisor/conf.d/oscar.conf
COPY settings.py /app/sandbox/settings.py
RUN pip install -r requirements.txt && pip install uwsgi

EXPOSE 8000
