#!/bin/bash 

main() {
  initialize
  parse_args $@
  the_setup
  ctime_it
}

initialize() {
  version="0.1 ctime-mod"
  set_to=""
}

parse_args() {
  while [ "$1" != "" ]; do
    case $1 in
      -c|--ctime) shift;set_to="$1";;
      -a|--atime) set_to="atime";;
      -m|--mtime) set_to="mtime";;
      -h|--help) usage;exit;;
      *) FILE="$1";;
    esac
    shift
  done
}

the_setup() {
  if [ -e "$FILE" ];then
    file_perm="$(stat -c %a $FILE)"
    case $set_to in
      atime) new_time="$(stat -c %x $FILE)";;
      mtime) new_time="$(stat -c %y $FILE)";;
      *) new_time="$set_to";;
    esac      
    if [[ -z "$new_time" ]];then
      # Default to mtime, if no other time found
      new_time="$(stat -c %y $FILE)"
    fi
  else
    echo -e "ERROR: File $FILE does not seem to exist"
    exit 1
  fi
}

ctime_it() {
  now="$(date)" 
  date --set="$new_time"
  chmod $file_perm $FILE
  date --set="$now"
}

usage() {
  cat << EOF

$0 $version

USAGE: $0 [OPTIONS] file

      -c|--ctime  <DATE>	Set the time to a custom date
				See the 'date' command for an example
      -a|--atime		Will set the ctime to the current atime
      -m|--mtime		Will set the ctime to the current mtime
      -h|--help			This cruft

EOF
}

#=-+-=#
main $@