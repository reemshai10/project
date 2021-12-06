#!/bin/bash
docker build -t cowsay .
docker run -p 4001:3001 -d cowsay 3001