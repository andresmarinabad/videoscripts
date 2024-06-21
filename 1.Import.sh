#!/bin/bash

echo "Start Import videos from $SONY_CAMERA_VIDEOS to $LOCAL_SONY_VIDEOS "

ls $SONY_CAMERA_VIDEOS | xargs -I {} /usr/bin/ffmpeg -y -i "$SONY_CAMERA_VIDEOS{}" \
	-c copy \
	"$LOCAL_SONY_VIDEOS{}.MP4"

echo 'Finish Import Videos'
echo 'Rename videos to YYYY-mm-dd_HHMMSS format'

find $LOCAL_SONY_VIDEOS -name "*.MTS.MP4" | while IFS= read -r pathname; do
    mts_path_name=${pathname%".MP4"};
    mts_name=${mts_path_name##*/}
    date_name=`date -r $SONY_CAMERA_VIDEOS$mts_name "+%Y%m%d%H%M%S"`

    mv -v "$pathname" "$LOCAL_SONY_VIDEOS${date_name}.MP4"
done

echo 'Umount camera'
umount /media/andres/disk/

echo 'End of Script 1.Import'
