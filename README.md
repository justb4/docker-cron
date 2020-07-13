![Docker Build](https://github.com/justb4/docker-cron/workflows/CI/badge.svg)
![GitHub release](https://img.shields.io/github/release/justb4/docker-cron.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/justb4/cron.svg)

# docker-cron

Dockerfile and scripts for creating image to use `cron`. Based on Alpine Linux. 
Installed packages: `dcron docker docker-compose` and `ca-certificates`.

Allows to execute commands in other Docker images. 

Inspired from: https://github.com/xordiv/docker-alpine-cron - mainly added Docker tools.

It installs and uses "Dillon's Cron" `dcron`, via APK: http://www.jimpryor.net/linux/dcron.html

#### Environment variables:

- `CRON_STRINGS` - strings with cron jobs. Use "\n" for newline (Default: undefined)   
- `CRON_TAIL` - if defined cron log file will read to *stdout* by *tail* (Default: undefined) 
- `CRON_DEBUG_LEVEL` - set cron daemon loglevel: `emerg|alert|crit|err|warning|notice|info|debug` (Default: `notice`) 

By default cron daemon runs in the foreground unless `CRON_TAIL` is set.  

#### Cron files

- /etc/cron.d - place to mount custom crontab files  

When the image is run, files in `/etc/cron.d` will be copied to `/var/spool/cron/crontab`.   
If `CRON_STRINGS` is defined the [entry script](scripts/docker-entry.sh) 
creates the file `/var/spool/cron/crontab/CRON_STRINGS`.  

#### Log files

By default placed in `/var/log/cron.log` 

#### Simple usage:

```
docker run --name="cron-sample" -d \
-v /path/to/app/conf/crontabs:/etc/cron.d \       
-v /path/to/app/scripts:/scripts \
justb4/cron
```

#### With scripts and CRON_STRINGS
```
docker run --name="cron-sample" -d \
-e 'CRON_STRINGS=* * * * * /scripts/myapp-script.sh'
-v /path/to/app/scripts:/scripts \
justb4/cron
```

#### Print date to file every minute
```
docker run --name="cron-sample" -d \
-e 'CRON_STRINGS=* * * * * echo "date=$(date) > /tmp/dates.txt'
justb4/cron
```

#### Docker Compose
See [complete example in test dir](test/docker-compose.yml).
This is the preferred way of running. Also shows how to use Docker client
commands.
