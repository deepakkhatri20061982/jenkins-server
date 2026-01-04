## A Volume is created called as "mlruns" which will be shared across projects.

## To run the Docker Image, following is the command - 

* docker build -t jenkins-server .
* docker run -d --name jenkins-server -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v "<localPathToBeReplaced>:/workspace" -v mlruns2:/mlruns2 jenkins-server
