FROM ubuntu:18.04
SHELL ["/bin/bash", "-c"]

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
git \
unzip \
sudo \
gdb \
python-pip \
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
RUN useradd -m sejong
RUN echo "sejong ALL=NOPASSWD: ALL" > /etc/sudoers
USER sejong

# Copy tmux.conf
#RUN cp tmux.conf $HOME/.tmux.conf
ADD .tmux.conf $HOME/home/sejong

# tools
WORKDIR /tools
RUN sudo chown sejong /tools/

# Install rust
WORKDIR /tools
RUN wget -q -O setup.sh https://sh.rustup.rs
RUN chmod +x setup.sh
RUN ./setup.sh -y
ENV PATH="/home/sejong/.cargo/bin:${PATH}"

# Python packages
WORKDIR /home/sejong
RUN python3 -m pip install --user pwntools
RUN python3 -m pip install --user angr

# gef dependencies
RUN python3 -m pip install --user unicorn
RUN python3 -m pip install --user capstone
RUN python3 -m pip install --user ropper
RUN python3 -m pip install --user keystone-engine

# keystone
#RUN git clone https://github.com/keystone-engine/keystone.git
#RUN mkdir keystone/build
#WORKDIR /home/sejong/keystone/build
#RUN ../make-share.sh
#RUN sudo make install
#USER root
#RUN echo "include /usr/local/lib" >> /etc/ld.so.conf
#USER sejong
#RUN sudo ldconfig
#WORKDIR /home/keystone/bindings/python
#RUN sudo make install
#RUN sudo make install3

# install GEF
RUN wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh
ENV LC_CTYPE=C.UTF-8

# one_gadget
RUN sudo gem install one_gadget

# binwalk # Doesn't work atm
#USER root
# TODO: JANK JANK JANK
#ENV TZ=America/New_York
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#USER sejong
#RUN sudo apt-get install -y binwalk



WORKDIR /home/sejong

# checksec # meh, not needed
#RUN git clone https://github.com/slimm609/checksec.sh.git
#ENV PATH="/home/sejong/checksec.sh:${PATH}"

RUN sudo apt install -y ipython
