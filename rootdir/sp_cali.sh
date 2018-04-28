#!/vendor/bin/sh

#########################################################################
# E7, smartpa calibration
#########################################################################

#fist:init
caliFile="/persist/tas2557_cal.txt"
echo "delete /persist/tas2557_cal.txt"
rm $caliFile
setprop sys.spcali.pass 0
setprop sys.spcali.data 0 
#enable smartpa
tinymix "Program" 0
#smartpa calibration
factorytest -t 25 -c /vendor/etc/tas2557evm.ftcfg -v -u

#third:
num=0
while [[ $num -lt 8 ]]
do
if [ -a "$caliFile" ]; then
echo "generate tas2557_cal.txt"
break
fi
let "num++"
sleep 1
done

sleep 1
if [ -a "$caliFile" ]; then
result=`cat $caliFile | grep "Result = 0x0"`
data=`cat $caliFile | grep "DevA Re"`
echo "data: $data"
    if [ "$result" ]; then
        echo "set cali data into driver"
        tinymix "Calibration" 255
        echo "smartpa cali pass"
        setprop sys.spcali.data "$data"
        setprop sys.spcali.pass 1
    else
        echo "smartpa cali fail"
        setprop sys.spcali.data "$data"
        setprop sys.spcali.pass 2
    fi
else
echo "no tas2557_cal.txt!"
setprop sys.spcali.pass 2
setprop sys.spcali.data 0
fi

