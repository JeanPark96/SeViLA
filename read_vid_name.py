filename = "/home/hlpark/shared/REDUCE/REDUCE_benchmarks/SeViLA/sevila_data/tvqa_list/vid_name_list.txt"
with open(filename, 'r') as file:
    for line in file:
        key = line.strip()  # Remove newline character
        print(f"{key}")