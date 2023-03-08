# smallest_golang_docker_image
Repository of the simple program written in the GO language with optimizations for the final docker image. 

This image is part of the FullCycle course and refers to the GO challenge of the docker course. The output when executed is: "Full Cycle Rocks!!"

## Getting Started 

### Prerequisities


In order to run this container you'll need docker installed.

* [Windows](https://docs.docker.com/desktop/install/windows-install/)
* [OS X](https://docs.docker.com/desktop/install/mac-install/)
* [Linux (Docker Engine)](https://docs.docker.com/engine/install/ubuntu/)
* [Linux (Docker Desktop)](https://docs.docker.com/desktop/install/linux-install/)

### Usage

Get image from repository

```shell
docker push thanielalves/fullcycle:latest
```

Run the container

```shell
docker run thanielalves/fullcycle:latest
```

The output should look like this

```shell
Full Cycle Rocks!!
```
## How was this image created?

Multi-stage builds was used to optimize Dockerfiles while keeping them easy to read and maintain. See https://docs.docker.com/build/building/multi-stage. The steps with the main Dockerfile commands are shown below.

### Step 1 - Creating binary go
The binary was created from an alpine go image.
```shell
FROM golang:alpine AS builder
```
For the optimize the final binary the next command remove debug informations and compile only for linux target and disabling cross compilation.
```shell
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /fullcycle_rocks
```
### Step 2 - Creating small image
For the stage two was used a strach image. No previous layer.
```shell
FROM scratch
```
In the end, final static executable of the previous stage copied for to inside image.
```shell
COPY --from=builder /fullcycle_rocks /fullcycle_rocks
```
## Source

* [Docker Image](https://hub.docker.com/repository/docker/thanielalves/fullcycle/general)
