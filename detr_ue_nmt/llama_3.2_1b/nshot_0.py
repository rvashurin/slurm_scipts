# Take every file that has "instruct" in the name, open it, find all strings that contain "batch_size" in them, prepend "batch_size" with "nshot=0" and write the file back to disk adding "_nshot_0" to the filename before the extension.

import os

def main():
    for filename in os.listdir('.'):
        if 'instruct' in filename:
            with open(filename, 'r') as file:
                lines = file.readlines()
            filename = filename.replace('instruct', 'instruct_nshot_0')
            with open(filename, 'w') as file:
                for line in lines:
                    if 'deberta_batch_size' in line:
                        line = line.replace('deberta_batch_size', 'nshot=0 deberta_batch_size')
                    if 'test_train_multigpu' in line:
                        line = line.replace('test_train_multigpu', 'test_train_multigpu_instruct_nshot_0')
                    file.write(line)

if __name__ == '__main__':
    main()
