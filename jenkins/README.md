# Setting up Jenkins and Pipeline

## Set up Jenkins with Docker
```bash 
docker run -u root -d --name jenkins -p 8080:8080  -p 50000:50000  -v jenkins-data:/var/jenkins_home  -v /var/run/docker.sock:/var/run/docker.sock  jenkinsci/blueocean
```
## Follow Prompts
Follow the next prompts to setup your login. To get the admin password you can execute the following:

```bash 
docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

## Create The Pipeline
Click "New Item" > "Pipeline" and name it whatever you want.

See Images Below and/or [config.xml](https://github.com/geekbass/sample-message-board/blob/master/jenkins/config.xml) for settings for Job.

* Pipeline Name: Your Choice
* Description: Your Choice
* Github project: https://github.com/geekbass/sample-message-board/
* Pipeline: Pipeline script from SCM
* SCM: Git
* Repository URL: https://github.com/geekbass/sample-message-board.git
* Branches to build: */master
* Script Path: Jenkinsfile

Click "Save".

## Top of Job Config
![Top Job Config](https://github.com/geekbass/sample-message-board/blob/master/images/config-top.jpg "Top Job Config")

## Bottom of Job Config
![Bottom Job Config](https://github.com/geekbass/sample-message-board/blob/master/images/config-bottom.jpg "Bottom Job Config")


