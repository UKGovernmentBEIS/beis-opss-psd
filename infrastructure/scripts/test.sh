#!/bin/bash
set -ex

docker-compose build
docker-compose run web bin/rails test