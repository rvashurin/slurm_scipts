import os

# iterate over files with .sh extension in current directory
for file in os.listdir('.'):
    if file.endswith('.sh') and file.startswith('mistral'):
        # open file and read contents
        with open(file, 'r') as f:
            content = f.read()
            # replace mistral to llama in contents

            content = content.replace('model.path=mistral-community/Mistral-7B-v0.2', 'model=falcon3')
            content = content.replace('mistral', 'falcon')

            # write contents to new file replacing mistral with llama in filename
            with open(file.replace('mistral', 'falcon'), 'w') as f:
                f.write(content)

