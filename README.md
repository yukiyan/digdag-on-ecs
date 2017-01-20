# digdag-on-ecs

## Start scheduler

```
$ docker-compose up -d --build --force-recreate
```

## Check schedule

```
$ docker-compose exec digdag java -jar /usr/local/bin/digdag schedules
```

## Reference
* [What’s Digdag? — Digdag 0.8 documentation](http://docs.digdag.io/)
