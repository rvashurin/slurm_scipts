# for each file that has 'train_multigpu.sh' in the name, find the lines where substring 'model=llama_1b' is present and add the following after the substring: ' model.path=Qwen/Qwen2.5-1.5B'

import os

models = {
    'qwen_2.5_1.5b': 'Qwen/Qwen2.5-1.5B',
    'falcon_3_1b': 'tiiuae/Falcon3-1B-Base'
}

def main():
    path = '.'
    for root, dirs, files in os.walk(path):
        for file in files:
            if 'train_multigpu.sh' in file:
                file_path = os.path.join(root, file)
                with open(file_path, 'r') as f:
                    lines = f.readlines()
                for model, model_path in models.items():
                    new_file_path = file_path.replace('llama_3.2_1b', model)
                    with open(new_file_path, 'w') as f:
                        for line in lines:
                            if 'model=llama_1b' in line:
                                line = line.replace('model=llama_1b', 'model=llama_1b model.path=' + model_path)
                            if 'llama_3.2_1b' in line:
                                line = line.replace('llama_3.2_1b', model)
                            f.write(line)

if __name__ == '__main__':
    main()
