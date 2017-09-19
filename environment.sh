__pre_create_jenkins(){
  folder="/storage/jenkinsData"
  mkdir -p $folder
  chmod 777 $folder
}

__create_jenkins(){
  docker run -d --name devopsday_jenkins \
    -p 8080:8080 \
    -p 50000:50000 \
    --user root \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /storage/jenkinsData:/var/jenkins_home \
    -v /usr/bin/docker:/usr/bin/docker \
    jenkins
}

__pos_create_jenkins(){
  docker exec -it -u 0 devopsday_jenkins bash -c " \
    apt-get update && \
    apt-get install libltdl7"
}

__pre_create_jenkins
__create_jenkins
__pos_create_jenkins
