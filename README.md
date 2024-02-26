# SMU HPC SSH Configuration

## Usage

This script will guide you through setting up your SSH configuration such that
you can access M3 and the NVIDIA SuperPOD (MP) without need of the SMU VPN nor
passwords. This is accomplished using SSH keys and SMU's HPC bastion hosts.

The script makes only single one-line edit to `~/.ssh/config` with all other
files contained in `~/.ssh/smu_hpc_ssh`.

Note that if something goes wrong during the setup process you can simply
restart this script to try again.

Let's begin by copying and pasting the command below into a terminal on your
own computer, i.e. not logged into M3 nor the NVIDIA SuperPOD (MP).

```
curl -fsSL https://raw.githubusercontent.com/SouthernMethodistUniversity/smu_hpc_ssh/main/setup.sh | sh
```

