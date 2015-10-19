all: help

help:
	less README.md

graphs-osx:
	./scripts/graphs.sh "./kind2/kind2-osx ${args}"

graphs-linux:
	./scripts/graphs.sh "./kind2/kind2-linux ${args}"

verif-osx:
	./kind2/kind2-osx --compositional true --modular true --smt_check_sat_assume false ${args} systems/cocospec_comp_system.lus

verif-linux:
	./kind2/kind2-linux --compositional true --modular true --smt_check_sat_assume false ${args} systems/cocospec_comp_system.lus

monolithic-osx:
	./kind2/kind2-osx --compositional true --timeout 600 ${args} systems/cocospec_mono_system.lus

monolithic-linux:
	./kind2/kind2-linux --compositional true --timeout 600 ${args} systems/cocospec_mono_system.lus