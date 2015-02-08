#poports
=======
<pre>
                              _
 _ __   ___  _ __   ___  _ __| |_ ___ 
| '_ \ / _ \| '_ \ / _ \| '__| __/ __|
| |_) | (_) | |_) | (_) | |  | |_\__ \
| .__/ \___/| .__/ \___/|_|   \__|___/
|_|         |_|

v0.1 SEP2014 ::Qry3v@vna~*
</pre>
Tool to print out top ports from nmap services list

###USAGE:
`./poports.sh <options>`

###OPTIONS:
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
                                  file name is port.$protocol.$port_number
        -o --out <dir>          Directory you want the above port file to drop
                                  default="." aka wherever you run this
        -v --verbose            Displays more stuff to stdout
        -V --version            Prints version and exits
        -h --help ?             This cruft...

###EXAMPLES:

`./poports.sh -p sctp -n 25`
>Grabs the top 25 sctp ports & prints them to stdout

`./poports.sh --num 5000 -g /root/customer/scans/all.gnmap --out ../ports/`
>Selects the top 5000 ports of all protocols and searches for each
  within the all.gnmap scan results file, creating an output file
  for each port found in the ../ports directory containing matching IPs

`./poports.sh -d ,`
>Grabs the top 100 ports of all protocols and prints them to stdout
    using a ',' as delimiter between service,port,protocol
