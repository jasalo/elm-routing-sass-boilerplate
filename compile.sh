#!/bin/bash

usage() { echo "Usage: $0 [-p <port>] <main-elm-file.elm>" 1>&2; exit 1; }

port="1234"

while getopts ":p:" opt; do
        case ${opt} in
                -p)
                    port="$OPTARG"
                    echo "setting port to ${port}"
                    ;;
                \?)
                    usage
                    ;;
                :)
                    usage
                    ;;
        esac
done
shift $((OPTIND-1))

main_file=$1

if [ "${main_file}" == "" ]
then
   # usage
   main_file="Main.elm"
fi

# Checks if the port is available

pid_port=`lsof -Pi :${port} -sTCP:LISTEN -t`
if [ "${pid_port}" != "" ]
then
   echo "The process ${pid_port} is running on ${port}"
   exit 1
fi

# Clean background process on exit
trap 'kill $(jobs -p)' EXIT

echo "Initializing Http server on port ${port}"
python -m SimpleHTTPServer ${port} &
# takes the process id of http server
http_pid=$!

# Output files
jsFile="js/dist/${main_file%.*}.js"
cssFile="css/dist/main.css"

# Colors
green="$(tput setaf 10)"
yellow="$(tput setaf 11)"
cyan="$(tput setaf 14)"
white="$(tput setaf 7)"
gray="$(tput setaf 8)"
red="$(tput setaf 9)"
magenta="$(tput setaf 5)"
purple="$(tput setaf 4)"

while true
do
  # Sass files check
  changesSass=`find styles -name "*.sass" ! -path "*/\.*" -a -newer "${cssFile}" | wc -l | sed -e 's/^[ \t]*//'`
  if [[ ${changesSass} > 0 ]] 
    then
    echo -e "${cyan}--------------------------------------------"
    echo -e "${cyan}-------------- COMPILING SASS --------------"
    echo -e "${cyan}------ " `date` " ------"
    echo
    node-sass -o css/dist --output-style compressed styles/main.sass
    resultSass=$?
    echo
    if [[ ${resultSass} == 0 ]]
      then
      echo -e "${green}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ OK :)"
    fi
    echo -e "$(tput sgr0)"
    touch ${cssFile}
  fi

  # Elm files check
  changes=`find . -name "*.elm" ! -path "*/\.*" ! -path "./elm-stuff/*" -a -newer "${jsFile}" | wc -l | sed -e 's/^[ \t]*//'`
  pkg_updated=`find . -wholename ./elm-package.json -a -newer ${jsFile}`
  if [[ $? != 0 || ${changes} > 0 || ${pkg_updated} != "" ]] 
    then
    echo -e "${yellow}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo -e "${yellow}~~~~~~~~~~~~~~~ COMPILING ELM ~~~~~~~~~~~~~~~~"
    echo -e "${yellow}~~~~~~~ " `date` " ~~~~~~~"
    echo -e "$(tput sgr0)"
    elm-make "src/${main_file}" --output=${jsFile}
    result=$?
    echo
    if [[ ${result} > 0 ]]
      then
      echo -e "${red}^^^^^^^^^^^^^^^^^^^^ ERROR! ^^^^^^^^^^^^^^^^^^^^"
      echo -e "${red}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    else
      echo -e "${green}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ OK :)"
    fi
    echo -e "$(tput sgr0)"
    touch ${jsFile}
  fi
done

# i="0"

# while [ $i -lt 4 ]
# do
# xterm &
# i=$[$i+1]
# done
