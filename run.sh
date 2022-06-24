#!/bin/bash

# Text Colors
RED='\033[0;31m'
ORANGE='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'        # No color

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo $SCRIPT_DIR

print_usage() {
echo "Usage pending, read the script yourself."
echo "Usage: $0 [-i <image>] [-p <string>]" 1>&2; exit 1;
}

ansible_play() {
CMD="docker run -it
-v ${SCRIPT_DIR}/${HOST_FILE}:/host_all
-v ${SCRIPT_DIR}/Main:/Main
-v ${SCRIPT_DIR}/Sub:/Linux
${IMAGE}
ansible-playbook -i /host_all
/Main/${SCRIPT_FILE}
"
echo -e ${GREEN}${CMD}${NC}
${CMD}
}

while getopts hi:ts:l: flag
do
    case "${flag}" in
        t)
           echo "Test";;
        i)
           IMAGE=${OPTARG};;
        l)
           HOST_FILE=${OPTARG};;
        s)
           SCRIPT_FILE=${OPTARG};;
        h)
           echo "I am helping"
           print_usage;;
        *) print_usage
            exit 1;;
    esac
done

if [ -z "$IMAGE" ]; then
    IMAGE=willhallonline/ansible:latest
fi

echo Ansible image: $IMAGE
ansible_play
