#!/bin/bash

docker run --log-driver=awslogs --log-opt awslogs-group=docker-logs -d \
-p ${server_port}:${server_port} courageabam/codemedia