#! /bin/sh
myvar="Hi Woo"
echo $myvar
echo "$myvar"
echo '$myvar'
echo \$myvar
echo insert value: 
read myvar
echo '$myvar' = $myvar
exit 0
