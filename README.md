# scripts
=======
A collection of scripts used to embetter Linux, <br>
specifically used on Kali Linux.<br>
Use install.sh to install these in /usr/local/bin/<br>
<hr>
##ctime
<pre>
                              _
       _   _                
      | | (_)               
   ___| |_ _ _ __ ___   ___ 
  / __| __| | '_ ` _ \ / _ \
 | (__| |_| | | | | | |  __/
  \___|\__|_|_| |_| |_|\___|
                            
                            
v0.1 SEP2014 ::Qry3v@vna~*
</pre>
Tool used to time-stomp the ctime of file in Unix by temporarily resetting the system time<br/>
Yes it's messy, you don't have to use it, it's just one way to do things...<br/>

./ctime.sh 0.1 ctime-mod

###USAGE: ./ctime.sh [OPTIONS] file

      -c|--ctime  <DATE>        Set the time to a custom date
                                See the 'date' command for an example
      -a|--atime               Will set the ctime to the current atime
      -m|--mtime                Will set the ctime to the current mtime
      -h|--help                 This cruft
