#!/bin/bash

# print out comment line with color
title() {
  # can't be used in osx because of ^^
  echo "$(tput setaf 2)******> ${1^^}$(tput sgr0)"
}

error() {
  >&2 echo "$(tput setaf 1)ERROR > ${1}$(tput sgr0)"
}

info() {
  echo "$(tput setaf 2)------> ${1}$(tput sgr0)"
}

if [ "$DEBUG" = true ] ; then 
  info "Print out each command before execute" 
  set -x 
fi 


