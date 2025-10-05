#!/usr/bin/env bash
set -euo pipefail

JOB_SCRIPT="scripts/rt_HG_base.sh"
MODEL_PREFIX="/groups/gch51639/fujii/checkpoints/megatron-to-hf/Llama-3.1-8B/swallow-code/exp19/iteration_"

ITERATIONS=(1000 2000 2500 3000 4000 5000 6000 7000 7500 8000 9000)

mkdir -p outputs

for ITER in "${ITERATIONS[@]}"; do
  FORMATTED_ITER="$(printf "%07d" "${ITER}")"
  MODEL_NAME="${MODEL_PREFIX}${FORMATTED_ITER}"
  echo "Submitting iteration ${ITER} (${MODEL_NAME})"

  qsub \
    -P gag51395 \
    -v MODEL_NAME="${MODEL_NAME}" \
    "${JOB_SCRIPT}"
done
