#!/usr/bin/env bash
set -euxo pipefail

PATH_VENV="/tmp/venv"

# sudo apt-get update
# sudo apt-get --yes --force-yes install git python3
sudo python3 -m venv ${PATH_VENV}

source "${PATH_VENV}/bin/activate"

sudo "${PATH_VENV}/bin/pip" install ansible

"${PATH_VENV}/bin/ansible-playbook" playbooks/ping.yml
"${PATH_VENV}/bin/ansible-playbook" playbooks/setup-workstation.yml -vv

# sudo rm -rf $PATH_VENV

echo "Playbook run finished 👍‍"
