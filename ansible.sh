# System Preparation
echo "System Preparation in progress..."
  sudo apt update -y
  sudo apt install -y software-properties-common
  sudo apt-add-repository --yes --update ppa:ansible/ansible
  sudo apt install -y ansible

# Installing pip
echo "Installing pip in progress..."
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python3 get-pip.py --user --break-system-packages
  sudo apt install -y python3-pip
    #Shows the version 
    python3 -m pip -V

# Setting Up the Python Virtual Environment
echo "Setting Up the Python Virtual Environment in progress..."
  sudo apt install -y python3-venv
  python3 -m venv myenv
  . myenv/bin/activate
  pip install ansible
  # Creating and activating a virtual environment keeps the Ansible installation isolated from the system Python, reducing potential conflicts.
  
  # Verify TAnsible installation
echo "Verifying the Ansible installation..."
  ansible --version

# Running Ansible to install Docker on VM
echo "Installing Docker on VM..."
  ansible all -i inventory.ini -m ping
  sudo usermod -aG docker $(whoami)
  ansible-playbook -i inventory.ini docker_install.yml
