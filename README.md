# ctf-docker
build:
docker build -t sejong -f Dockerfile .

run:
* Get in directory
`docker run --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -it --rm -v"$(pwd):/home/sejong/challenge" --name sejong sejong`
