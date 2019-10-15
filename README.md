[![Build Status](https://travis-ci.com/trydirect/django-oscar.svg?branch=master)](https://travis-ci.com/trydirect/django-oscar)
![Docker Stars](https://img.shields.io/docker/stars/trydirect/django-oscar.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/trydirect/django-oscar.svg)
![Docker Automated](https://img.shields.io/docker/cloud/automated/trydirect/django-oscar.svg)
![Docker Build](https://img.shields.io/docker/cloud/build/trydirect/django-oscar.svg)
[![Gitter chat](https://badges.gitter.im/trydirect/community.png)](https://gitter.im/try-direct/community)
	
	
# Django-Oscar template for developers
The goal of this project is to give possibility to setup Django-Oscar development environment as easy as it possible.
More development tools for debugging and monitoring will follow.


## Installation
Clone this project into your work directory:
```sh
$ git clone "https://github.com/trydirect/django-oscar.git"
$ cd django-oscar
```
Run stack with:
```sh
$ docker-compose up -d
```

## Setup sandbox
In order to create django oscar database structure and load demo data execute following command:
```
docker exec --user=oscar -it oscar /sandbox.sh
```

## Setup Sentry
```
COMPOSE_HTTP_TIMEOUT=300 docker-compose exec sentry bash -c "sentry upgrade"
```

## Quick deployment to cloud
##### Amazon AWS, Digital Ocean, Hetzner and others
[<img src="https://img.shields.io/badge/quick%20deploy-%40try.direct-brightgreen.svg">](https://try.direct/server/user/deploy/Im9zY2FyfDZ8Mjgi.EIJLoA.vgPr3uzpDjT2xLigcD4NEy0Cgsk/)



## Contributing

1. Fork it (https://github.com/trydirect/django-oscar/fork)
2. Create your feature branch (git checkout -b feature/fooBar)
3. Commit your changes (git commit -am 'Add some fooBar')
4. Push to the branch (git push origin feature/fooBar)
5. Create a new Pull Request



## Support Development

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=2BH8ED2AUU2RL)
