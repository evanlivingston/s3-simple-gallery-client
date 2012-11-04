#!/bin/sh

# Goes through all jpeg files in current directory, grabs date from each
# and sorts them into subdirectories according to the date
# Creates subdirectories corresponding to the dates as necessary.


exiftool "-Directory<DateTimeOriginal" -d "../thumbs/%Y/" tmp
exiftool "-Directory<FileModifyDate" -d "../thumbs/%Y/" tmp

