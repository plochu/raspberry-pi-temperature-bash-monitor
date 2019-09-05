#!/bin/bash

function convert_to_integer {
  echo "$@" | awk -F "," '{ printf("%03d%03d%03d\n", $1,$2,$3); }';
}

RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

  tempMAX=$(vcgencmd measure_temp | egrep -o '[0-9]*\.[0-9]*')
  tempMIN=$(vcgencmd measure_temp | egrep -o '[0-9]*\.[0-9]*')

while true
do
  temp=$(vcgencmd measure_temp | egrep -o '[0-9]*\.[0-9]*')

  if [ "$(convert_to_integer $temp)" -gt "$(convert_to_integer $tempMAX)" ]
  then
    tempMAX=$temp
    echo -e "${RED}New MAX temperature is $tempMAX${NC}"
  fi

  if [ "$(convert_to_integer $temp)" -lt "$(convert_to_integer $tempMIN)" ]
  then
    tempMIN=$temp
    echo -e "${BLUE}New MIN temperature is $tempMIN${NC}"
  fi

  echo -e "${GREEN}The temperature is ${YELLOW}$temp ${GREEN}degrees celcius. Lowest was ${YELLOW}$tempMIN ${GREEN}and highest was ${YELLOW}$tempMAX${GREEN}.${NC}"
  sleep 2
done
