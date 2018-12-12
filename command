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
