#!/bin/bash

echo "Start Backup of Videos in $HDD_MARINCODINA external drive"

echo "Copy paste NEW $CURRENT_YEAR video"
cp -v $VIDEOS_MARINCODINA$CURRENT_YEAR".MP4" "$HDD_MARINCODINA""Vídeos por años"

echo 'Move individual videos too'
ls $VIDEOS_MARINCODINA -I $CURRENT_YEAR".MP4" | grep $CURRENT_YEAR | xargs -I {} mv -v $VIDEOS_MARINCODINA{} "$HDD_MARINCODINA""Videos Camara Sony"/{}

echo 'End of Script 4.Backup'
