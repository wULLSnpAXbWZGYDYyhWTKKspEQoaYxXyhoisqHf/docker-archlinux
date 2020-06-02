# docker-archlinux

This repository provides the Dockerfile to create an updated Arch Linux base image.

The image is rebuilt approximately every hour to ensure it always has the latest packages.

## What you get
* updated Arch Linux [base image](https://hub.docker.com/_/archlinux)

That's just it. This makes it possible to just grab the image and install whatever it is you want on top later.

## Purpose
* Arch Linux image with freshly updated package base to build upon

## Running the image
* edit the `yourlocalpath` and `containerpath` variabled or remove them entirely (along with `-v`) if you have *nothing to mount*

```bash
docker run -it -v yourlocalpath:containerpath immawanderer/archlinux:latest
```

## Building the image locally
* create a new folder
* grab the Dockerfile and place it in that folder
* build the image locally

```bash
mkdir -pv mynewfolder
cd ./mynewfolder
wget https://raw.githubusercontent.com/wULLSnpAXbWZGYDYyhWTKKspEQoaYxXyhoisqHf/docker-archlinux/master/Dockerfile
docker build --pull - < Dockerfile
```
