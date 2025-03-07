import os

for file in os.listdir('.'):
    if '.sh' in file:
        lines = open(file, 'r').readlines()
        new_file = file.replace('llama_3.1', 'gemma_2')
        with open(new_file, 'w') as handle:
            for line in lines:
                line = line.replace('llama_3.1', 'gemma_2')
                line = line.replace('llama', 'gemma')
                handle.write(line)
