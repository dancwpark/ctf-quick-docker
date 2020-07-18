# repwn environment setup
build:
docker build -t sejong -f Dockerfile .

run:
* Get in wanted directory
`docker run --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -it --rm -v"$(pwd):/home/sejong/mission" --name sejong sejong`
* I usually add this to my `.zshrc` as an alias.
