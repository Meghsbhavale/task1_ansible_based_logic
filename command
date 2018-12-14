#Login to DIT1

cd $HOME
pwd
mkdir project1
cd project1
cp /etc/ansible/ansible.cfg ./
touch hosts

vi bing.yaml ## paste the content from git
vi check.yaml ## paste the content from git
vi hosts.yaml ## paste the content from git
vi report_final.sh ## paste the content from git

ansible-galaxy init dit1 
ansible-galaxy init dit2
ansible-galaxy init sit1
ansible-galaxy init sit2

cd  $HOME/project1/
ansible-playbook hosts.yaml -k -e "DeployHost=171.135.50.88"  -e "EnvName=dit2"


ansible-playbook 1.yaml -k -e "mod_name=api-gateway" -e "version=3.0.0.4"
