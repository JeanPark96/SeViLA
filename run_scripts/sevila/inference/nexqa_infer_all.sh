# parameters/data path
result_dir="/home/hlpark//REDUCE/REDUCE_benchmarks/SeViLA/sevila_tvqa_hirest_prediction_gt_fulldata"
data='tvqa'
video_path="/home/hlpark/shared/TVQA/video/video_files"

exp_list=('original'
        'finetuned_on_visual_med'
        'finetuned_on_visual_nonmed'
        'finetuned_on_full_without_audio')

val_folder_list=('/home/hlpark/REDUCE/REDUCE_benchmarks/SeViLA/sevila_data/hirest_tvqa_original_pred/val_hirest_gt.json'
        '/home/hlpark/REDUCE/REDUCE_benchmarks/SeViLA/sevila_data/hirest_tvqa_finetuned_on_visual_med/val_hirest_gt.json'
        '/home/hlpark/REDUCE/REDUCE_benchmarks/SeViLA/sevila_data/hirest_tvqa_finetuned_on_visual_nonmed/val_hirest_gt.json'
        '/home/hlpark/REDUCE/REDUCE_benchmarks/SeViLA/sevila_data/hirest_tvqa_finetuned_on_full_without_audio/val_hirest_gt.json')

ckpt='sevila_checkpoints/sevila_pretrained.pth'

for idx in "${!exp_list[@]}"; do

    exp_name="${exp_list[$idx]}"
    val_path="${val_folder_list[$idx]}"

    CUDA_VISIBLE_DEVICES=0,1 python -m torch.distributed.run --nproc_per_node=2 evaluate.py \
    --cfg-path /home/hlpark/REDUCE/REDUCE_benchmarks/SeViLA/lavis/projects/sevila/eval/tvqa_eval.yaml  \
    --options run.output_dir=${result_dir}/${exp_name} \
    datasets.tvqa.build_info.annotations.train.storage=${val_path} \
    datasets.tvqa.build_info.annotations.val.storage=${val_path} \
    datasets.tvqa.build_info.annotations.test.storage=${val_path} \
    datasets.tvqa.build_info.videos.storage=${video_path} \
    model.frame_num=4 \
    datasets.tvqa.vis_processor.eval.n_frms=32 \
    run.batch_size_eval=1 \
    model.task='qvh_freeze_loc_freeze_qa_vid' \
    model.finetuned=${ckpt} \
    run.task='videoqa'
done