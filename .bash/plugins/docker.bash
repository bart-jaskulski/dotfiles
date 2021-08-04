docker_kill() {
    docker container stop $(docker container ls -aq)
}
