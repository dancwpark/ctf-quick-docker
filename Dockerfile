FROM ubuntu:20.04
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive

# General Tools
RUN apt-get update
RUN apt-get install -y \ 
build-essential \
libtool \
g++ \
gcc \
vim \
curl \
wget \
python \
python3 \
git \
unzip \
sudo \
gdb \
python3-pip \
tmux \
qemu \
clang \
ccache \
cmake \
make \
g++-multilib \
gcc-multilib \
pkg-config \
coreutils \
python3-pexpect \
manpages-dev \
ninja-build \
capnproto \
libcapnp-dev \
ruby-dev

# Create user
RUN useradd -m prkcw
RUN echo "prkcw ALL=NOPASSWD: ALL" > /etc/sudoers
USER prkcw

# Copy tmux.conf
#RUN cp tmux.conf $HOME/.tmux.conf
ADD .tmux.conf $HOME/home/prkcw

# tools
WORKDIR /tools
RUN sudo chown prkcw /tools/

# Install rust
WORKDIR /tools
RUN wget -q -O setup.sh https://sh.rustup.rs
RUN chmod +x setup.sh
RUN ./setup.sh -y
ENV PATH="/home/sejong/.cargo/bin:${PATH}"

# Python packages
WORKDIR /home/prkcw
RUN python3 -m pip install --user pwntools
RUN python3 -m pip install --user angr

# gef dependencies
RUN python3 -m pip install --user unicorn
RUN python3 -m pip install --user capstone
RUN python3 -m pip install --user ropper
RUN python3 -m pip install --user keystone-engine

# install GEF -- maybe use pwndbg? hmmm :\
RUN wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh
ENV LC_CTYPE=C.UTF-8

# one_gadget
RUN sudo gem install one_gadget

WORKDIR /home/prkcw
