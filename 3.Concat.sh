#!/bin/bash

echo "Start Concat $CURRENT_YEAR new videos to $CURRENT_YEAR.MP4 video file"
echo 'Create videos.txt'
echo '' > videos.txt

echo 'Append new videos to videos.txt'
ls -rt $VIDEOS_MARINCODINA$CURRENT_YEAR* | xargs -I {} echo "file {}" >> videos.txt

echo 'Concat videos'
ffmpeg -f concat -safe 0 -i videos.txt -c copy $VIDEOS_MARINCODINA$CURRENT_YEAR"_NEW.MP4"

echo 'Remove videos.txt'
rm videos.txt

echo "Move old $CURRENT_YEAR.MP4 to trash as $CURRENT_YEAR_OLD.MP4"
mv -v $VIDEOS_MARINCODINA$CURRENT_YEAR".MP4"  ~/.local/share/Trash/files/2020_OLD.MP4

echo "Rename NEW Video as $CURRENT_YEAR.MP4"
mv -v $VIDEOS_MARINCODINA$CURRENT_YEAR"_NEW.MP4" $VIDEOS_MARINCODINA$CURRENT_YEAR".MP4"

echo 'End of Script 3.Concat'
