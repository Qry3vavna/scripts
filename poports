#!/bin/bash
# Print popular ports from nmap
# Requires nmap-services file

main() {
    initialize
    parse_input $*
    logic
}

initialize() {
    version='v0.1 SEP2014 ::Qry3v@vna~*'
    src="/usr/share/nmap/nmap-services" # Default location of Debian OS for nmap file
    f_check nmap-services $src
    verbose=0
    protocol="/"
    number="100"
    delim=":"
    out="."
    for dependency in awk sed grep sort head openssl;do
        f_check $dependency $(which $dependency)
    done
}

parse_input() {
    # Parse each argument given until there are no more arguments
    while [ $# -ge 1 ]; do
        case "$1" in
            -p*|--p*)
                protocol="$2"
                v_echo "[*] protocol selected: $2"
                shift
                ;;
            -n*|--n*)
                number="$2"
                v_echo "[*] count selected: $2"
                shift
                ;;
            -d*|--d*)
                delim="$2"
                v_echo "[*] delimiter selected: $2"
                shift
                ;;
            -g*|--g*)
                gnmap="$2"
                v_echo "[*] gnmap file selected: $2"
                shift
                ;;
            -o*|--o*)
                out="$2"
                v_echo "[*] output directory selected: $2"
                shift
                ;;
            -v|--v|--verb*|-verb*)
                ((verbose++))
                v_echo "[*] verbosity selected: $verbose"
                ;;
            -V*|--V*|--vers*)
                echo "$0 $version"
                exit 0
                ;;
            -h*|--h*|?)
                usage
                ;;
        esac
        shift
    done
}

f_check() {
    # Check given file
    v_echo "[*] f_check args: $1, $2"
    if [ ! -e "$2" ];then
        echo "ERROR: $1 does not exist, check yourself."
        exit 2
    fi
}

logic() {
    # If a gnmap file is given to search through,
    # then check if the file exists and go to parse the file
    # which will grab the ports automatically
    # Otherwise just print the ports to the screen
    if [ -z $gnmap ];then
        grab_it
    else
        f_check gnmap-file $gnmap
        parse_gnmap
    fi
}

usage() {
    # The help page
    logo
cat << EOF

$version

Tool to print out top ports from nmap services list

USAGE: $0 <options>

OPTIONS:
        -p --proto <proto>      Filter by protocol, aka: tcp,udp,sctp
                                  default="all"
        -n --num   <#>          Number of results
                                  default=100
        -d --delim <delimiter>  Set a delimiter between service,port,protocol
                                  default=":"
        -g --gnmap <file>       Path of nmap gnmap scan results file
                                  This will be used to find top ports and
                                  create a file for each port found,
                                  listing each IP from the scan
                                  file name is port.\$protocol.\$port_number
        -o --out <dir>          Directory you want the above port file to drop
                                  default="." aka wherever you run this
        -v --verbose            Displays more stuff to stdout
        -V --version            Prints version and exits
        -h --help ?             This cruft...

EXAMPLES:
    $0 -p sctp -n 25
    Grabs the top 25 sctp ports & prints them to stdout

    $0 --num 5000 -g /root/customer/scans/all.gnmap --out ../ports/
    Selects the top 5000 ports of all protocols and searches for each
      within the all.gnmap scan results file, creating an output file
      for each port found in the ../ports directory containing matching IPs

    $0 -d ,
    Grabs the top 100 ports of all protocols and prints them to stdout
      using a ',' as delimiter between service,port,protocol


LICENSE:
    Apache 2.0 :
      Required:		- Include license and copyright notice
			- State any changes made from this code

      Permitted:	- Use commercially	- Grant patents
			- Ditribute		- Use privately
			- Modify		- Sublicense

      Forbidden:	- Hold us liable
			- Use trademark
EOF
exit 0
}

grab_it() {
    # Delete lines starting with a comment
    # Sort on the 3rd column (rate of popularity) in reverse order
    # Pull out selected protocol & show the number of selected results
    # Print service, port & protocol with specified delimiter inbetween
    sed '/^#/d;' $src|sort -k3 -r|grep "$protocol"|head -$number|\
      eval "awk '{split (\$2,p,\"/\");print \$1\"$delim\"p[1]\"$delim\"p[2]}'"
}

parse_gnmap() {
    # Get the results of a port filter selection and run it through a while
    # read
    # For each match returned, check the results of the given nmap scan
    # Then print the IP of that port to a file named port.protocol.port_number
    grab_it|while IFS="$delim" read p_service p_port p_protocol;do
        v_echo "n: Checking for $p_port in $gnamp"
        if [[ $(eval "grep -P '\s{1}$p_port\/[a-z]+\/$p_protocol\/' $gnmap") ]];then
            eval "awk '/ $p_port/{print \$2}' $gnmap > $out/port.$p_protocol.$p_port"
        fi
    done
}

v_echo() {
    # Extra extra read all about it
    if [[ "$verbose" -gt 0 ]];then
        echo "$*"
    fi
}

logo() {
    echo -e "
    ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXwogXyBfXyAgIF9fXyAgXyBf
    XyAgIF9fXyAgXyBfX3wgfF8gX19fIAp8ICdfIFwgLyBfIFx8ICdfIFwgLyBfIFx8
    ICdfX3wgX18vIF9ffAp8IHxfKSB8IChfKSB8IHxfKSB8IChfKSB8IHwgIHwgfF9c
    X18gXAp8IC5fXy8gXF9fXy98IC5fXy8gXF9fXy98X3wgICBcX198X19fLwp8X3wg
    ICAgICAgICB8X3wK"|openssl enc -a -d
}

# DO IT
#=---=#
main $*
