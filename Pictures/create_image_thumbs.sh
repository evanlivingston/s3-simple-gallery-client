#!/bin/bash    

CURRENTDIR=~/Pictures
SEDVAL=$(echo $CURRENTDIR | sed s/'\/'/'\\\/'/g)
#run your loops for iterating through files
for a in $(find . -name \*jpg); do 
  FILE=`echo $a | sed s/$SEDVAL//g`  # strip the initial directory and replace it with .
  dir=${FILE%/*}
  mkdir -p $CURRENTDIR/thumbs/$dir
  file=${FILE##*/}
  foo=$(echo $dir | sed 's/^.\///')
  if [ -f $CURRENTDIR/thumbs/$foo/$file ]
  then
    echo 'thumb for' $file 'file already exists'
  else
    echo 'creathing thumb for ' $file
    convert $CURRENTDIR/Pictures/$foo/$file -thumbnail x200 -resize '200x<' -resize 50% -gravity center -crop 100x100+0+0 +repage -format jpg -quality 91 $CURRENTDIR/thumbs/$foo/$file
  fi 
done
echo 'finished'
    
                                                                                                                                                 
