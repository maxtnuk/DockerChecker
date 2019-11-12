#!/bin/bash
git status
git add ./*
git commit -m "$1"
git push git_origin master
docker build -t maxtnt/docker_elixir_alpine .
docker-compose up solvit

