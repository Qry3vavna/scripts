#!/bin/bash
# install Qry3vavna scripts

main() {
  initialize
  parse_args $@
  the_action
}

initialize() {
  version="0.2 install"
  list=(ctime hs pacounts poports rports)
  manf=( $(find . -type f -name "*.man" -exec basename {} \; ) )
  man_loc=$(locate -l1 bash.1.gz)
  man_loc=$(echo ${man_loc%\/*})
  ACTION=
}

parse_args() {
  [[ "$#" == 0 ]] && ACTION=install
  while [ "$1" != "" ]; do
    case $1 in
      -i|-i*|--i*|I*|-I*|--I*|i*) ACTION=install;;
      -u|-u*|--u*|U*|-U*|--U*|u*) ACTION=uninstall;;
      *) usage;exit;;
    esac
    shift
  done
}

the_action() {
  bashrc_check
  vimrc_check
  for tool in ${list[*]};do
    if [[ "$ACTION" == "install" ]];then
      cp ./$tool /usr/local/bin/
      chmod 755 /usr/local/bin/$tool
    else
      rm -f /usr/local/bin/$tool
    fi
  done
  for manfile in ${manf[*]};do
    if [[ "$ACTION" == "install" ]];then
      mfile=${manfile%.*}
      cp $manfile "$man_loc/${mfile}.1"
      gzip "$man_loc/${mfile}.1"
    else
      rm "$man_loc/${mfile}.1"
    fi
  done
}

bashrc_check() {
# Check if scripts aliases are already mentioned,
# if not add them, if so remove them
  if [[ $(grep "Qry3vavna\|debianplus" ~/.bashrc) ]];then # it exists, remove it
    if [[ "$ACTION" == "uninstall" ]];then
      sed -i '/Qry3vavna/d;/debianplus/d' ~/.bashrc
      [[ -e ~/.debianplus ]] && rm -f ~/.debianplus
    fi
  else # nope, go for it
    if [[ "$ACTION" == "install" ]];then
      cp ./debianplus ~/.debianplus
      chmod 600 ~/.debianplus
      echo -e "\n# Qry3vavna: Collection of scripts and aliases to type less and do more.">>~/.bashrc
      echo -e "[[ -e ~/.debianplus ]] && . ~/.debianplus">>~/.bashrc
      . ~/.bashrc # reload bash
    fi
  fi
}

vimrc_check() {
# Check for vimrc and replace if necessary
  if [[ -e ~/.vimrc ]];then # it already exists
    if [[ $(grep -i qry3 ~/.vimrc) ]];then # we're there
      if [[ "$(sha1sum ~/.vimrc|cut -d' ' -f1)" != "$(sha1sum .vimrc|cut -d' ' -f1)" ]];then # not our v0.1 copy :(
        if [[ "$ACTION" == "install" ]];then
          cp ~/.vimrc{,.script} # Archive current
          cp ./.vimrc ~/.vimrc
          chmod 600 ~/.vimrc
        else # uninstall
          if [[ -e ~/.vimrc.script ]];then
            cp ~/.vimrc{.script,} # Reset archive
          else # Try to remove each line... still dirty and leaves stuff behind :(
            while IFS='\n' read line;do
              eval "sed -i '/$line/d' ~/.vimrc"
            done< <(sed -e '/^$/d;s/\*.*//;s/\/.*//;s/"//;s/<.*//;s/".*//' .vimrc)
          fi
        fi
      else # it's only our copy, whack it
        if [[ "$ACTION" == "uninstall" ]];then
          rm -f ~/.vimrc
        fi
      fi
    else # exists, we're not in there
      if [[ "$ACTION" == "install" ]];then
        cat ./.vimrc >> ~/.vimrc
      fi
    fi
  else # doesn't even exist
    if [[ "$ACTION" == "install" ]];then
      cp ./.vimrc ~/.vimrc
      chmod 600 ~/.vimrc
    fi
  fi
}

usage() {
  cat << EOF

$0 $version

USAGE: $0 [OPTIONS] file

      -i|--install  		Installs the scripts into /usr/local/bin
				Updates ~/.bashrc including our aliases

      -u|--uninstall		Will remove the scripts from /usr/local/bin
				Will remove the entry in ~/.bashrc

      -h|--help			This cruft

# v0.2 :: updated man portion to auto-ish find the right place
# v0.1 :: initial go at it
EOF
}

#=-+-=#
main $@
