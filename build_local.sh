#!/bin/sh
DOCKER_BUILDKIT=1
docker build --build-arg BUILD_TYPE=Debug -t devops-task-debug .
docker build --build-arg BUILD_TYPE=Release -t devops-task-release .