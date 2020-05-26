#!/bin/bash

function getKerbDate {
kdate=`klist -v | grep -m1 'End time:' | awk '{$1=$2=""; print $0}'`
kdatenorm=`echo $kdate | tr " " :`

fullDate=`echo $kdatenorm | { IFS=: read mo d h m s y && echo "$y-$mo-$d $h:$m:$s";}`

IFS=' '
read -a dateArray <<< "$fullDate"

theDate=`echo ${dateArray[0]}`
theYear=`echo $theDate | awk -F "-" '{print $1}'`
theMonth=`echo $theDate | awk -F "-" '{print $2}'`
theDay=`echo $theDate | awk -F "-" '{print $3}'`
theTime=`echo ${dateArray[1]}`
case $theMonth in
	Jan) theMonth="01" ;;
	Feb) theMonth="02" ;;
	Mar) theMonth="03" ;;
	Apr) theMonth="04" ;;
	May) theMonth="05" ;;
	Jun) theMonth="06" ;;
	Jul) theMonth="07" ;;
	Aug) theMonth="08" ;;
	Sep) theMonth="09" ;;
	Oct) theMonth="10" ;;
	Nov) theMonth="11" ;;
	Dec) theMonth="12" ;;
esac

echo "<result>$theYear-$theMonth-$theDay $theTime</result>"

}

if ! /usr/bin/klist | grep -qs "No credentials cache file found"; then
	getKerbDate
	exit
else
	echo "<result></result>"
fi


