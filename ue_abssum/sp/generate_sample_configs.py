import numpy as np
import os
import re

top_ks = np.logspace(1, np.log10(32128), num=20).astype(int)
top_ps = np.linspace(0.01, 1.0, num=20).round(2)

for top_k in top_ks:
    infile = open('sq_en_single_large_ft_sample_base.sh', 'r')
    outfile = open(f'sq_en_single_large_ft_sample_topk_{top_k}.sh', 'w')

    for line in infile:
        outfile.write(re.sub(r'topk_10', f'topk_{top_k}', line))

    infile.close()
    outfile.close()

for top_p in top_ps:
    infile = open('sq_en_single_large_ft_sample_base.sh', 'r')
    outfile = open(f'sq_en_single_large_ft_sample_topp_{top_p}.sh', 'w')

    for line in infile:
        outfile.write(re.sub(r'topk_10', f'topp_{top_p}', line))

    infile.close()
    outfile.close()

