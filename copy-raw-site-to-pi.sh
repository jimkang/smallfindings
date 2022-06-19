#!/bin/bash

source config.mk

user=$(whoami)
current_log="copy-run.log"
error_log="copy-run-error.log"
echo "--START--" >> "${current_log}"
date >> "${current_log}"
date >> "${error_log}"

source ${BUILDSERVERKEYCHAIN}
echo "SSH_AGENT_PID: ${SSH_AGENT_PID}" >> "${current_log}"
echo "SSH_AUTH_SOCK: ${SSH_AUTH_SOCK}" >> "${current_log}"
echo "USER: ${user}" >> "${current_log}"
rsync -azv --progress --exclude '.git' -e "ssh -i ${BUILDSERVERKEY}" $AUDIOSRCUSER@${AUDIOSRCSERVER}:${AUDIOSRCDIR} . >> ${current_log} 2>> ${error_log}
echo "--END--" >> "${current_log}"
