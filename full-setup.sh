#!/usr/bin/env bash
set -euo pipefail

# TODO: Implement check that git and python are installed

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

"${PATH_VENV}/bin/ansible-playbook" playbooks/full_setup.yml -e "target_user=${TARGET_USER}" -vvv

sudo rm -rf $PATH_VENV

echo "Playbook run finished 👍‍"
