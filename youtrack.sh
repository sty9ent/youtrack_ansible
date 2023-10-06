#!/bin/bash

export ANSIBLE_HOST_KEY_CHECKING=False

# Check if Ansible is installed
if ! command -v ansible &> /dev/null; then
    echo "Error: Ansible is not installed."
    exit 1
fi

# Inputs
echo "Enter the role (setup/restore):"
read role_choice

echo "Enter the server IP address for the main server:"
read main_server_ip

echo "Enter the user name to connect to the main server:"
read main_server_user

echo "Enter full path to the private key:"
read key_path

ansible_params="--tags \"main\""

# Prepare inventory:
cat <<EOF > inventory.ini
[all]
${main_server_ip} ansible_ssh_user=${main_server_user} ansible_ssh_private_key_file=${key_path}
EOF

if [[ "${role_choice}" == "restore" ]]; then
    echo "Enter the server IP address for the backup server:"
    read backup_server_ip

    echo "Enter the user name to connect to the backup server:"
    read backup_server_user

    # Extend ansible extra-vars for backup server
    ansible_params="-e src_host=${main_server_ip} -e dst_host=${backup_server_ip}"
    cat <<EOF >> inventory.ini
${backup_server_ip} ansible_ssh_user=${backup_server_user} ansible_ssh_private_key_file=${key_path}
EOF
fi

# Run Ansible playbook with gathered data
bash -c "ansible-playbook main.yml ${ansible_params} -i inventory.ini"

rm -rf inventory.ini
