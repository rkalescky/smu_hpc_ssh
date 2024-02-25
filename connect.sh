#!/bin/sh

v=$1 # verb (test | jump)
h=$2 # host
p=$3 # port

case $v in
  test)
    {
    case `uname -s` in
      Darwin)
        nc -4 -G 1 -w 1 $h $p &> /dev/null
        ;;
      Linux | FreeBSD)
        nc -4 -w 1 $h $p &> /dev/null
        ;;
    esac
    } || {
      exit 1
    }
    ;;
  jump)
    i=`expr \( $RANDOM % 2 \) + 1`
    j=sjump7ap0$i.smu.edu
    ssh -W $h:$p -o HostName=$j hpc_bastion
    ;;
esac

