import argparse
def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--video_list_filepath', type=str, default='', help='Path for video list file')

    return parser.parse_args()

if __name__ == '__main__':
    args = parse_args()

    with open(args.video_list_filepath, 'r') as file:
        for line in file:
            key = line.strip()  # Remove newline character
            print(f"{key}")