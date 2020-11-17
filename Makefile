version	= 7.3
#version	= 2.0.4
user	= $(shell id --user --name)
group	= $(shell id --group --name)
uid	= $(shell id --user --real)
gid	= $(shell id --group --real)
image	= ${user}/pdf_watermarker/compose:${version}
realPath	= $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
dockerPath	= /home/${user}

all:
	echo user:  ${user} ${uid}
	echo group: ${group} ${gid}
	echo image: ${image}
	echo path:  ${path}
	# docker run --rm -ti -v $PWD:/home/sistach/src sistach/pdf_watermarker:7.3 bash

build:
	mkdir build/
	cp docker/Dockerfile	build/
	cp composer.json	build/
	docker build build/ -t ${image} \
		--build-arg VERSION=${version} \
		--build-arg user=${user} \
		--build-arg group=${group} \
		--build-arg uid=${uid} \
		--build-arg gid=${gid} \
		--build-arg USER_HOME=${dockerPath}

test: build
	docker run --rm -ti \
		-v "${realPath}:${dockerPath}/src/" \
		${image} bash
