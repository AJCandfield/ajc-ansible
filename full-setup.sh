#!/usr/bin/env bash
set -o errexit  # Exit on error
set -o pipefail # Error if a command in pipeline returns non-zero code
set -o nounset  # Error when an unset variable is evaluated

source ./scripts/log.sh # https://github.com/Zordrak/bashlog

# TODO: Implement check that git and python are installed

PATH_VENV="/tmp/venv"
log debug "Python venv will be created at: ${PATH_VENV}"

TARGET_USER=$1
log debug "Target User: ${TARGET_USER}"

sudo apt-get --yes install \
    python3-pip \
    python3-venv \
    python3-wheel

sudo python3 -m venv ${PATH_VENV}
log debug "Venv created."

source "${PATH_VENV}/bin/activate"

sudo "${PATH_VENV}/bin/pip" install wheel
sudo "${PATH_VENV}/bin/pip" install ansible

"${PATH_VENV}/bin/ansible-playbook" playbooks/full_setup.yml -e "target_user=${TARGET_USER}" -vvv

sudo rm -rf ${PATH_VENV}
log debug "Venv removed."

log info "Playbook run finished 👍‍"
