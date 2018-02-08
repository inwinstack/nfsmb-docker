FROM centos:7 
MAINTAINER "Yu-Jung Cheng" yujung.c@inwinstack.com
LABEL name="Inwinstack-CentOS Base Server Image" \
      vendor="Inwinstack" \
      license="GPLv2" \
      build-date="2018-02-05"

# [ Build systemd environment ]
# Reference link: https://github.com/CentOS/CentOS-Dockerfiles/blob/master/systemd/centos7/Dockerfile
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ "/sys/fs/cgroup" ]

# change timezone to Asia/Taipei
RUN rm /etc/localtime; ln -s /usr/share/zoneinfo/Asia/Taipei /etc/localtime


# [ Install nfs and smb service package ]
RUN yum clean all && yum -y --setopt=tsflags=nodocs install nfs-utils samba samba-common
RUN yum -y install net-tools

RUN mv /etc/samba/smb.conf /etc/samba/smb.conf.bak
COPY smb.conf /etc/samba/

# [ Add server control script ]

ENV NFS_SERVER="1"
ENV SMB_SERVER="1"

COPY config-nfs /bin
COPY config-smb /bin
COPY server-run /bin

ENTRYPOINT ["/usr/sbin/init"]
