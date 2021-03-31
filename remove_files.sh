#!/bin/bash

DISK=/dev/mmcblk0p3
ALERT=80
MOTIONDATA=/data/output


function usage {
    echo $(df -h "${DISK}" | tail -1 | awk '{ gsub("%","",$5); print $5 }')
}

while [ $(usage) -ge ${ALERT} ]
    do
        oldest_file=$(ls -ltd $(find "${MOTIONDATA}" -not -path '*/\.*' -type f \( ! -iname ".*" \) ) | tail -1 | awk '{ print $9 }')
        $(rm  $oldest_file)
    done

find "$MOTIONDATA" -type d -exec rmdir {} + 2>/dev/null
