#!/usr/bin/env sh

dockerRegistry='docker.aboydfd.com'
imageName=gradle-java-template
cd $(dirname $([ -L $0 ] && readlink -f $0 || echo $0))


set -x
set -e
docker login ${dockerRegistry} -u ${docker_user} -p ${docker_password}
docker build -t "$dockerRegistry/$imageName" .
docker push "$dockerRegistry/$imageName"
set +x
cd -
