#Install Condor repo key
wget -qO - https://research.cs.wisc.edu/htcondor/ubuntu/HTCondor-Release.gpg.key | sudo apt-key add -

#Add repo
sudo echo "deb http://research.cs.wisc.edu/htcondor/ubuntu/8.8/xenial xenial contrib" >> /etc/apt/sources.list
sudo echo "deb-src http://research.cs.wisc.edu/htcondor/ubuntu/8.8/xenial xenial contrib" >> /etc/apt/sources.list

#Install Condor
sudo apt-get update
sudo apt-get install htcondor

#Set Firewall Rules
echo "CONDOR_HOST = condor-cm.example.com" | sudo tee -a /etc/condor/config.d/49-common
sudo firewall-cmd --zone=public --add-port=9618/tcp --permanent
sudo firewall-cmd --reload

#Add security config
sudo mkdir /etc/condor/passwords.d
sudo chmod 700 /etc/condor/passwords.d

touch /etc/condor/config.d/50-security

echo 
"SEC_PASSWORD_FILE = /etc/condor/passwords.d/POOL > /etc/condor/config.d/50-security
SEC_DAEMON_AUTHENTICATION = REQUIRED
SEC_DAEMON_INTEGRITY = REQUIRED
SEC_DAEMON_AUTHENTICATION_METHODS = PASSWORD
SEC_NEGOTIATOR_AUTHENTICATION = REQUIRED
SEC_NEGOTIATOR_INTEGRITY = REQUIRED
SEC_NEGOTIATOR_AUTHENTICATION_METHODS = PASSWORD
SEC_CLIENT_AUTHENTICATION_METHODS = FS, PASSWORD, KERBEROS, GSI
ALLOW_DAEMON = condor_pool@*/*, condor@*/$(IP_ADDRESS)
ALLOW_NEGOTIATOR = condor_pool@*/condor-cm.example.com" > etc/condor/config.d/50-security