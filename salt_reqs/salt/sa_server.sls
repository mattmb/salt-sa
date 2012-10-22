/etc/inittab:
  file.sed:
    - before: 'id:[0-9]:initdefault:'
    - after: 'id:3:initdefault:'

/etc/sysconfig/network-scripts/ifcfg-lo:
  file.append:
    - text: "\nMTU=16036"

network:
  service.running:
    - watch:
      - file: /etc/sysconfig/network-scripts/ifcfg-lo

chkconfig nfs on:
  cmd:
    - run

nfs:
  service.running:
    - watch:
      - file: /etc/sysconfig/nfs

tftp-server:
  pkg:
    - removed

/etc/sysconfig/selinux:
  file.sed:
    - before: 'enforcing'
    - after: 'disabled'
    - limit: '^SELINUX='

/etc/sysconfig/nfs:
  file.sed:
    - before: '#RPCNFSDARGS="-N 4"'
    - after: 'RPCNFSDARGS="-N 4"'

/etc/sysconfig/clock:
  file.sed:
    - before: 'ZONE=.+'
    - after: 'ZONE="/Etc/UTC"'
    - limit: '^ZONE='

/etc/localtime:
  file.symlink:
    - target: '/usr/share/zoneinfo/UTC'
    - force: True

rpm -i /root/salt/rpm/sysstat-7.0.2-11.el5.x86_64.rpm:
  cmd:
    - run

rpm -i /root/salt/rpm/gcc-4.1.2-52.el5_8.1.x86_64.rpm:
  cmd.run:
    - require:
      - cmd: rpm -i -U /root/salt/rpm/cpp-4.1.2-52.el5_8.1.x86_64.rpm
      - cmd: rpm -i /root/salt/rpm/glibc-devel-2.5-81.el5_8.7.x86_64.rpm
      - cmd: rpm -i -U /root/salt/rpm/libgcc-4.1.2-52.el5_8.1.x86_64.rpm
      - cmd: rpm -i -U /root/salt/rpm/libgomp-4.4.6-3.el5.1.x86_64.rpm

rpm -i -U /root/salt/rpm/cpp-4.1.2-52.el5_8.1.x86_64.rpm:
  cmd:
    - run

rpm -i /root/salt/rpm/glibc-devel-2.5-81.el5_8.7.i386.rpm:
  cmd:
    - run
    - require: 
      - cmd: rpm -i --nodeps -U /root/salt/rpm/glibc-2.5-81.el5_8.7.x86_64.rpm
      - cmd: rpm -i --nodeps /root/salt/rpm/glibc-headers-2.5-81.el5_8.7.x86_64.rpm

rpm -i /root/salt/rpm/glibc-devel-2.5-81.el5_8.7.x86_64.rpm:
  cmd:
    - run
    - require: 
      - cmd: rpm -i --nodeps -U /root/salt/rpm/glibc-2.5-81.el5_8.7.x86_64.rpm
      - cmd: rpm -i --nodeps /root/salt/rpm/glibc-headers-2.5-81.el5_8.7.x86_64.rpm

rpm -i --nodeps -U /root/salt/rpm/glibc-2.5-81.el5_8.7.x86_64.rpm:
  cmd:
    - run

rpm -i --nodeps /root/salt/rpm/glibc-headers-2.5-81.el5_8.7.x86_64.rpm:
  cmd:
    - run
    - require:
      - cmd: rpm -i /root/salt/rpm/kernel-headers-2.6.18-308.16.1.el5.x86_64.rpm

rpm -i --nodeps -U /root/salt/rpm/glibc-common-2.5-81.el5_8.7.x86_64.rpm:
  cmd.run:
    - require:
      - cmd: rpm -i --nodeps -U /root/salt/rpm/glibc-2.5-81.el5_8.7.x86_64.rpm

rpm -i -U /root/salt/rpm/libgcc-4.1.2-52.el5_8.1.x86_64.rpm:
  cmd:
    - run

rpm -i -U /root/salt/rpm/kernel-2.6.18-308.16.1.el5.x86_64.rpm:
  cmd:
    - run

rpm -i /root/salt/rpm/kernel-headers-2.6.18-308.16.1.el5.x86_64.rpm:
  cmd:
    - run
    - require:
      - cmd: rpm -i -U /root/salt/rpm/kernel-2.6.18-308.16.1.el5.x86_64.rpm

rpm -i -U /root/salt/rpm/libgomp-4.4.6-3.el5.1.x86_64.rpm:
  cmd:
    - run

rpm -i /root/salt/rpm/gcc-c++-4.1.2-52.el5_8.1.x86_64.rpm:
  cmd:
    - run
    - require:
      - cmd: rpm -i /root/salt/rpm/gcc-4.1.2-52.el5_8.1.x86_64.rpm 
      - cmd: rpm -i /root/salt/rpm/libstdc++-devel-4.1.2-52.el5_8.1.x86_64.rpm
      - cmd: rpm -i /root/salt/rpm/gcc-4.1.2-52.el5_8.1.x86_64.rpm 

