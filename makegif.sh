#!/bin/sh
#set -x
name=
if [ ! -n "$1" ];then
    name=out.gif;
else
    name=$1.gif
fi

width=1080;
hight=1920;
#获取坐标信息
info=`xdotool getmouselocation`
x=0
y=0
if [ $? -ne 0 ];then
    echo  "please install xdotool";
    exit 1;
fi
IFS="$IFS"
IFS=' '
set -- $(echo $info  |awk -F"[: ]" '{print $2" "$4}')
IFS="$OIFS"
#获取坐标
x=$1
y=$2
#echo $x
#echo $y
#echo $name
function error_exit
{
        echo "$1" 1>&2
        exit 1
}
#检查命令
command -v byzanz-record >/dev/null||error_exit "please install byzanz-record";
byzanz-record -d 10 --delay 5 -c -x $x -y $y -w $width -h $hight ./$name&&echo "finish :record"
