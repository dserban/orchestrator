apt -y install docker.io build-essential binutils gcc make sudo curl wget htop nethogs tmux
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
sudo -Hiu airflow bash -c /opt/orchestrator/bootstrap/runasairflow/airflowbootstrap.sh
