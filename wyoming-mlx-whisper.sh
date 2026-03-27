#!/bin/bash
./script/setup
./script/run --uri tcp://0.0.0.0:${WHISPER_PORT:-7891} --model ${WHISPER_MODEL:-mlx-community/whisper-large-v3-turbo}
