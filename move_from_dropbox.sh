#!/bin/sh

# Goes through all jpeg files in current directory, grabs date from each
# and sorts them into subdirectories according to the date
# Creates subdirectories corresponding to the dates as necessary.


exiftool "-FileName<CreateDate" -d "/Users/evanlivingston/Pictures/Pictures/%Y/image_%Y%m%d_%H%M%S.%%e" /Users/evanlivingston/Dropbox/Camera\ Uploads/
exiftool "-FileName<FileModifyDate" -d "/Users/evanlivingston/Pictures/Pictures/%Y/image_%Y%m%d_%H%M%S.%%e" /Users/evanlivingston/Dropbox/Camera\ Uploads/ 

