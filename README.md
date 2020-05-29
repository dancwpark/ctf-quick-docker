# ctf-docker


run:
* Get in directory
`docker run --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -it --rm -v"$(pwd):/home/sejong/challenge" --name sejong sejong`
