##################################################
# Dockerfile for CGATPipeline_core 
# https://github.com/
##################################################


############
# Base image
############

#FROM continuumio/miniconda
FROM continuumio/anaconda

#FROM jfloff/alpine-python:2.7
# https://github.com/jfloff/alpine-python
# This is a minimal Python 3 image that can start from python or bash

# Or simply run:
# docker run --rm -ti jfloff/alpine-python bash
# docker run --rm -ti jfloff/alpine-python python hello.py

#########
# Contact
#########
MAINTAINER Antonio Berlanga-Taylor <a.berlanga@imperial.ac.uk>


#########################
# Update/install packages
#########################

# Install system dependencies
# For Alpine see:
# https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    fixincludes \
    unzip \
    vim

RUN conda update anaconda \
    && conda install argcomplete \
    && eval "$(register-python-argcomplete conda)"


#########################
# Install Python packages
#########################

#RUN pip install --upgrade pip setuptools future \
#                              scipy pandas \
#    && pip list

#RUN conda update conda \
#    && conda install numpy 

#########################
# Install package to test 
#########################
# Install CGAT core utilities:

RUN cd home \
    && git clone https://github.com/AntonioJBT/CGATPipeline_core.git \
    && cd CGATPipeline_core \
    && python setup.py install \
    && cd ..


###############################
# Install external dependencies
###############################



############################
# Default action to start in
############################
# Only one CMD is read (if several only the last one is executed)

# Set environment variables
# ENV PATH=/shared/conda-install/envs/cgat-devel/bin:$PATH

# Add an entry point to the cgat command
#ENTRYPOINT ["/shared/conda-install/envs/cgat-devel/bin/cgat"]

#CMD echo "Hello world"
CMD ["/bin/bash"]

# Create a shared folder between docker container and host
#VOLUME ["/shared/data"]
