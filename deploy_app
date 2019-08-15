#!/bin/bash
#By Francisco Neto <netoralves@gmail.com>
#========================== MICROSERVICE - CONFIG SERVER =======================================
#CONFIG-SERVER
app_name="config-server"
#===============================================================================================

# VARS
git_branches="hmlg"
workspace="/tmp"

#=============================================================================================

#1. CLONE/PULL DO REPO GIT
if [ -d "$workspace/$app_name" ]; then
	cd $workspace/$app_name && git fetch && git checkout $git_branches && git pull
else
	git clone --single-branch -b $git_branches https://github.com/netoralves/config-server.git
fi

#2. SOURCE COMPILE
#MAVEN
cd $workspace/$app_name; mvn clean install

#3.LOGIN ON YOUR MINISHIFT OR OPENSHIFT MASTER
oc login -u system:admin

#3. CREATE THE BUILD
oc new-build --binary --name=$app_name -l app=$app_name

#4. START THE BUILD WITH WORKDIR APP
oc start-build $app_name --from-dir="." --follow

#5. START THE CONTAINER
oc new-app $app_name -l app=$app_name

#6. CREATE THE SVC TO POD ACCESS
oc create service clusterip $app_name --tcp=8080:8080

#7.EXPOSE THE SVC TO EXTERNAL ACCESS
oc expose svc $app_name
