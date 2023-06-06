#!/bin/bash

using_if_read ()
{
    local line
    if IFS= read -r line
    then
        using_if_read
        printf '%s\n' "$line"
    fi
}

using_sed() {
sed '1!G;h;$!d' $1
}

using_awk() {
awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }' $1
awk '{for (i = length; i!=0; i--) x=x substr($0, i, 1);}END{print x}' | $1
}

using_loops() {
i=0
while read line[$i] ; do
    i=$(($i+1))
done < $1
for (( i=${#line[@]}-1 ; i>=0 ; i-- )) ; do
    [[ -n "${line[$i]}" ]] && echo ${line[$i]}
done
}


echo -e "\n1] REVERSE PRINTING FILE $1 USING if_read\n"
		cat $1 | using_if_read
echo -e "\n2] REVERSE PRINTING FILE $1 USING sed\n"
		using_sed $1
echo -e "\n3] REVERSE PRINTING FILE $1 USING awk\n" 
		using_awk $1
echo -e "\n4] REVERSE PRINTING FILE $1 USING while & for loop\n" 
		using_loops $1
