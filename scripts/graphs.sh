#!/bin/bash

kind2="$@"

file="../systems/cocospec_comp_system.lus"

nodes=(
  "5>MODE_LOGIC_HeadingMode"
  "5>MODE_LOGIC_AltAndFPAMode"
  "3>MODE_LOGIC"
  "5>LONGITUDINAL_CONTROLLER_AltitudeControl"
  "5>LONGITUDINAL_CONTROLLER_FPAControl"
  "3>LONGITUDINAL_CONTROLLER"
  "2>Mode_plus_Longitudinal"
)

cmd="$kind2 -v --testgen true --testgen_graph_only true --testgen_len"
cmd_main="--lustre_main"

draw_cmd="../scripts/draw.sh"

target="reachable_modes"

mkdir -p $target
cd $target

for pair in ${nodes[@]}; do
  len=`echo "$pair" | sed -e 's:^\([0-9]\)>.*$:\1:'`
  sys=`echo "$pair" | sed -e 's:^[0-9]>\(.*\)$:\1:'`
  echo
  echo "|===| Generating graph for system \"$sys\""
  echo "      Depth = $len"
  echo
  $cmd $len $cmd_main $sys $file
  echo
  $draw_cmd $sys
  echo
done

echo