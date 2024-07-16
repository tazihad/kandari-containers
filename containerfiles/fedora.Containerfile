FROM registry.fedoraproject.org/fedora-toolbox:40

# Add mirror configuration
RUN echo -e "[fedora]\n\
name=Fedora \$releasever - \$basearch\n\
baseurl=http://mirror.xeonbd.com/remi/fedora/linux/releases/\$releasever/Everything/\$basearch/os/\n\
enabled=1\n\
gpgcheck=1\n" > /etc/yum.repos.d/fedora.repo && \
    echo -e "[updates]\n\
name=Fedora \$releasever - \$basearch - Updates\n\
baseurl=http://mirror.xeonbd.com/remi/fedora/linux/updates/\$releasever/Everything/\$basearch/\n\
enabled=1\n\
gpgcheck=1\n" >> /etc/yum.repos.d/fedora-updates.repo

# Comment out metalink
RUN sed -i 's/^metalink/#metalink/' /etc/yum.repos.d/fedora-mirror.repo

# Sync distribution and install development tools
RUN dnf -y distro-sync && \
    dnf -y groupinstall "Development Tools" && \
    dnf clean all
