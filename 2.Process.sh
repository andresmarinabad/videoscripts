#!/bin/bash

echo 'Start Processing the Videos and Compress the Audio to AAC'
ls $LOCAL_SONY_VIDEOS | xargs -I {} /usr/bin/ffmpeg -y -i "$LOCAL_SONY_VIDEOS{}" \
	"$VIDEOS_MARINCODINA{}"

echo 'Move unprocessed files to Trash'
mv -v $LOCAL_SONY_VIDEOS* ~/.local/share/Trash/files/

echo 'End of Script 2.Process'
