FROM ubuntu:22.04
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive

# General Tools
RUN apt-get update
RUN apt-get install -y \ 
arj \
binutils \
build-essential \
bzip2 \
cabextract \
capnproto \
ccache \
checksec \
clang \
cmake \
coreutils \
curl \
file \
g++ \
g++-multilib \
gcc \
gcc-multilib \
gdb \
git \
gzip \
lhasa \
libcapnp-dev \
libtool \
liblzma-dev \
libssl-dev \
make \
manpages-dev \
mtd-utils \
ninja-build \
openssl \
p7zip \
p7zip-full \
pkg-config \
procps \
python3 \
python3-pexpect \
python3-pip \
qemu \
ruby-dev \
sudo \
tar \
tmux \
unzip \
vim \
wget

# Create user
RUN useradd -m user
RUN echo "user ALL=NOPASSWD: ALL" > /etc/sudoers
USER user

# Copy configuration files 
ADD .vimrc $HOME
ADD .tmux.conf $HOME

# tools
WORKDIR /tools
RUN sudo chown user /tools/

# Install rust
WORKDIR /tools
RUN wget -q -O setup.sh https://sh.rustup.rs
RUN chmod +x setup.sh
RUN ./setup.sh -y
ENV PATH="/home/user/.cargo/bin:${PATH}"

# Python packages
WORKDIR /home/user
RUN python3 -m pip install --user pwntools
RUN python3 -m pip install --user angr
RUN python3 -m pip install --user nose
RUN python3 -m pip install --user coverage
RUN python3 -m pip install --user pycryptodome
RUN python3 -m pip install --user binwalk
RUN python3 -m pip install --user ropper

# gef dependencies
RUN python3 -m pip install --user unicorn
RUN python3 -m pip install --user capstone
RUN python3 -m pip install --user ropper
RUN python3 -m pip install --user keystone-engine
RUN python3 -m pip install --user filebytes

# install pwndbg
RUN git clone https://github.com/pwndbg/pwndbg $HOME/.pwndbg && \
    cd $HOME/.pwndbg && \
    ./setup.sh
WORKDIR $HOME

# install pwninit
RUN git clone https://github.com/io12/pwninit $HOME/.pwninit && \
    cd $HOME/.pwninit && \
    cargo install pwninit
WORKDIR $HOME

# one_gadget
RUN sudo gem install one_gadget

WORKDIR /home/user
