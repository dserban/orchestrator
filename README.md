Deployment Orchestrator

On a clean Ubuntu 16.04 machine, bootstrap the installation by running the following commands as root:
```
apt update -qq && apt -y install git ca-certificates
git clone https://github.com/dserban/orchestrator /opt/orchestrator
bash /opt/orchestrator/bootstrap/runasroot/rootbootstrap.sh

```
