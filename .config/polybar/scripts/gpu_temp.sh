#!/bin/bash

GPU_TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)
echo "GPU Temp: $GPU_TEMP°C"

