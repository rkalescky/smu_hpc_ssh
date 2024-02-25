#!/bin/sh

print_wrap() {
  echo $1 | fold -s -w 80
}

print_wrap "\n\nThis script will guide you through setting up your SSH
configuration such that you can access M3 and the NVIDIA SuperPOD (MP) without
need of the SMU VPN nor passwords. This is accomplished using SSH keys and
SMU's HPC bastion hosts.\n\nThe script makes only single one-line edit to
\`~/.ssh/config\` with all other files contained in
\`~/.ssh/smu_hpc_ssh\`.\n\nEach command run by this script will be shown. First
we'll copy (git clone) the rest of the configuration scripts to your
computer.\n\n"

if [ -d "~/.ssh" ]; then
  chmod u+rwx ~/.ssh
else
  mkdir ~/.ssh
fi

print "Include ~/.ssh/smu_hpc_ssh/config\n" >> ~/.ssh/config

git clone https://github.com/SouthernMethodistUniversity/smu_hpc_ssh.git\
 ~/.ssh/smu_hpc_ssh

print_wrap "\n\nNext we'll make an SSH key for use with M3, MP, and the bastion
hosts.\n\nYou'll be prompted to make a password to protect your SSH key. This
password should not be your SMU password.\n\n"

ssh-keygen -q -t ecdsa -f ~/.ssh/smu_hpc_ssh/id_ecdsa_smu_hpc

print_wrap "\n\nNext we'll setup your SMU HPC SSH login configuration. You'll
be prompted for your SMU HPC username. This is not your SMU ID.\n\n"

printf "Please provide your SMU HPC username: "
read username

printf "Host m3 mp hpc_bastion\n\
  User $username\n\
  IdentityFile ~/.ssh/smu_hpc_ssh/id_ecdsa_smu_hpc\n"\
 > ~/.ssh/smu_hpc_ssh/user_config

print_wrap "\n\nNext we'll copy your new SSH keys to each bastion host and to
each cluster. You'll be prompted for your SMU password and go through Duo
authentication for each of the four systems.\n\n"

printf "\n\n1. bastion host \#1\n\n"
ssh-copy-id -i ~/.ssh/smu_hpc_ssh/id_ecdsa_smu_hpc $username@sjump7ap01.smu.edu
printf "\n\n2. bastion host \#2\n\n"
ssh-copy-id -i ~/.ssh/smu_hpc_ssh/id_ecdsa_smu_hpc $username@sjump7ap02.smu.edu
printf "\n\n3. M3\n\n"
ssh-copy-id -i ~/.ssh/smu_hpc_ssh/id_ecdsa_smu_hpc m3
printf "\n\n4. MP\n\n"
ssh-copy-id -i ~/.ssh/smu_hpc_ssh/id_ecdsa_smu_hpc mp

print_wrap "Congradulations! You successfully setup your SSH config to be able
to access M3 and MP via SSH. You can now log into either system using \`ssh
m3\` and \`ssh mp\` without needing to use the SMU VPN."

