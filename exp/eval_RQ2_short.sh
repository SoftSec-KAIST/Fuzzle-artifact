#!/bin/bash
# NOTE: before running, fix the NUM_WORKERS in 'run_tools.py' to the number of available cores
OUT_PATH=$1
CONFIG_DIR=$(readlink -f $(dirname "$0"))/eval_config
SCRIPT_DIR=$(readlink -f $(dirname "$0")/..)/scripts
cd $SCRIPT_DIR

DURATION="1"
MODE="paper"

# algo
PARAM="Algorithm"
OUT_ALGO=$OUT_PATH/outputs_short/test_algo
python3 ./run_tools.py $CONFIG_DIR/test_algo_p.conf $OUT_ALGO
./save_results.sh $OUT_ALGO $OUT_ALGO/algo_results $PARAM $DURATION $MODE > $OUT_ALGO/algo_summary

# size
PARAM="Size"
OUT_SIZE=$OUT_PATH/outputs_short/test_size
python3 ./run_tools.py $CONFIG_DIR/test_size_p.conf $OUT_SIZE
./save_results.sh $OUT_SIZE $OUT_SIZE/size_results $PARAM $DURATION $MODE > $OUT_SIZE/size_summary

# cycle
PARAM="Cycle"
OUT_CYCLE=$OUT_PATH/outputs_short/test_cycle
python3 ./run_tools.py $CONFIG_DIR/test_cycle_p.conf $OUT_CYCLE
./save_results.sh $OUT_CYCLE $OUT_CYCLE/cycle_results $PARAM $DURATION $MODE > $OUT_CYCLE/cycle_summary

# smt
PARAM="Generator"
OUT_SMT=$OUT_PATH/outputs_short/test_smt
python3 ./run_tools.py $CONFIG_DIR/test_smt_p.conf $OUT_SMT
./save_results.sh $OUT_SMT $OUT_SMT/smt_results $PARAM $DURATION $MODE > $OUT_SMT/smt_summary

echo "Results summary for: test_algo"
cat $OUT_ALGO/algo_summary
echo "Results summary for: test_size"
cat $OUT_SIZE/size_summary
echo "Results summary for: test_cycle"
cat $OUT_CYCLE/cycle_summary
echo "Results summary for: test_smt"
cat $OUT_SMT/smt_summary
