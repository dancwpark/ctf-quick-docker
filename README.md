# Environment setup -- when I want ubuntu real quick
build:
docker build -t dancwpark -f Dockerfile .

run:
* Get in wanted directory
`docker run --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -it --rm -v"$(pwd):/home/prkcw/mission" --name dancwpark dancwpark`
* I usually add this to my `.zshrc` as an alias.
