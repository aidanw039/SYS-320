#!/bin/bash
myIP=$(bash myip.sh)


# Todo-1: Create a helpmenu function that prints help for the script
function displayHelpMenu() {
	echo "Usage: Netowrkchecker.sh [-n nmap][-s ss] [internal/external]"
       	echo "-n: nmap backend"
	echo "	-n external: External NMAP scan" 	
	echo "	-n internal: Internal NMAP scan" 	

       	echo "-s: ss(Netstat) backend"
	echo "	-s external: External ss(Netstat) scan" 	
	echo "	-s internal: Internal ss(Netstat) scan" 	
} 



# Return ports that are serving to the network
function ExternalNmap(){
	  rex=$(nmap "${myIP}" | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
 	  echo "$rex"
  }

  # Return ports that are serving to localhost
  function InternalNmap(){
	    rin=$(nmap localhost | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
            echo "$rin"
    }


# Only IPv4 ports listening from network
function ExternalListeningPorts(){
	
	    # Todo-2: Complete the ExternalListeningPorts that will print the port and application
	    # that is listening on that port from network (using ss utility)
	elpo="$(ss -ltpn4 | awk -F"[[:space:]:(),]+" '!/127.0.0./ { print $5,$9 }' | grep -v "Address")" 
	echo "$elpo"
}


    # Only IPv4 ports listening from localhost
    function InternalListeningPorts(){
	    ilpo=$(ss -ltpn | awk  -F"[[:space:]:(),]+" '/127.0.0./ {print $5,$9}' | tr -d "\"")
    	    echo "$ilpo"
    }
	
    [[ $# -lt 2 ]] && displayHelpMenu

    OPTSSTR=""
    while getopts :ns opt; do 
	    case "${opt}" in
		    n)
			  dest=$2
			  [[ $dest == "external" ]] && echo "$(ExternalNmap)" 
			  [[ $dest == "internal" ]] && echo "$(InternalNmap)"
			  ;; 
		  s)
			  dest=$2
			  [[ $dest == "external" ]] && echo "$(ExternalListeningPorts)" 
			  [[ $dest == "internal" ]] && echo "$(InternalListeningPorts)"
			  ;;
		  :) echo "Error: Option -$OPTARG requires an argument"
			 displayHelpMenu ;;
		 \?) echo "Error: Invalid Option -$OPTARG"
			 displayHelpMenu ;;
		esac
	done
    # Todo-4: Use getopts to accept options -n and -s (both will have an argument)
    # If the argument is not internal or external, call helpmenu
    # If an option other then -n or -s is given, call helpmenu
    # If the options and arguments are given correctly, call corresponding functions
    # For instance: -n internal => will call NMAP on localhost
    #               -s external => will call ss on network (non-local)
