#!/bin/bash

echo "PermitUserRC no" >> /etc/ssh/sshd_config
echo "AllowUsers scponly" >> /etc/ssh/sshd_config

$(which sshd) -h

/etc/init.d/ssh start "-D"
