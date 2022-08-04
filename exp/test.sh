#!/bin/bash
# NOTE: before running, fix the NUM_WORKERS in 'run_tools.py' to the number of available cores
OUT_PATH=$1
CONFIG_DIR=$(readlink -f $(dirname "$0"))/eval_config
SCRIPT_DIR=$(readlink -f $(dirname "$0")/..)/scripts
cd $SCRIPT_DIR

# generate benchmark (3 programs in total)
python3 ./generate_benchmark.py $CONFIG_DIR/test.list ./test_benchmark

# run fuzzers (AFL and AFL++ for 1 hour each)
OUT_TEST=$OUT_PATH/outputs/test
python3 ./run_tools.py $CONFIG_DIR/test.conf $OUT_TEST

# store and print results (coverage report in 'test_results.csv')
PARAM="ALL"
DURATION="1"
MODE="paper"
./save_results.sh $OUT_TEST $OUT_TEST/test_results $PARAM $DURATION $MODE > $OUT_TEST/test_summary

# visualize coverage (same maze as Figure 5.c in the paper but coverage is from 1 hour of fuzzing)
PATH_TO_TXT="./test_benchmark/txt/Sidewinder_20x20_5_1.txt"
PATH_TO_COV=$OUT_TEST/cov_gcov_Sidewinder_20x20_5_1_25percent_CVE-2016-4491_gen_afl_0/Sidewinder_20x20_5_1_25percent_CVE-2016-4491_gen_afl_0_1hr.c.gcov
python3 ./visualize.py $PATH_TO_TXT $PATH_TO_COV $OUT_TEST/sidewinder 20

echo "Results summary for: test.sh"
cat $OUT_TEST/test_summary
