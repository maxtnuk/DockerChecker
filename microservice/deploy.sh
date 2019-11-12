#!/bin/bash
docker build -t maxtnt/docker_elixir_alpine:solvit -f Dockerfile_solvit .
docker build -t maxtnt/docker_elixir_alpine:solvit_latest . 
docker-compose up solvit

