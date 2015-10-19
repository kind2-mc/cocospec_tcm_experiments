# TCM experiments

## Systems and graphs

This readme should come with the following folders and files:

* `graphs`: contains the graphs of reachable modes for the main components in
  different folders under `./reachable_modes/`. Several graphs are provided for
  each component, the most readable being usually `dot.pdf`.

* `kind2`: Kind 2 binaries for linux and OSX.

* `scripts`: scripts used by the `Makefile`.

* `systems`: contains the TCM lustre files:

  * `helpers.lus`: nodes used for the specification of the system, and the
    abstraction of its non-linear expressions.

  * `original_system.lus`: the TCM system as we got them from the Simulink to
    Lustre translator.

  * `cocospec_comp_system.lus`: the TCM system fully specified in cocospec.

  * `cocospec_mono_system.lus`: the TCM system with only the top node specified
    and the non-linear expressions wrapped in contract-equipped nodes.


## Kind 2 repository

The implementation reported in the paper is in the `contracts-and-arrays`
branch of the Kind 2 official repository:

[https://github.com/kind2-mc/kind2/tree/contracts-and-arrays][kind2]


## Makefile commands

**N.B.** the make commands will only work on Linux or OSX.

* `graphs-osx`/`graphs-linux`: generates the graph of reachable modes for the
  systems in `cocospec_comp_system.lus`. Requires Kind 2 and standard graphviz
  commands.

* `verif-osx`/`verif-linux`: runs Kind 2 on `cocospec_comp_system.lus` in
  modular/compositional mode. Expected runtime is less than 500 seconds on a
  *recent machine*.

* `monolithic-osx`/`monolithic-linux`: runs Kind 2 on
  `cocospec_mono_system.lus` in compositional mode with a timeout of 600
  seconds.

You can pass custom options to Kind 2:

```
make args="<options>" <cmd>
# For instance, run "verif-osx" with verbose.
make args="-v" verif-osx
```


## Kind 2 arguments

To run your own experiments, generate your own graphs, or customize the run
commands, the relevant Kind 2 options are

* `--lustre_main <node_id>` to analyze node `<node_id>`. Otherwise, the last
  node is analyzed.

* `-v` verbose output.

* `--smtsolver [Z3|CVC4]` which solver to use.

* `--z3_bin <z3_cmd>`, `--cvc4_bin <cvc4_cmd>` the command to call the actual
  solver.

* `--timeout <int>` specifies a timeout in seconds.

* For verification:

  * `--compositional true` to activate the abstraction-by-contract mechanism.

  * `--modular true` to analyze all nodes of the system bottom-up.
    Beware that will also analyze the non-linear nodes in the systems provided.
    It is recommended to use `--smt_check_sat_assume false` to deactivate the
    use of a feature in the SMT solver that is known to perform poorly on
    non-linear problems.

* For graph generation:

  * `--testgen true` to run test generation, the feature that generates the
    graph of reachable modes.

  * `--testgen_graph_only true` to prevent Kind 2 for logging the witnesses for
    each mode path.

  * `--testgen_len <int>` to generate the graph up to depth `<int>`.

  * A `unit.dot` file will be generated in a folder named after the node's
    identifier `<node_id>`. You can use `./scripts/draw.sh` to generate the
    graphs in PDF format by giving it the path to the `<node_id>` folder. For
    instance `./scripts/draw.sh my_graphs/MODE_LOGIC`.



[kind2]: https://github.com/kind2-mc/kind2/tree/contracts-and-arrays (Kind 2 contracts-and-array branch)

