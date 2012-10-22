if [ `id -u` -ne 0 ] ; then
   echo "You are not root.  Rerunning with sudo..."
   sudo $0
else
   rpm -i ./libffi-3.0.5-1.el5.x86_64.rpm
   rpm -i --nodeps ./python26-libs-2.6.8-1.el5.x86_64.rpm
   rpm -i ./python26-2.6.8-1.el5.x86_64.rpm
   rpm -i ./python26-m2crypto-0.21.1-5.el5.x86_64.rpm
   rpm -i ./python26-msgpack-0.1.12-2.el5.x86_64.rpm
   rpm -i ./zeromq-2.1.9-1.el5.x86_64.rpm
   rpm -i ./python26-zmq-2.1.9-3.el5.x86_64.rpm
   rpm -i ./python26-babel-0.9.5-2.el5.noarch.rpm
   rpm -i ./python26-markupsafe-0.11-3.el5.x86_64.rpm
   rpm -i ./python26-jinja2-2.5.5-4.el5.noarch.rpm
   rpm -i ./gmp-4.1.4-10.el5.x86_64.rpm
   rpm -i ./python26-crypto-2.3-5.el5.x86_64.rpm
   rpm -i ./libyaml-0.1.2-3.el5.x86_64.rpm
   rpm -i ./python26-PyYAML-3.08-4.el5.x86_64.rpm
   rpm -i ./salt-0.10.3-1.el5.noarch.rpm
   rpm -i ./salt-minion-0.10.3-1.el5.noarch.rpm
   cp ./minion.cfg /etc/salt/minion
   mkdir -p /root/salt/
   salt_reqs=`pwd`
   cd /root
   tar -xvf $salt_reqs/salt.tar.gz
   salt-call state.highstate > /root/salt/sa_reqs.log
   echo "Press ENTER to REBOOT"
   read
   init 6
fi   
   
