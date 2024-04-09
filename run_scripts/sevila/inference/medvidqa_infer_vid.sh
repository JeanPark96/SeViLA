# parameters/data path
result_dir="/home/hlpark/REDUCE/REDUCE_benchmarks/SeViLA/sevila_medvidqa_result"
video_name=$1
train_path=$2
val_path=$3
test_path=$4
exp_name='medvidqa_infer'
data='medvidqa'
video_path="/home/hlpark/shared/MedVidQA/video"

ckpt='sevila_checkpoints/sevila_pretrained.pth'

# YAML file path
yaml_file="/home/hlpark/REDUCE/REDUCE_benchmarks/SeViLA/lavis/configs/datasets/medvidqa/defaults_qa.yaml"

# Check if the YAML file exists
if [ ! -f "$yaml_file" ]; then
    echo "YAML file does not exist: $yaml_file"
    exit 1
fi

python edit_yaml.py --yaml-path $yaml_file --train-path $train_path --val-path $val_path --test-path $test_path --video-path $video_path --data $data

# Get frame number from input video
frame_num=$(python video_frame.py --video-path ${video_path}/$video_name --data $data --downsample 8)

echo "Frame num for $video_name is $frame_num"

CUDA_VISIBLE_DEVICES=0,1 python -m torch.distributed.run --nproc_per_node=2 evaluate.py \
--cfg-path /home/hlpark/shared/REDUCE_benchmarks/SeViLA/lavis/projects/sevila/eval/medvidqa_eval.yaml \
--options run.output_dir=${result_dir}/${video_name} \
datasets.medvidqa.build_info.annotations.train.storage=${train_path} \
datasets.medvidqa.build_info.annotations.val.storage=${val_path} \
datasets.medvidqa.build_info.annotations.test.storage=${test_path} \
datasets.medvidqa.build_info.videos.storage=${video_path} \
model.frame_num=4 \
datasets.medvidqa.vis_processor.eval.n_frms=${frame_num} \
run.batch_size_eval=1 \
model.task='qvh_freeze_loc_freeze_qa_vid' \
model.finetuned=${ckpt} \
run.task='videoqa'
