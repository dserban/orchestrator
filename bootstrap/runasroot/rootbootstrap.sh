apt -y install docker.io apt-transport-https curl
echo 'DOCKER_OPTS="--insecure-registry localhost:5000"' > /etc/default/docker
service docker restart
docker pull registry:2
docker run -d --name registry --restart=always    \
           -p 127.0.0.1:5000:5000     \
           -v /var/lib/registry:/var/lib/registry \
           registry:2

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
apt update -qq && apt -y install kubelet kubeadm kubectl
kubeadm config images pull
kubeadm init --pod-network-cidr=10.244.0.0/16
export KUBECONFIG=/etc/kubernetes/admin.conf
echo -e '\nexport KUBECONFIG=/etc/kubernetes/admin.conf' >> /root/.bashrc
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl get nodes
sleep 20
kubectl get nodes

apt -y install build-essential binutils gcc make sudo wget htop nethogs tmux
apt -y install postgresql postgresql-contrib libpq-dev postgresql-client postgresql-client-common
sudo -Hiu postgres psql -c "CREATE USER airflow PASSWORD 'airflow';"
sudo -Hiu postgres psql -c "CREATE DATABASE airflow;"
sudo -Hiu postgres psql -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO airflow;"
sudo -Hiu postgres psql -c "CREATE USER morphl PASSWORD 'morphl';"
sudo -Hiu postgres psql -c "CREATE DATABASE morphl;"
sudo -Hiu postgres psql -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO morphl;"
newusers /opt/orchestrator/bootstrap/runasroot/newusers.txt
usermod -aG sudo airflow
usermod -aG sudo morphl
echo "airflow ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "morphl ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "export AIRFLOW_HOME=/home/airflow/airflow" > /etc/profile.d/airflow.sh
echo "export PATH=/opt/anaconda/bin:\$PATH" >> /etc/profile.d/airflow.sh
mkdir /opt/anaconda /opt/tmp
chown airflow /opt/anaconda /opt/tmp
# sudo -Hiu airflow bash -c /opt/orchestrator/bootstrap/runasairflow/airflowbootstrap.sh
