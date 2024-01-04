#!/usr/bin/python

import yaml
import sys
import argparse
def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--yaml-path', type=str, default='', help='Path for yaml file for editing')
    parser.add_argument('--train-path', type=str, default='', help='Path for train.json')
    parser.add_argument('--test-path', type=str, default='', help='Path for test.json')
    parser.add_argument('--val-path', type=str, default='', help='Path for val.json')
    parser.add_argument('--video-path', type=str, default='', help='Path for video')
    parser.add_argument('--data', type=str, default='tvqa', help='dataset name')
    return parser.parse_args()

if __name__ == '__main__':
    args = parse_args()
    with open(args.yaml_path) as f:
        y = yaml.safe_load(f)
    y['datasets'][args.data]['build_info']['annotations']['train']['url'] = args.train_path
    y['datasets'][args.data]['build_info']['annotations']['train']['storage'] = args.train_path
    y['datasets'][args.data]['build_info']['annotations']['test']['url'] = args.test_path
    y['datasets'][args.data]['build_info']['annotations']['test']['storage'] = args.test_path
    y['datasets'][args.data]['build_info']['annotations']['val']['url'] = args.val_path
    y['datasets'][args.data]['build_info']['annotations']['val']['storage'] = args.val_path
    y['datasets'][args.data]['build_info']['videos']['storage'] = args.video_path

    with open(args.yaml_path, 'w') as file:
        yaml.dump(y, file)