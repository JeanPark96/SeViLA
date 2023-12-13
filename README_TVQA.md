### How to evaluate TVQA dataset for answer localization task

## 1. Follow instruction in original SeViLa github repository
    install conda
    install sevila model and download it in 'sevila_checkpoints' directory

## 2. Download TVQA video files and json files
    copy and paste video files located in '/data3/hlpark/TVQA/video/video_files/' to your own local folder
    copy and paste json files located in '/data3/hlpark/TVQA/tvqa_qa_release/' to your own local folder

## 3. Preprocess
    Run 'TVQA_Preprocess.ipynb' file. Do not forget to change the directory path to your own local file. 

## 4. Run experiment
    Modify the filename in read_vid_name.py
    Modify the paths in '/run_scripts/sevila/inference/tvqa_infer_all.sh' and '/run_scripts/sevila/inference/tvqa_infer_vid.sh'
    
    ```
    #run experiment
    ./run_scripts/sevila/inference/tvqa_infer_all.sh
    ```

## 5. Evaluate the result
    Run 'TVQA_Evaluate.ipynb' file. Do not forget to change the directory path to your own local file.  
