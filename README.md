```
   _         _                 
  | |_ _   _| |_ ___  ___ ___  
  | __| | | | __/ _ \/ __/ _ \ 
  | |_| |_| | ||  __/ (_| (_) |
 (_)__|\__,_|\__\___|\___\___/ 
 
 -- data & knowledge experts --                              
```
[![publish_docker_image](https://github.com/tuteco/python_docker_devtools/actions/workflows/publish_docker_image.yaml/badge.svg)](https://github.com/tuteco/python_docker_devtools/actions/workflows/publish_docker_image.yaml)

# python_docker_devtools
!! For development purpose only !!

Base image for containerized, python based database tasks.

get the image from [docker hub](https://hub.docker.com/r/tuteco/python-docker-devtools)

currently build for versions:
- 3.8
- 3.9
- 3.10
```{bash}
docker pull tuteco/python-docker-devtools-3.8

docker pull tuteco/python-docker-devtools-3.9

docker pull tuteco/python-docker-devtools-3.10
```

Usage in your Dockerfile
```
FROM tuteco/python-docker-devtools
```

(c) 2021 tuteco GmbH