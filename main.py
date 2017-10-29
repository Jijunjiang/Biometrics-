
# coding: utf-8

# In[69]:

import pandas as pd
import os
root='/Users/apple/Desktop/reading/bio/2008-03-11_13/'
dirlist = [ item for item in os.listdir(root) if os.path.isdir(os.path.join(root, item)) ]
for subdir in dirlist:
    fullPath = root + subdir + '/' + subdir + '.txt'
    df = pd.read_csv(fullPath, sep='\t', lineterminator='\n')  
    df_copy1 = df[df['id'] == 'sequenceid'].reset_index(drop=True)
    df_copy2 = df[df['id'] == 'eye'].reset_index(drop=True)
    df_copy = df_copy1[df.columns[2]].to_frame()
    df_copy.columns = ['id']
    df_copy['eye'] = df_copy2[df.columns[2]]
    df_copy.to_csv(path_or_buf = root + subdir + '/' + subdir + '.txt', sep = ' ')
    


# In[72]:

import pandas as pd
df = pd.read_csv('/Users/apple/Desktop/reading/bio/2008-03-11_13/02463/02463.txt', sep='\t', lineterminator='\n')
df_copy1 = df[df['id'] == 'sequenceid'].reset_index(drop=True)
df_copy2 = df[df['id'] == 'eye'].reset_index(drop=True)
df_copy = df_copy1[df.columns[2]].to_frame()
df_copy.columns = ['id']
df_copy['eye'] = df_copy2[df.columns[2]]
df_copy


# In[78]:

import os
root='/Users/apple/Desktop/reading/bio/2008-03-11_13/'
dirlist = [ item for item in os.listdir(root) if os.path.isdir(os.path.join(root, item)) ]
for subdir in dirlist:
    fullPath = root + subdir + '/' + subdir + '.txt'
    with open(fullPath, 'r') as fin:
        data = fin.read().splitlines(True)
    with open(fullPath, 'w') as fout:
        fout.writelines(data[1:])


# In[ ]:



