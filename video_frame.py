from moviepy.editor import VideoFileClip
import argparse
def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--video-path', type=str, default='', help='Path for video')
    parser.add_argument('--data', type=str, default='tvqa', help='data type')
    parser.add_argument('--downsample', type=int, default=3, help='downsample rate')

    return parser.parse_args()

if __name__ == '__main__':
    args = parse_args()
    if args.video_path.endswith(".mp4"):
        video = VideoFileClip(args.video_path)
    else:
        video = VideoFileClip(args.video_path + ".mp4")
    if args.data == "tvqa":
        n_frames = (video.reader.nframes) // args.downsample
    elif args.data == "medvidqa":
        n_frames = (video.reader.nframes) // (args.downsample * video.fps)
    print(int(n_frames))