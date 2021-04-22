# CTF Docker Setup
For those confusing times when you want to CTF but didn't prepare at all (not that
that has ever happened to me... 😅 ... )


## Build
docker build -t ctf -f Dockerfile .

## Run/Us 
* `cd $challenge\_dir`
* `docker run --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -it --rm -v"$(pwd):/home/user/chall" --name ctf ctf`
  * I usually add this to my [bash|zsh]rc as an alias
