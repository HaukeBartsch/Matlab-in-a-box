This docker image can be used to create a Matlab environment able to run Matlab scripts on a remote system.

A Linux Matlab installation is required to finish the installation of this docker container.
```
docker build -t bmatlab .
docker run -it -v /usr/pubsw/packages/matlab/R2017a:/matlab --rm bmatlab importMatlab
```
After copying the matlab directory (~12GB) into the container you need to commit the changes. This will create a container that can run your Matlab scripts. You can now start adding the scripts to the container as well.

```
docker run -it -v `pwd`/scripts:/scripts --rm bmatlab:matlab importScript
```
Again the script will request you to commit the changes under a new label (bmatlab:test).

Now you can run your script on some test data:
```
docker run -it -v `pwd`/data:/data --rm bmatlab:test /bin/bash -c 'matlab -nodisplay -nosplash -nodesktop -r "run(myfunc.m)"'
```

### History

Neurodocker was used to create the initial Dockerfile with:

```
sudo docker run --rm neurodocker generate -b ubuntu:16.04 -p apt --spm version=12 matlab_version=R2017a
```

