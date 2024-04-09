# parameters/data path
result_dir="/home/hlpark//REDUCE/REDUCE_benchmarks/SeViLA/sevila_tvqa_original2"
train_path="/home/hlpark/REDUCE/REDUCE_benchmarks/SeViLA/sevila_data/tvqa_evaluation_json/train_gt.json"
val_path="/home/hlpark/REDUCE/REDUCE_benchmarks/SeViLA/sevila_data/tvqa_evaluation_json/val_gt.json"
test_path="/home/hlpark/REDUCE/REDUCE_benchmarks/SeViLA/sevila_data/tvqa_evaluation_json/val_gt.json"
data='tvqa'
video_path="/home/hlpark/shared/TVQA/video/video_files"
exp_name='tvqa_infer'
ckpt='sevila_checkpoints/sevila_pretrained.pth'
CUDA_VISIBLE_DEVICES=0,1 python -m torch.distributed.run --nproc_per_node=2 evaluate.py \
--cfg-path /home/hlpark/REDUCE/REDUCE_benchmarks/SeViLA/lavis/projects/sevila/eval/tvqa_eval.yaml  \
--options run.output_dir=${result_dir} \
datasets.tvqa.build_info.annotations.train.storage=${train_path} \
datasets.tvqa.build_info.annotations.val.storage=${val_path} \
datasets.tvqa.build_info.annotations.test.storage=${test_path} \
datasets.tvqa.build_info.videos.storage=${video_path} \
model.frame_num=4 \
datasets.tvqa.vis_processor.eval.n_frms=32 \
run.batch_size_eval=1 \
model.task='qvh_freeze_loc_freeze_qa_vid' \
model.finetuned=${ckpt} \
run.task='videoqa'