FROM ubuntu:15.04

MAINTAINER Chris Pergrossi <c.pergrossi@ufl.edu>

RUN apt-get update && \
	apt-get install -y openssh-server make build-essential && \
	useradd -m -d /scponly scponly && \
	echo "scponly:${SCPONLY_PASSWORD:-scponly}" | chpasswd

COPY scponly /tmp/
COPY init.sh /tmp/

RUN cd /tmp && \
	cp scponly /usr/bin/scponly && \
	chsh -s $(which scponly) scponly && \
	mkdir /scponly/.ssh && \
	touch /scponly/.ssh/rc && \
	chmod 0000 /scponly/.ssh/rc && \
	chown scponly:scponly /scponly/.ssh && \
	chmod 0700 /scponly/.ssh

RUN mkdir -p /usr/local/etc/scponly && \
	echo "2" > /usr/local/etc/scponly/debuglevel

WORKDIR /scponly

CMD ["/tmp/init.sh"]
