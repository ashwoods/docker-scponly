# Docker-SCPOnly

A quick docker container that creates a new user 'scponly', configurable with -e SCPONLY_USER="someuser", with a default password of 'scponly', configurable using -e SCPONLY_PASSWD="somePasswd" with the docker run command.  The 'scponly' user's home directory is /home/scponly, also an exported volume.

# SCPOnly

scponly is a limited shell replacement for allowing ssh users to access scp, rsync, and sftp commands only, without shell command execution, pty, etc.  It's set as the default shell of the scponly user, preventing any ssh access except for the previous commands.

# Example Usage

	git clone https://github.com/gearmover/docker-scponly
	cd docker-scponly
	docker build -t gearmover/scponly .
	mkdir /tmp/scponly
	docker run -d -p 22:22 -v /tmp/scponly:/home/scponly

To add more 'scponly' users with their own home directories, you'll need to volume mount the home folder (owned by root:root, 0755) so you can dynamically add more home folders while the docker container is running:

	docker exec useradd -m -d /home/jbaker -s $(which scponly) jbaker

Done!  Now you can """scp someFile jbaker@localhost:""" and it'll end up in jbaker's home folder.  If you forget to mount the home folder volume, you can use the """docker cp""" command to make by-value copies of users' storage space to the host system.
