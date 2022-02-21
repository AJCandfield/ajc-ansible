#!/usr/bin/env bash
set -euxo pipefail

# Make sure git and python is installed!!!

PATH_VENV="/tmp/venv"
TARGET_USER="alex"

sudo apt-get --yes install python3-pip
sudo apt-get --yes install python3-venv
sudo apt-get --yes install python3-wheel

sudo python3 -m pip install wheel
sudo python3 -m venv ${PATH_VENV}

source "${PATH_VENV}/bin/activate"

sudo "${PATH_VENV}/bin/pip" install wheel
sudo "${PATH_VENV}/bin/pip" install ansible

"${PATH_VENV}/bin/ansible-playbook" playbooks/ping.yml -vvv
"${PATH_VENV}/bin/ansible-playbook" playbooks/setup-workstation.yml -e "target_user=${TARGET_USER}" -vvv

sudo rm -rf $PATH_VENV

echo "Playbook run finished 👍‍"
