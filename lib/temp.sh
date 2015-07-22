#!/bin/bash

for i in `ls`
do
if [[ $i =~ \.ex~$ ]]
then
rm -f $i
fi
done
