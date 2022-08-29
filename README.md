# Fuzzle Artifact

[Fuzzle](https://github.com/SoftSec-KAIST/Fuzzle) is a bug synthesizer that
generates buggy benchmarks for evaluating fuzzers. This repository contains
artifacts for the experiments in our paper in ASE 2022, "Fuzzle: Making a Puzzle
for Fuzzers."

## Setup

From the `exp` directory, run `eval_setup.sh` script to build docker images and
set up python environments. The script may take up to a few hours to complete.

Note that you need python 3.7+ and z3 solver to generate benchmark programs
using Fuzzle.

## Replicating experiments in the paper

### Evaluation of benchmark generation

To generate the benchmark that is of the same configuration as the benchmark
used in the paper (described in Section 5.2), run `eval_benchmark.sh`.

```
$ ./exp/eval_benchmark.sh <OUT_DIR>
```

The above command will take approximately 10-20 minutes to finish. Once the
script has finished running, the generated programs will be stored in the
specified directory. In the output directory, there will be a subdirectory for
each parameter (algorithm, cycle, size, and generator) which will contain 5
subdirectories as follows:

- `src`: contains C source code of generated programs
- `bin`: contains compiled binaries of generated programs
- `txt`: contains array form of mazes used in generating programs
- `png`: contains images (.png files) of mazes used in generating programs
- `sln`: contains shortest solution path for each maze

### Comparing fuzzers on Fuzzle-generated benchmark

To replicate experiment for each RQ# in the paper, run `eval_RQ#.sh`.

```
$ ./exp/eval_RQ#.sh <OUT_DIR>
```

Time required for each RQ: (full version)

| RQ #     |  CPU hours |
| -------- |:----------:|
| RQ2      |    60,000  |
| RQ3      |    24,000  |
| RQ4      |    27,000  |
| RQ5      |    16,800  |
| RQ6      |        72  |

Each fuzzing experiment will be run in an isolated docker container each
assigned with one CPU core. In our evaluation, the experiments were conducted on
servers of the specification: 88 Intel Xeon E5-2699 v4 CPU cores with 2.20 GHz
and 128 GB of memory.

Note that you should fix the value of `NUM_WORKERS` in `run_tools.py` and
`run_tools_binutils.py` to the number of availalbe CPU cores before running the
experiments. Currently, it is set to 1 to use only one CPU core at a time.

Also, the default memory limit given to each docker container is 8GB. To change
the memory limit given to each fuzzing instance, you can modify -m option in
`run_tools.py`.

In the specified output directory, following will be stored after the command
has finished executing:

- fuzzing output (generated testcases)
- coverage and bug finding results for each fuzzing run (.csv file)
- summary report

The summary report will be displayed at the end of the experiment, showing the
average branch coverage ('Coverage'), average percentage of bugs found ('Bugs'),
and average time to expose bugs ('TTE').

For each RQ#, a script for shorter version of evaluation is also available as
`eval_RQ#_short.sh`.

Time required for each RQ: (short version)

| RQ #     |  CPU hours |
| -------- |:----------:|
| RQ2      |     1,200  |
| RQ3      |       480  |
| RQ4      |       540  |
| RQ5      |       336  |
| RQ6      |        18  |

Note that in the shorter evaluation, only 1 seed, 2 repeats per seed, and 6
hours per run were used instead of 5 seeds, 5 repeats per seed, and 24 hours per
run of the original experiment settings.

### Evaluation of overall workflow

A script `test.sh` can be used to quickly test each feature of Fuzzle: (1)
generating maze-based benchmark, (2) running fuzzers, and (3) storing and
visualizing results. The experiment takes total of 6.5 hours to run on a
single-core CPU.

Similar to running `eval_RQ#.sh` scripts, you need to provide the output path:

```
$ ./exp/test.sh <OUT_PATH>
```
The above command will generate a test benchmark consisting of 3 programs and
will run 2 fuzzers (afl and afl++) on the generated programs. The png file
generated using visualization feature will be the same as Figure 5.c in the
paper but with code coverage results from 1 hour of fuzzing instead of 24
hours.

## Dataset

The benchmark used in the paper is in `eval_mazes` directory and the raw data
obtained from fuzzing experiments can be downloaded from
[Fuzzle-dataset](https://doi.org/10.5281/zenodo.6520108).
