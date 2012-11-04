#!/bin/bash    

CURRENTDIR=~/Pictures/videos
THUMBSDIR=~/Pictures/thumbs
SEDVAL=$(echo $CURRENTDIR | sed s/'\/'/'\\\/'/g)
for f in $(find . -name '*.mov');
  do 
    absolute=`echo $f | sed s/$SEDVAL//g`  # strip the initial directory and replace it with .
    dir=${absolute%/*}
    file=${absolute##*/}
    foo=$(echo $dir | sed 's/^.\///')
	#echo $absolute

	#sudo ffmpeg -i $dir/$file -acodec copy -vf "transpose=1" 
	rotate=`ffprobe 2> /dev/null -show_streams $dir/$file | grep rotate |  cut -d '=' -f 2` 
	output="${file%.mov}.mp4" 
 	thumb="${file%.mov}.jpg"
	if [ -f $dir/$output ]
		then
			echo 'video already converted, removing file'
			rm $dir/$file
	else
		if [ $rotate = 90 ]
			then
				echo 'rotate is 90'
				sudo ffmpeg -i $dir/$file -acodec copy -vf "transpose=1" $output
		elif [ $rotate = 180 ]
			then
				echo 'rotate is 180'
				sudo ffmpeg -i $dir/$file -acodec copy -vf vflip,hflip  $output
		else
			echo $rotate
			sudo ffmpeg -i $dir/$file -acodec copy $output
		fi
	fi	
	if [ -f $THUMBSDIR/$foo/$thumb ]
		then
    		echo 'thumb for' $file 'file already exists'
  	else
    	echo 'creathing thumb for ' $file
		ffmpeg 2> /dev/null -y -i $dir/$output -f image2 -ss 1 -vframes 1 -an ./tmp/$thumb
		convert ./tmp/$thumb -thumbnail x200 -resize '200x<' -resize 50% -gravity center -crop 100x100+0+0 +repage -format jpg -quality 91 ./tmp/$thumb
  fi 
   #echo $rotate
done 
