#!/bin/bash

docker images -f "dangling=true"
docker rmi $(docker images -f "dangling=true" -q)
