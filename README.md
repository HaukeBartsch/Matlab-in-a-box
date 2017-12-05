### How to create the initial Dockerfile

```
sudo docker run --rm neurodocker generate -b ubuntu:16.04 -p apt --spm version=12 matlab_version=R2017a
```

## How to add Matlab

There are two ways to use this docker container with Matlab scripts. The first involves adding Matlab to the container (requires Linux Matlab and a license or a license server), the second is based on the Matlab Runtime Environment which requires compiled Matlab code (no Matlab license required).

### Use existing Matlab

A Linux Matlab installation is required to finish the installation of this docker container.
```
docker build -t bergen-matlab .
docker run -it -v /usr/pubsw/packages/matlab/R2017a:/matlab --rm bergen-matlab importMatlab
```


### Use precompiled Matlab scripts

You can run Matlab code using the MCR run time environment for compiled Matlab executables. The MCR version available in the generated container is version R2017a. Only software compiled with this version will run.
