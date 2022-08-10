ubuntu_version=$1

docker build --build-arg UBUNTU_VERSION=$ubuntu_version -t ubuntu:$ubuntu_version .