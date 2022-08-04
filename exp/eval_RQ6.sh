#!/bin/bash
# NOTE: before running, fix the NUM_WORKERS in 'run_tools.py' to the number of available cores
OUT_PATH=$1
CONFIG_DIR=$(readlink -f $(dirname "$0"))/eval_config
SCRIPT_DIR=$(readlink -f $(dirname "$0")/..)/scripts
cd $SCRIPT_DIR

# Examples for visualization
PARAM="Algorithm"
DURATION="24"
MODE="paper"
OUT_RQ6=$OUT_PATH/outputs/test_visualization
python3 ./run_tools.py $CONFIG_DIR/test_RQ6.conf $OUT_RQ6
./save_results.sh $OUT_RQ6 $OUT_RQ6/visualization_results $PARAM $DURATION $MODE > $OUT_RQ6/visualization_summary

PATH_TO_TXT="../exp/eval_mazes/visual/txt"
PATH_TO_COV_BACKTRACKING=$OUT_RQ6/cov_gcov_Backtracking_20x20_7_1_25percent_CVE-2016-4491_gen_afl_0/Backtracking_20x20_7_1_25percent_CVE-2016-4491_gen_afl_0_24hr.c.gcov
PATH_TO_COV_PRIMS=$OUT_RQ6/cov_gcov_Prims_20x20_5_1_25percent_CVE-2016-4491_gen_afl_0/Prims_20x20_5_1_25percent_CVE-2016-4491_gen_afl_0_24hr.c.gcov
PATH_TO_COV_SIDEWINDER=$OUT_RQ6/cov_gcov_Sidewinder_20x20_5_1_25percent_CVE-2016-4491_gen_afl_0/Sidewinder_20x20_5_1_25percent_CVE-2016-4491_gen_afl_0_24hr.c.gcov

python3 ./visualize.py $PATH_TO_TXT/Backtracking_20x20_7_1.txt $PATH_TO_COV_BACKTRACKING $OUT_RQ6/backtracking 20
python3 ./visualize.py $PATH_TO_TXT/Prims_20x20_5_1.txt $PATH_TO_COV_PRIMS $OUT_RQ6/prims 20
python3 ./visualize.py $PATH_TO_TXT/Sidewinder_20x20_5_1.txt $PATH_TO_COV_SIDEWINDER $OUT_RQ6/sidewinder 20

echo "Results summary for: test_visualization"
cat $OUT_RQ6/visualization_summary
