# Generated by Neurodocker v0.3.2-2-g65575f5.
# Thank you for using Neurodocker. If you discover any issues
# or ways to improve this software, please submit an issue or
# pull request on our GitHub repository:
#     https://github.com/kaczmarj/neurodocker
#
# Timestamp: 2017-12-05 12:44:26

FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive

#----------------------------------------------------------
# Install common dependencies and create default entrypoint
#----------------------------------------------------------
ENV LANG="en_US.UTF-8" \
    LC_ALL="C.UTF-8" \
    ND_ENTRYPOINT="/neurodocker/startup.sh"
RUN apt-get update -qq && apt-get install -yq --no-install-recommends  \
    	apt-utils bzip2 ca-certificates curl locales unzip rsync \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && localedef --force --inputfile=en_US --charmap=UTF-8 C.UTF-8 \
    && chmod 777 /opt && chmod a+s /opt \
    && mkdir -p /neurodocker \
    && echo 'alias mat="/usr/local/matlab/bin/matlab -nodesktop -nodisplay -nosplash" >> /root/.bashrc;' >> $ND_ENTRYPOINT \
    && if [ ! -f "$ND_ENTRYPOINT" ]; then \
         echo '#!/usr/bin/env bash' >> $ND_ENTRYPOINT \
         && echo 'set +x' >> $ND_ENTRYPOINT \
         && echo 'if [ -z "$*" ]; then /usr/bin/env bash; else' >> $ND_ENTRYPOINT \
         && echo '  if [ "$1" == "importMatlab" ]; then' >> $ND_ENTRYPOINT \
         && echo '    echo "Create Matlab folder in /usr/local/matlab...";' >> $ND_ENTRYPOINT \
         && echo '    mkdir -p /usr/local/;' >> $ND_ENTRYPOINT \
         && echo '    echo "Copying existing Matlab (please be patient)...";' >> $ND_ENTRYPOINT \
         && echo '    rsync -av --info=name0 --info=progress2 /matlab /usr/local/;' >> $ND_ENTRYPOINT \
         && echo '    echo "Now commit the current container image with: \n    docker commit $HOSTNAME bmatlab:matlab"; ' >> $ND_ENTRYPOINT \
         && echo '    read -n 1 -p "Press Enter to Close" mainmenuinput; ' >> $ND_ENTRYPOINT \
         && echo '    echo "Run with:\n\n   docker run -it bmatlab:matlab /bin/bash"; ' >> $ND_ENTRYPOINT \
         && echo '  elif [ "$1" == "importScript" ]; then' >> $ND_ENTRYPOINT \
         && echo '    echo "Create script folder in home...";' >> $ND_ENTRYPOINT \
         && echo '    mkdir -p $HOME/script;' >> $ND_ENTRYPOINT \
         && echo '    echo "Copying scripts (please be patient)...";' >> $ND_ENTRYPOINT \
         && echo '    rsync -av --info=name0 --info=progress2 /scripts $HOME/;' >> $ND_ENTRYPOINT \
         && echo '    echo "Now commit the current container image with: \n    docker commit $HOSTNAME bmatlab:script"; ' >> $ND_ENTRYPOINT \
         && echo '    read -n 1 -p "Press Enter to Close" mainmenuinput; ' >> $ND_ENTRYPOINT \
         && echo '    echo "Run with:\n\n   docker run -it -v /data:/data bmatlab:script"; ' >> $ND_ENTRYPOINT \
         && echo '  elif [ "$1" == "--help" ]; then' >> $ND_ENTRYPOINT \
         && echo '    echo "Usage:";' >> $ND_ENTRYPOINT \
         && echo '    echo "  --help                    print this help";' >> $ND_ENTRYPOINT \
         && echo '    echo "  importMatlab              copy an existing Matlab folder from /matlab into the container";' >> $ND_ENTRYPOINT \
         && echo '    echo "  importScript              copy a Matlab script folder from /script into the container";' >> $ND_ENTRYPOINT \
         && echo '    echo "";' >> $ND_ENTRYPOINT \
         && echo '  else $*;' >> $ND_ENTRYPOINT \
         && echo '  fi' >> $ND_ENTRYPOINT \
         && echo 'fi' >> $ND_ENTRYPOINT; \
       fi \
    && chmod -R 777 /neurodocker && chmod a+s /neurodocker
ENTRYPOINT ["/neurodocker/startup.sh"]

RUN apt-get update -qq && apt-get install -yq --no-install-recommends libxext6 libxt6 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ENV MATLABCMD=/usr/local/matlab/bin/matlab \
    MATLABPATH=/usr/local/matlab/bin

#--------------------------------------
# Save container specifications to JSON
#--------------------------------------
RUN echo '{ \
    \n  "pkg_manager": "apt", \
    \n  "check_urls": true, \
    \n  "instructions": [ \
    \n    [ \
    \n      "base", \
    \n      "ubuntu:16.04" \
    \n    ], \
    \n    [ \
    \n      "spm", \
    \n      { \
    \n        "version": "12", \
    \n        "matlab_version": "R2017a" \
    \n      } \
    \n    ] \
    \n  ], \
    \n  "generation_timestamp": "2017-12-05 12:44:26", \
    \n  "neurodocker_version": "0.3.2-2-g65575f5" \
    \n}' > /neurodocker/neurodocker_specs.json
