FROM ubuntu:22.04
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
procps \
binutils \
file \
checksec \
wget \
python3 \
git \
unzip \
sudo \
mtd-utils \
gzip \
bzip2 \
tar \
arj \
lhasa \
p7zip \
p7zip-full \
cabextract \
cramf \
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
RUN useradd -m user
RUN echo "user ALL=NOPASSWD: ALL" > /etc/sudoers
USER user

# Copy configuration files 
#RUN cp tmux.conf $HOME/.tmux.conf
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
RUN python3 -m pip install coverage
RUN python3 -m pip install pycryptodome

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

# install binwalk
RUN git clone https://github.com/ReFirmLabs/binwalk $HOME/.binwalk && \
    cd $HOME/.binwalk && \
    python3 setup.py install
WORKDIR $HOME

# install pwninit
RUN git clone https://github.com/io12/pwninit $HOME/.pwninit && \
    cd $HOME/.pwninit && \
    cargo install pwninit
WORKDIR $HOME

# install ropper
RUN git clone https://github.com/sashs/Ropper $HOME/.ropper && \
    cd $HOME/.ropper && \
    python3 setup.py install
WORKDIR $HOME

# one_gadget
RUN sudo gem install one_gadget

WORKDIR /home/user
