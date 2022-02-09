#!/bin/sh

#################
# Documentation #
#################

# Description
#############

# ppdf - Print PDFs

# Recursively finds pdf files and print them in defined path

# The script should take exactly one argument as a path to destination directory.
# Then the script will find all pdf files in that directory and subdirectories
# and print them.

# License
#########

# The MIT License (MIT)

# Copyright © 2022 <copyright holders>

# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#########################
# Functions definitions #
#########################
function usage {
    # Display help/usage message
    echo "Usage: $(basename $0) [-h] [directory]"
    echo
    echo "Arguments:"
    echo "      directory   path to dir with pdf files"
    echo "Options:"
    echo "      -h  help message"
    exit 1
}

################
# Main Program #
################
if [[ $# -ne 1 ]]; then
echo "$(basename $0): illegal number of arguments"
usage
fi

optstring=":h"

while getopts ${optstring} option; do
   case $option in
        h) # display Help
            usage
            exit 1
            ;;
        ?) # incorrect option
            echo "Invalid option: [-${OPTARG}]"
            usage
            exit 1
            ;;
   esac
done

dirpath=$1

if ! [ -d $dirpath ]; then
printf "[ERROR] $0: $dirpath is not exist or not a directory\n"
exit 1
fi

# just another approach how to handle task
# find $dirpath -iname '*.pdf' | xargs -n 1 echo lp

echo Used printer: [$(lpstat -d | grep -o '[^ ]\+$')];
echo Start printing pdf files

for file in $(find $dirpath -iname '*.pdf'); do
    # sleep is used because of printer. When more tasks are given,
    # the printer lagged. Then the restart is necessary.
    sleep 2;
    echo PRINTING... $file;
    lp $file;
done
