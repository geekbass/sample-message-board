# README

## Ruby version
```bash 
ruby 2.5.0p0 (2017-12-25 revision 61468) [x86_64-linux]
```

## System dependencies 
Docker (Latest Release Preferred)

## Database creation
A Postrges DB is used with a persistent volume on the host. The actual DB(s) are created via Rails when you first deploy the rails app after issuing:
```bash
docker exec -it rails bundle exec rails db:create
```

## Database initialization
Once the DB(s) are created run the following to migrate the DB
```bash 
docker exec -it rails bundle exec rails db:migrate
```

## INITIAL Deployment instructions (From the Docker Host)
Pull Repo and Build the Rails Image
```bash
git clone https://github.com/geekbass/sample-message-board.git
docker build -t bold-ruby .
```

Start the DB 
```bash 
docker run -d -v ${PWD}/db/data:/var/lib/postgresql/data --env-file .db-env --name postgres -p 5432:5432 postgres
```    
Include the POSTRGRES_PASSWORD=$PASSWORD in the .db-env file 

Start Rails App (It will not work right away)
```bash
docker run -d --rm  --link postgres --name rails -p 5000:5000  bold-ruby bundle exec rails s -p 5000 -b '0.0.0.0'
```
NOTE: Using the '--rm' argument... This will start the rails app and then remove the container when stopped. This allows for the new one to replace it with the name rails. Postgres backends the data for us.

* If production env, create and use the --env-file .env or it will create test and dev by defaults in database.yml 
    Sample .env:
    ```bash
    SECRET_KEY_BASE=TonOfRandmomKeys>30CharsLong
    RAILS_ENV=production
    DATABASE_URL=postgres://postgres:$PGSQL_PASSWD_ABOVE@postgres:5432/$DESIRED_DB
    ```
```bash
docker run -it --env-file .env --link postgres --name rails -p 5000:5000  bold-ruby bundle exec rails s -p 5000 -b '0.0.0.0'
```

Once Rails is running, Create the DB(s) and migrate them:
```bash
docker exec -it rails bundle exec rails db:create
docker exec -it rails bundle exec rails db:migrate
```

Done. You may use! Hit $HOST_IP:5000/messages

## New Releases
Whenever there is a new code release, a new Docker Image will need to be created in order to replace the current running container. Use the Jenkinsfile as a Jenkins Pipeline to complete the following steps:

* Pull down Repo
* Build new rails image from new code
* Stop and remove existing rails container 
* Starts new container with latest code release

NOTE: This will currently only work if you have already completed the initial deployment steps above and both a rails app and the postgres db. 

## Troubleshooting and Some Notes
### Rails
If the rails app stops, has issues, or needs restarted. You can stop it using:
```bash
docker stop|start rails 
```
This will stop and remove the current container. To restart the app and continue where it left, rerun the docker run used above base on Envirionment:
```bash
docker run -it {--env-file .env} --link postgres --name rails -p 5000:5000  bold-ruby-dburl bundle exec rails s -p 5000 -b '0.0.0.0'
```

### Postgres
If the PGSQL needs restarted, just issue:
'''bash
docker stop|start postgres 
```
If you need to start a completely new instance or upgrade Postgres, just migrate the underlying attached volume to a new one or just remov the current running container and run a new with same '-v' argument. 
```bash
 -v ${PWD}/db/data:/var/lib/postgresql/data
```

The postgres container was setup to NOT remove the underlying volume if container was deleted so just remount the data. To start a new container with all existing data:
```bash
docker stop postgres 
docker rm postgres # <---- this removes the existing DB container
docker run -d -v ${PWD}/db/data:/var/lib/postgresql/data --env-file .env --name postgres -p 5432:5432 postgres
```
