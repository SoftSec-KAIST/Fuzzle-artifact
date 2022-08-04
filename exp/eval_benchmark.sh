#!/bin/bash
OUT_PATH=$1
SCRIPT_DIR=$(readlink -f $(dirname "$0")/..)/scripts
CVE_DIR=$(readlink -f $(dirname "$0")/..)/CVEs
cd $SCRIPT_DIR

SEEDS="1 3 5 7 9"

# Varying algorithms
BENCH_DIR=$OUT_PATH/algo
ALGOS="Backtracking Kruskal Prims Sidewinder Wilsons"
SIZE=30
CYCLE=25
for ALGO in $ALGOS
do
  for SEED in $SEEDS
  do
    ./generate.sh -o $BENCH_DIR -a $ALGO -w $SIZE -h $SIZE -r $SEED -n 1 -c $CYCLE -g default_gen
  done
done

# Varying size
BENCH_DIR=$OUT_PATH/size
ALGO=Wilsons
SIZES="20 30 40 50"
CYCLE=25
for SIZE in $SIZES
do
  for SEED in $SEEDS
  do
    ./generate.sh -o $BENCH_DIR -a $ALGO -w $SIZE -h $SIZE -r $SEED -n 1 -c $CYCLE -g default_gen
  done
done

# Varying cycle
BENCH_DIR=$OUT_PATH/cycle
ALGO=Wilsons
SIZE=30
CYCLES="0 25 50 75 100"
for CYCLE in $CYCLES
do
  for SEED in $SEEDS
  do
    ./generate.sh -o $BENCH_DIR -a $ALGO -w $SIZE -h $SIZE -r $SEED -n 1 -c $CYCLE -g default_gen
  done
done

# Varying CVE
BENCH_DIR=$OUT_PATH/SMT
ALGO=Wilsons
SIZE=30
CYCLE=25
CVES="CVE-2016-4487.smt2 CVE-2016-4489.smt2 CVE-2016-4491.smt2 CVE-2016-4492.smt2 CVE-2016-4493.smt2 CVE-2016-6131.smt2"
for CVE in $CVES
do
  for SEED in $SEEDS
  do
    ./generate.sh -o $BENCH_DIR -a $ALGO -w $SIZE -h $SIZE -r $SEED -n 1 -c $CYCLE -g CVE_gen -s $CVE_DIR/$CVE
  done
done
