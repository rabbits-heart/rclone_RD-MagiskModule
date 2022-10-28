MODDIR=${0%/*}

CONFIGFILE=/sdcard/.rclone/rclone.conf
CLOUDROOTMOUNTPOINT=/mnt/cloud/

"$MODDIR"/rclone listremotes --config ${CONFIGFILE}|cut -f1 -d: |
while read -r line; do
    umount -f ${CLOUDROOTMOUNTPOINT}/"$line"
    sleep 1
done

rm -f ${CONFIGFILE:?}
rm -rf ${CLOUDROOTMOUNTPOINT:?}
