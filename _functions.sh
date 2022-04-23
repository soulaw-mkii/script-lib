#!/bin/bash

log_msg () {
  echo -e "\n\n[`date "+%Y/%m/%d %H:%M:%S"`] $1\n"
}

lower() {
  echo $host | tr [:upper:] [:lower:]
}

upper() {
  echo $host | tr [:lower:] [:upper:]
}

title() {
  sed 's/.*/\L&/; s/[a-z]*/\u&/g' <<<"$1"    
}