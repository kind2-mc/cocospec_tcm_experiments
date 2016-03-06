all: help

help:
	less README.md

graphs-osx:
	./scripts/graphs.sh "./kind2/kind2-osx ${args}"

graphs-linux:
	./scripts/graphs.sh "./kind2/kind2-linux ${args}"

verif-osx:
	./kind2/kind2-osx --compositional on --modular on --check_sat_assume off ${args} systems/cocospec_comp_system.lus

verif-linux:
	./kind2/kind2-linux --compositional on --modular on --smt_check_sat_assume off ${args} systems/cocospec_comp_system.lus

monolithic-osx:
	./kind2/kind2-osx --compositional on --timeout 600 ${args} systems/cocospec_mono_system.lus

monolithic-linux:
	./kind2/kind2-linux --compositional on --timeout 600 ${args} systems/cocospec_mono_system.lus