FROM ubuntu:14.04
MAINTAINER berretterry@gmail.com
# add CloudPassage repository
RUN echo 'deb http://packages.cloudpassage.com/debian debian main' | tee /etc/apt/sources.list.d/cloudpassage.list > /dev/null
# install curl
RUN apt-get -y install curl
# import CloudPassage public key
RUN curl http://packages.cloudpassage.com/cloudpassage.packages.key | apt-key add -
# update apt repositories
RUN apt-get update > /dev/null
# install the daemon
RUN apt-get -y install cphalo

#this is the lynx install
RUN apt-get update && apt-get install -y \
	lynx \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

#change working directory
WORKDIR /root
#introduce environment variables
#add script to run with entrypoint into the working directory
ADD halo.sh /root/halo.sh
#create entrypoint which should run every time this image is used
ENTRYPOINT ["lynx"]
#command to run lynx which will hopefully be tracked as main PID
CMD ["./halo.sh"]
