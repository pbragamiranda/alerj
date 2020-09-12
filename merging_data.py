#!/usr/bin/env python
# coding: utf-8

# In[2]:


import pandas as pd
pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', None)

fp_entries = './data/expenditures_transposed_30082020.csv'
fp_personal_info = './data/alerj_personal_transposed.csv'
fp_cost_center = './data/cost_center_transposed.csv'

entries = pd.read_csv(fp_entries, sep='|')
personal = pd.read_csv(fp_personal_info, sep=',')
cost_center = pd.read_csv(fp_cost_center, sep='|')


# In[3]:


entries['congressman_id'] = entries['congressman_id'].astype(float).astype(int) 


# In[4]:


entries_personal = entries.merge(personal, on='congressman_id')
entries_personal = entries_personal.drop(columns=['name', 'nickname']) 


# In[5]:


complete = entries_personal.merge(cost_center, left_on='cost_center_id', right_on='id')
complete = complete.drop(columns=['id'])
complete.rename(columns={"name": "cost_center_name"}, inplace=True)


# In[6]:


complete_clean = complete[['congressman_id', 'congressman_name', 'congressman_nickname', 'party_code', 'party_name', 'email',
                           'date', 'value', 'object', 'to', 'cost_center_id', 'cost_center_name']]


# In[7]:


complete_clean.head()


# In[8]:


# complete_clean.to_csv('./data/complete_30082020.csv')


# In[9]:


import matplotlib.pyplot as plt  
plt.style.use('dark_background')
complete_clean.groupby(['cost_center_name'])['value'].sum().reset_index().head(10).plot(kind='barh')


# In[10]:


complete_clean.groupby(['cost_center_name'])['value'].sum().reset_index().sort_values(by=['value'])


# In[11]:


complete_clean[complete_clean['cost_center_name'] == 'VI - Outras despesas com locomoção']


# In[12]:


complete_clean[complete_clean['cost_center_name'].str.startswith('VI.b', na=False)]


# In[13]:


complete_clean.head()


# In[ ]:




