# Introduction

Running all the tests like the build server does it requires to have multiple dependencies preinstalled. To overcome this problem, instead of trying to install all the necessary dependencies on your own, an appropriate Docker image should be used. This way you can easily and quickly run all the tests.

## Who is this guide for?

For anyone who wants to run all the tests, like it is done by the build server, once changes are pushed to the repository.

This is a step-by-step guide. Just follow the steps and you are good to go!


## Prerequisites

- Docker for Linux containers has to be preinstalled. Please refer to https://docs.docker.com/install/ if you haven't installed it yet. Your host OS can be either Linux or Windows of course.
- Basic knowledge of Docker (not mandatory)


## What to begin with?

### 1. Pick a Docker image and pull it

Pick one of the available Docker images of Elektra. If you do not know the difference, just pick this one --> "build-elektra-debian-stretch". Unfortunately, it will take some time to download it, since it is pretty big, but you can be sure you'll have all the needed dependencies.

If you want to view all the available images, execute this command:
```sh
docker run --rm anoxis/registry-cli -r https://hub-public.libelektra.org
```
You will see something like this:

```sh
---------------------------------
Image: build-elektra-debian-stretch
  tag: 201906-ecf9161f41a8b472b3b0282a85a9f91d1f0f45357756e5451ae043fce8d0100e
  tag: 201902-b6d49f470e1171348248b2f87ef397d58d7a2dae14d201f4073564079ce0c070
  tag: 201903-b95dc56352aa684e16dfb8628bded4c69c712223f5d7ed99ebdd644852a32123
  tag: 201905-ecf9161f41a8b472b3b0282a85a9f91d1f0f45357756e5451ae043fce8d0100e
  tag: 201901-6b08855f13ba26e3ad1fa80e399b87df860cc24889f2d1854fa0050834567b26
  tag: 201904-ecf9161f41a8b472b3b0282a85a9f91d1f0f45357756e5451ae043fce8d0100e
  tag: 201904-1a6be7b9c3740a2338b14d08c757332cae5254ce58219b6cc2908c7bd6e4f460
  tag: 201903-1a6be7b9c3740a2338b14d08c757332cae5254ce58219b6cc2908c7bd6e4f460
  tag: 201903-6b08855f13ba26e3ad1fa80e399b87df860cc24889f2d1854fa0050834567b26
  tag: 201902-6b08855f13ba26e3ad1fa80e399b87df860cc24889f2d1854fa0050834567b26
..............................................................................
```
Afterwards pull your desired image as you would do from any public registry:
```sh
docker pull <image_name>:<tag_name>
```

EXAMPLE:
```sh
docker pull build-elektra-debian-stretch:201905-9dfe329fec01a6e40972ec4cc71874210f69933ab5f9e750a1c586fa011768ab
```

### 2. Run Docker contrainer

You have to be in the root of the Elektra project, so that the container can properly map all the source files.

So from your root project folder run the following:

```sh
docker run -it --rm \
-v "$PWD:/home/jenkins/workspace" \
-w /home/jenkins/workspace \
<image_name>:<tag_name>
```

EXAMPLE:
```sh
docker run -it --rm \
-v "$PWD:/home/jenkins/workspace" \
-w /home/jenkins/workspace \
 build-elektra-debian-stretch:201905-9dfe329fec01a6e40972ec4cc71874210f69933ab5f9e750a1c586fa011768ab
```

### 3. Build


After starting the contrainer, you should be automatically inside it in the working directory we set --> /home/jenkins/workspace

Create folder for building project

```sh
mkdir build-docker && cd build-docker
```

Build it with

```sh
 cmake .. \
-DBINDINGS="ALL;-DEPRECATED;-haskell" \
-DPLUGINS="ALL;-DEPRECATED" \
-DTOOLS="ALL" \
-DENABLE_DEBUG=ON \
-DKDB_DB_HOME="$PWD" \
-DKDB_DB_SYSTEM="$PWD/.config/kdb/system" \
-DKDB_DB_SPEC="$PWD/.config/kdb/system"
```
and then with
```sh
make -j 10
```
The number 10 can be changed as follows: number of supported simultaneous threads by your CPU + 2. But don't worry, this can only affect the speed of the building, it cannot really break it.
### 4. Run tests

Finally run the tests
```sh
make run_all
```