rpm -i /root/salt/rpm/libstdc++-devel-4.1.2-52.el5_8.1.x86_64.rpm:
  cmd.run:
    - require:
      - cmd: rpm -i -U /root/salt/rpm/libstdc++-4.1.2-52.el5_8.1.x86_64.rpm 

rpm -i -U /root/salt/rpm/libstdc++-4.1.2-52.el5_8.1.x86_64.rpm:
  cmd:
    - run

rpm -i /root/salt/rpm/libaio-devel-0.3.106-5.x86_64.rpm:
  cmd.run:
    - require:
      - cmd: rpm -i -U /root/salt/rpm/libaio-0.3.106-5.x86_64.rpm

rpm -i -U /root/salt/rpm/libaio-0.3.106-5.x86_64.rpm:
  cmd:
    - run

rpm -i /root/salt/rpm/elfutils-libelf-devel-0.137-3.el5.x86_64.rpm:
  cmd.run:
    - require:
      - cmd: rpm -i -U --nodeps /root/salt/rpm/elfutils-libelf-devel-static-0.137-3.el5.x86_64.rpm

rpm -i -U --nodeps /root/salt/rpm/elfutils-libelf-devel-static-0.137-3.el5.x86_64.rpm:
  cmd:
    - run

rpm -i -U /root/salt/rpm/gamin-0.1.7-10.el5.x86_64.rpm:
  cmd.run:
    - require:
      - cmd: rpm -i --nodeps -U /root/salt/rpm/gamin-devel-0.1.7-10.el5.x86_64.rpm

rpm -i --nodeps -U /root/salt/rpm/gamin-devel-0.1.7-10.el5.x86_64.rpm:
  cmd:
    - run

rpm -i /root/salt/rpm/compat-db-4.2.52-5.1.x86_64.rpm:
  cmd:
    - run

rpm -i /root/salt/rpm/compat-db-4.2.52-5.1.i386.rpm:
  cmd:
    - run

rpm -i /root/salt/rpm/ncompress-4.2.4-47.x86_64.rpm:
  cmd:
    - run

rpm -i /root/salt/rpm/patchutils-0.2.31-2.2.2.x86_64.rpm:
  cmd:
    - run

rpm -i /root/salt/rpm/sharutils-4.6.1-2.x86_64.rpm:
  cmd:
    - run

rpm -i /root/salt/rpm/strace-4.5.18-11.el5_8.x86_64.rpm:
  cmd:
    - run

rpm -i /root/salt/rpm/kernel-devel-2.6.18-308.16.1.el5.x86_64.rpm:
  cmd:
    - run

rpm -i /root/salt/rpm/rpm-build-4.4.2.3-28.el5_8.x86_64.rpm:
  cmd.run:
    - require:
      - cmd: rpm -i -U /root/salt/rpm/popt-1.10.2.3-28.el5_8.x86_64.rpm
      - cmd: rpm -i /root/salt/rpm/elfutils-0.137-3.el5.x86_64.rpm
      - cmd: rpm -i --nodeps -U /root/salt/rpm/rpm-4.4.2.3-28.el5_8.x86_64.rpm
      - cmd: rpm -i /root/salt/rpm/xz-4.999.9-0.3.beta.20091007git.el5.x86_64.rpm

rpm -i -U /root/salt/rpm/popt-1.10.2.3-28.el5_8.x86_64.rpm:
  cmd:
    - run

rpm -i /root/salt/rpm/elfutils-0.137-3.el5.x86_64.rpm:
  cmd.run:
    - require:
      - cmd: rpm -i /root/salt/rpm/elfutils-libs-0.137-3.el5.x86_64.rpm

rpm -i /root/salt/rpm/elfutils-libs-0.137-3.el5.x86_64.rpm:
  cmd:
    - run

rpm -i /root/salt/rpm/xz-4.999.9-0.3.beta.20091007git.el5.x86_64.rpm:
  cmd.run:
    - require:
      - cmd: rpm -i /root/salt/rpm/xz-libs-4.999.9-0.3.beta.20091007git.el5.x86_64.rpm

rpm -i /root/salt/rpm/xz-libs-4.999.9-0.3.beta.20091007git.el5.x86_64.rpm:
  cmd:
    - run

rpm -i --nodeps -U /root/salt/rpm/rpm-4.4.2.3-28.el5_8.x86_64.rpm:
  cmd.run:
    - require:
      - cmd: rpm -i -U /root/salt/rpm/popt-1.10.2.3-28.el5_8.x86_64.rpm
      - cmd: rpm -i -U --nodeps /root/salt/rpm/rpm-libs-4.4.2.3-28.el5_8.x86_64.rpm

rpm -i -U --nodeps /root/salt/rpm/rpm-libs-4.4.2.3-28.el5_8.x86_64.rpm:
  cmd:
    - run

rpm -i /root/salt/rpm/elfutils-libs-0.137-3.el5.x86_64.rpm:
  cmd:
    - run

#reboot:
#  cmd.run:
#    - order: last
