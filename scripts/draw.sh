#!/bin/bash

dir=$1
dot_file=$1/unit.dot
options="-Gconcentrate=true -Gsplines=true -Goverlap=false -Granksep=3 -Tpdf -o"

function run_for_cmd {
  echo "|===| Running $1 on $dot_file"
  echo
  eval "$1 $options $dir/$1.pdf $dot_file"
}

echo
echo

run_for_cmd "dot"
run_for_cmd "neato"
run_for_cmd "twopi"
run_for_cmd "sfdp"
run_for_cmd "circo"

echo
echo