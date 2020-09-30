# Journal of the Process

## Date: 9/29/2020

* Finished shell scripts for starting Kubernetes
    1. setup kubectl to be able to manage clusters from command line
    2. setup minikube to be able to start clusters for learning environment
    3. start a docker engine install.  This is used as the driver for the minikube
    4. Add users for the docker to know who is able to access
    5. Start minikube with docker as the selected driver

## Date: 9/30/2020

* Began Process to merge shell script into the master branch

* Created a copy of the original shell script without launching minikube so that it can be run from a different location
    * The first script will be used as the head, the second script will be used as the client to connect with the head.