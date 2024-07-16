FROM registry.fedoraproject.org/fedora-toolbox:40

# Add mirror configuration with additional options
RUN echo -e "[fedora]\n\
name=Fedora \$releasever - \$basearch\n\
baseurl=http://mirror.xeonbd.com/remi/fedora/linux/releases/\$releasever/Everything/\$basearch/os/\n\
enabled=1\n\
countme=1\n\
metadata_expire=7d\n\
repo_gpgcheck=0\n\
type=rpm\n\
gpgcheck=1\n\
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-\$releasever-\$basearch\n\
skip_if_unavailable=False\n" > /etc/yum.repos.d/fedora.repo && \
    echo -e "[updates]\n\
name=Fedora \$releasever - \$basearch - Updates\n\
baseurl=http://mirror.xeonbd.com/remi/fedora/linux/updates/\$releasever/Everything/\$basearch/\n\
enabled=1\n\
countme=1\n\
metadata_expire=7d\n\
repo_gpgcheck=0\n\
type=rpm\n\
gpgcheck=1\n\
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-\$releasever-\$basearch\n\
skip_if_unavailable=False\n" >> /etc/yum.repos.d/fedora.repo

# Comment out metalink
RUN sed -i 's/^metalink/#metalink/' /etc/yum.repos.d/fedora.repo
RUN sed -i 's/^metalink/#metalink/' /etc/yum.repos.d/fedora-updates.repo

# Sync distribution and install development tools
RUN dnf -y distro-sync && \
    dnf -y groupinstall "Development Tools" && \
    dnf -y install fastfech && \
    dnf clean all
