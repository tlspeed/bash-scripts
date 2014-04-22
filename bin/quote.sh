#!/bin/bash

#
# quote.sh - Why not be witty? ;)
#
# 2008 - Mike Golvach - eggi@comcast.net
#
# Creative Commons Attribution-Noncommercial-Share Alike 3.0 United States License
#

if [ $# -lt 1 ]
then
        echo "Usage: $0 Your Word(s) To Find A Quote"
        echo "May be two or more words separated by spaces"
        echo  "but only one definition per execution."
        echo "Ex: $0 money"
        echo "Ex: $0 love of money"
        exit 1
fi

args="$@"
wget=/usr/bin/wget

if [ $# -gt 1 ]
then
        args=`echo $args|sed 's/ /\+/g'`
fi

echo

$wget -nv -O - "http://www.quotationspage.com/search.php3?Search=$args&startsearch=Search&Author=&C=mgm&C=motivate&C=classic&C=coles&C=poorc&C=lindsly&C=net&C=devils&C=contrib"  2>&1|grep -i "No quotations found" >/dev/null 2>&1

anygood=$?

if [ $anygood -eq 0 ]
then
        args=`echo $args|sed 's/%20/\+/g'`
        echo "No results found for $args"
        exit 2
fi

$wget -nv -O - "http://www.quotationspage.com/search.php3?Search=$args&startsearch=Search&Author=&C=mgm&C=motivate&C=classic&C=coles&C=poorc&C=lindsly&C=net&C=devils&C=contrib" 2>&1|sed -e :a -e 's/<[^>]*>/ /g;/</N;//ba' -e 's/$/\n/'|sed -e '1,/Results from/d' -e '/Results of search for */,$d'|sed 's/^[ \t]*//;s/[ \t]*$//'|sed '/^$/N;/\n$/D'|sed '/Pages: /,$d'|sed '/Results from/,$d'|sed 's/^ *//;s/ *$//;s/ \{1,\}/ /g'|sed 's/More quotations on: .*$//'

exit 0
