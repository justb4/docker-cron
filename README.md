# docker-cron

Dockerfile and scripts for creating image with `cron`-based on Alpine  
Installed packages: `dcron docker docker-compose` and `ca-certificates`.

Allows to execute commands in other Docker images. 

Inspired from: https://github.com/xordiv/docker-alpine-cron - mainly added Docker tools.

#### Environment variables:

`CRON_STRINGS` - strings with cron jobs. Use "\n" for newline (Default: undefined)   
`CRON_TAIL` - if defined cron log file will read to *stdout* by *tail* (Default: undefined) 
  
By default cron daeomon runs in foreground  

#### Cron files

- /etc/cron.d - place to mount custom crontab files  

When image will run, files in `/etc/cron.d` will be copied to `/var/spool/cron/crontab`.   
If `CRON_STRINGS` is defined the entry script creates the file */var/spool/cron/crontab/CRON_STRINGS*  

#### Log files

By default placed in `/var/log/cron/cron.log` 

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
See [example in test dir](test/docker-compose.yml).
