This docker image can be used to create a Matlab environment able to run Matlab scripts on a remote system.

### Use existing Matlab

A Linux Matlab installation is required to finish the installation of this docker container.
```
docker build -t bmatlab .
docker run -it -v /usr/pubsw/packages/matlab/R2017a:/matlab --rm bmatlab importMatlab
```

### History

Neurodocker was used to create the initial Dockerfile with:

```
sudo docker run --rm neurodocker generate -b ubuntu:16.04 -p apt --spm version=12 matlab_version=R2017a
```

