import pandas as pd 

file_path = '../data/alerj_data.csv'
congressman_df_headers = ['name', 'nickname', 'congressman_id', 'party_code', 'party_name', 'email']

congressman_df = pd.read_csv(file_path, index_col=False).T
congressman_df.reset_index(level=0, inplace=True)
congressman_df.columns = congressman_df_headers

congressman_df.to_csv('../data/alerj_personal_info.csv',  index=False)
