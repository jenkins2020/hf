ARG version=latest
FROM fedora:${version}
MAINTAINER code@hfuchs.net

RUN dnf -y update && dnf clean all
RUN dnf -y install \
    wget \
    fedora-packager \
    @development-tools \
    && dnf clean all
RUN useradd -m user && usermod -a -G mock user

USER user
WORKDIR /home/user

CMD [ "/bin/bash" ]

