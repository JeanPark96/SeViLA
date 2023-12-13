from moviepy.editor import VideoFileClip
import argparse
def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--video-path', type=str, default='', help='Path for video')

    return parser.parse_args()

if __name__ == '__main__':
    args = parse_args()
    if args.video_path.endswith(".mp4"):
        video = VideoFileClip(args.video_path)
    else:
        video = VideoFileClip(args.video_path + ".mp4")

    n_frames = (video.reader.nframes) // 3
    print(n_frames)