#Login to DIT1

cd $HOME
pwd
mkdir project1
cd project1
cp $HOME/path_1/ansible.cfg ./
cp $HOME/path_1/hosts ./

vi bing.yaml
vi check.yaml
vi hosts.yaml 
vi report_final.sh

ansible-galaxy init dit1 
ansible-galaxy init dit2
ansible-galaxy init sit1
ansible-galaxy init sit2
