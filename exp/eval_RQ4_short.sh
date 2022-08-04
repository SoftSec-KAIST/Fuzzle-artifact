#!/bin/bash
# NOTE: before running, fix the NUM_WORKERS in 'run_tools.py' to the number of available cores
OUT_PATH=$1
CONFIG_DIR=$(readlink -f $(dirname "$0"))/eval_config
SCRIPT_DIR=$(readlink -f $(dirname "$0")/..)/scripts
cd $SCRIPT_DIR

PARAM="Generator+Size"
DURATION="1"
MODE="paper"

# difficulty
OUT_RQ4=$OUT_PATH/outputs_short/test_difficulty
python3 ./run_tools.py $CONFIG_DIR/test_RQ4_p.conf $OUT_RQ4
./save_results.sh $OUT_RQ4 $OUT_RQ4/difficulty_results $PARAM $DURATION $MODE > $OUT_RQ4/difficulty_summary

echo "Results summary for: test_difficulty"
cat $OUT_RQ4/difficulty_summary
