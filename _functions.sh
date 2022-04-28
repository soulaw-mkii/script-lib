#!/bin/bash

init_env() {
  echo `basename "$0"`
  IFS='._ ' read -ra arr <<< `basename "$0"`
  export ENV="${arr[1]}"
  export NAMESPACE="${arr[2]}"
  export K8S_CONTEXT="${ENV}-${NAMESPACE}"
}

init_k8s_ctx() {
  log_msg "Switch to $K8S_CONTEXT..."
  kubectl config use-context $K8S_CONTEXT

  log_msg "Create namespace $NAMESPACE if not exist..."
  kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -
}

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