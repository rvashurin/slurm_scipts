# Take every .sh file in the current dir, add ' +generation_params.top_k=5 entropy_top_k=5' to the last line, and save it as a new file with the same name but with a suffix '_top5.sh'

import os

for filename in os.listdir('.'):
    if filename.endswith('.sh'):
        with open(filename, 'r') as f:
            lines = f.readlines()
        lines[-1] = lines[-1].strip() + ' +generation_params.top_k=5 entropy_top_k=5\n'
        with open(filename[:-3] + '_top5.sh', 'w') as f:
            f.writelines(lines)
