#!/bin/bash

# Define directory where MedVidQA json files are located in
ROOT_PATH="/home/hlpark/REDUCE/REDUCE_benchmarks/SeViLA/sevila_data/medvidqa"
VIDEO_LIST_PATH="/home/hlpark/REDUCE/REDUCE_benchmarks/SeViLA/sevila_data/medvidqa_list/vid_name_list.txt"
# Check if the folder exists
if [ ! -d "$ROOT_PATH" ]; then
    echo "Directory does not exist: $ROOT_PATH"
    exit 1
fi

#read video names
vid_names=$(python read_vid_name.py --video_list_filepath $VIDEO_LIST_PATH)

# Iterate through each file in the folder
for video in $vid_names;
do
    # only validation json file will be evaluated
    if [ -f "${ROOT_PATH}/${video}_val.json" ]; then
        echo $video
        ./run_scripts/sevila/inference/medvidqa_infer_vid.sh $video ${ROOT_PATH}/${video}_val.json ${ROOT_PATH}/${video}_val.json ${ROOT_PATH}/${video}_val.json
    fi 
done