# spark-condor

## Condor

https://htcondor.readthedocs.io/en/v8_9_7/admin-manual/introduction-admin-manual.html


## CloudLab



## Docker/Kubernetes

https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/adding-windows-nodes/  
https://github.com/kubernetes-retired/kubeadm-dind-cluster

https://www.thegeekdiary.com/how-to-access-kubernetes-dashboard-externally/
https://stackoverflow.com/questions/39864385/how-to-access-expose-kubernetes-dashboard-service-outside-of-a-cluster


[local kubernetes](https://minikube.sigs.k8s.io/docs/start/)
## Spark


# Getting Started With Condor

## [Setup](https://htcondor.readthedocs.io/en/v8_9_7/admin-manual/quick-start-condor-pool.html)

### Repository

echo "CONDOR_HOST = submitty.cs.wcupa.edu" | sudo tee -a /etc/condor/config.d/49-common

echo "use Role: Execute" | sudo tee -a /etc/condor/config.d/51-role-exec

sudo mkdir /etc/condor/passwords.d

sudo chmod 700 /etc/condor/passwords.d

nano -c /etc/condor/config.d/50-security

sudo nano -c /etc/condor/config.d/50-security

sudo condor_store_cred add -c

**Password is goldenrams**

### Enable and Start Condor

sudo systemctl enable condor

sudo systemctl start condor

### Check to see if condor is running

condor_q

condor_status

## [Submitting a Job](https://research.cs.wisc.edu/htcondor/tutorials/fermi-2005/submit_first.html)

### Standard Job
To demonstrate how to submit a job, I have created a [c file](test/simple.c) as well as a [Condor Submit File](test/submit)

The c file has the goal of taking in 2 parameters and sleeping for the length of the first, followed by an integer that is multiplied by 2 then returned.

To run this code in condor use the command % **condor_submit submit**

### Parameter Sweep

In order to run a file multiple times with different inputs, we can do a [parameter sweep](test/parameter_sweep_submit).

A parameter sweep looks similar to the standard submit, except we make sure to include the process in the name of the output files as to not overwrite each other.  We also will include a couple more arguments to be passed and queued as jobs.

To submit this code to condor we will use the command % **condor_submit parameter_sweep_submit** which will use the file parameter_sweep_submit for the information

Note how when this job is submitted 3 jobs will be sent to the cluster for Condor to handle and send out to different execution nodes.

### Output Files

After submitting a job any output files that were defined in the submit file will become present.
In my example, there are 3 outputs that can be looked at.

**Log** is used to show a log of what happend during the process.  This is important for debugging programs as different information can be stored at different points to make sure the files are manipulated properly.

**Output** is simple the standard output file that has what was returned from the program execution

**Error** if an error is to occur the StackTrace can be found here for helpful debugging.

The easiest way to look at any of these files is to use the **cat** command.  For example, to get the output of the program I would run % **cat simple.out**
