#!/bin/bash
# NOTE: before running, fix the NUM_WORKERS in 'run_tools.py' to the number of available cores
OUT_PATH=$1
CONFIG_DIR=$(readlink -f $(dirname "$0"))/eval_config
SCRIPT_DIR=$(readlink -f $(dirname "$0")/..)/scripts
cd $SCRIPT_DIR

PARAM="Generator"
DURATION="1"
MODE="paper"

# equality
OUT_EQ=$OUT_PATH/outputs_short/test_equality
python3 ./run_tools.py $CONFIG_DIR/test_equality_p.conf $OUT_EQ
./save_results.sh $OUT_EQ $OUT_EQ/equality_results $PARAM $DURATION $MODE > $OUT_EQ/equality_summary

# real-constraints
OUT_NEG=$OUT_PATH/outputs_short/test_constr
python3 ./run_tools.py $CONFIG_DIR/test_neg_p.conf $OUT_NEG
./save_results.sh $OUT_NEG $OUT_NEG/constr_results $PARAM $DURATION $MODE > $OUT_NEG/constr_summary

echo "Results summary for: test_equality"
cat $OUT_EQ/equality_summary
echo "Results summary for: test_constr"
cat $OUT_NEG/constr_summary
