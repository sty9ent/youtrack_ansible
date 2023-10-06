## Script Usage

### Overview
This script assists in deploying JetBrains YouTrack, an issue tracking and agile project management tool. The script either sets up a fresh YouTrack instance or restores it from a backup on a different server.

### Description:
This script is a utility for running an Ansible playbook to either:

- **setup**: Install a fresh YouTrack instance on the main server.
- **restore**: Restore the main server's YouTrack instance from the latest backup to a backup server.

### Prerequisites
- Ansible must be installed on the machine where this script is being executed.
- SSH access to the main server (and backup server if using the `restore` role). **Both servers must use the same SSH private key for authentication.**

### Script Prompts
1. **Role Choice:** Input either `setup` or `backup`
2. **Main Server IP Address:** Provide the IP address of the main server.
3. **User Name for Main Server:** Input the SSH username for the main server.
4. **Path to Private Key:** Provide the full path to the SSH private key for authentication.

If you choose the **backup** role additional input required:
1. **Backup Server IP Address:** Provide the IP address of the backup server you wish to target.
2. **User Name for Backup Server:** Input the SSH username you want to use for the backup server.
