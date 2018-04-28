#!/vendor/bin/sh

#########################################################################
# E7, smartpa test
#########################################################################

#calibration configuration
setprop sys.spcali.test 0 
tinymix "Configuration" 2
sleep 6
test=`factorytest -t 25 -c /vendor/etc/tas2557evm.ftcfg  -m | grep "SPK Re"`

echo $test > /persist/smartpa_test.txt
setprop sys.spcali.test "$test" 
 
tinymix "Configuration" 0
