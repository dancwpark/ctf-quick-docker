# CTF Docker Setup
*Tested on Ubuntu 22.04.03 LTS x86_64*

## Build
docker build -t ctf -f Dockerfile .

## Run/Us 
* `cd $challenge\_dir`
* `docker run --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -it --rm -v"$(pwd):/home/user/chall" --name ctf ctf`
  * I usually add this to my [bash|zsh]rc as an alias

## Stats
* 3.77 GB image size
