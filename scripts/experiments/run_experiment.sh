#!/bin/sh
cd ~/sparseharness/
# mkdir -p build
# pushd build 
# cmake .. 
# make -j64
# popd
cd scripts/experiments
# ./run_all.sh ~/mdatasets/original/ ../../build/spmv_harness ~/kdatasets/kernels/e9d0b5b53766f985811eb7a0e6b92b33c757b864/spmv/ ../../example/runfile2.csv 0 0 

./run_all.sh ~/scratch/mdatasets/original/ ../../build/sssp_harness ~/scratch/kdatasets/kernels/5aa381dfb57851f6076601d3020d7fa2bca9039c/sssp/ ../../example/runfile.csv 0 0 ~/scratch/s1467120
