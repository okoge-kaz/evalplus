#!/bin/bash
#PBS -q rt_HG
#PBS -N eval_plus
#PBS -l select=1
#PBS -l walltime=1:00:00
#PBS -j oe
#PBS -m n
#PBS -koed
#PBS -V
#PBS -o outputs/

set -e
cd $PBS_O_WORKDIR

echo "Nodes allocated to this job:"
cat $PBS_NODEFILE

: "${MODEL_NAME:?MODEL_NAME is not set. Submit with: qsub -v MODEL_NAME=... bigcodebench_eval.pbs}"

# environment variables
export TMP="/groups/gag51395/fujii/tmp"
export TMP_DIR="/groups/gag51395/fujii/tmp"
export HF_HOME="/groups/gag51395/fujii/hf_cache"

source .venv/bin/activate

export CUDA_VISIBLE_DEVICES=0
evalplus.evaluate --model $MODEL_NAME \
                  --dataset humaneval \
                  --backend vllm      \
                  --tp 1              \
                  --greedy
