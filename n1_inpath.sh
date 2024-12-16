#!/bin/sh

in_path()
{
  cmd=$1 path=$2 retcal=1
  oldIFS=$IFS IFS=":"
  
  for directory in $path 
  do
	if [ -x $directory/$cmd ] ; then
	  retval=0
	fi
  done
  IFS=$oldIFS
  return $retval
}

checkForCmdInPath(){
  var=$1

  if [ "$var" != "" ] ; then
	if p "${var%${var#?}}" = "/" ]; then
	  if [ ! -x $var ] ; then 
		return 1
	  fi
	elif ! in_path $var $PATH ; then
	  return 2
	fi
  fi
}

if [ $# -ne 1 ] ; then
  echo "Syntaxe $0 commande" >&2 ; exit 1
fi

checkForCmdInPath "$1"

case $? in
  0 ) echo "&1 trouve dans le PATH"				;;
  1 ) echo "&1 pas trouve ou pas executable "   ;;
  2 ) echo "&1 pas trouve dans le PATH			;;
esac

exit 0
