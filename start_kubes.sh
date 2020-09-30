echo "Setup kubectl"

curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version --client

echo "Setup minikube"
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube
sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/

echo "Starting Docker Engine install"
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

echo "Add users"
sudo usermod -aG docker ne886541
sudo usermod -aG docker lngo

echo "Starting kubernetes"
minikube start --set-driver=docker