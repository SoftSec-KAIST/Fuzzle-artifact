#!/bin/bash
# NOTE: before running, fix the NUM_WORKERS in 'run_tools.py' to the number of available cores
OUT_PATH=$1
CONFIG_DIR=$(readlink -f $(dirname "$0"))/eval_config
SCRIPT_DIR=$(readlink -f $(dirname "$0")/..)/scripts
cd $SCRIPT_DIR

DURATION="24"
MODE="paper"

# binutils v2.26
OUT_BIN=$OUT_PATH/outputs/test_binutils
python3 ./run_tools_binutils.py $CONFIG_DIR/test_binutils.conf $OUT_BIN

# triage
cd ./triage
mkdir -p $OUT_BIN/triage
for run in $OUT_BIN/cxxfilt/*-*
do
	OUT=`basename $run`
	./triage.sh $run/outputs ./cxxfilt $OUT_BIN/triage/$OUT > /dev/null 2>&1
done
ls $OUT_BIN/triage > $OUT_BIN/crashes_list
python3 save_TTE.py $OUT_BIN/crashes_list $OUT_BIN/triage hash_triage $OUT_BIN/binutils_results.csv
python3 print_TTE.py $OUT_BIN/binutils_results.csv > $OUT_BIN/binutils_summary

cd $SCRIPT_DIR

# Fuzzle-generated benchmark
PARAM="Generator"
OUT_FUZZLE=$OUT_PATH/outputs/test_fuzzle
python3 ./run_tools.py $CONFIG_DIR/test_fuzzle.conf $OUT_FUZZLE
./save_results.sh $OUT_FUZZLE $OUT_FUZZLE/fuzzle_results $PARAM $DURATION $MODE > $OUT_FUZZLE/fuzzle_summary

echo "Results summary for: test_binutils (TTE (h))"
cat $OUT_BIN/binutils_summary
echo "Results summary for: test_fuzzle"
cat $OUT_FUZZLE/fuzzle_summary
