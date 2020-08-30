import pandas as pd 

file_path_expendituers = './data/expenditures_30082020.csv'

expenditures_headers = ['congressman_id', 'congressman_name', 'congressman_nickname', 'date', 
											 'value', 'object', 'to', 'code', 'parent_code', 'description', 'cost_center_id']

expenditures = pd.read_csv(file_path_expendituers, index_col=False, sep='|').T
expenditures.reset_index(level=0, inplace=True)
expenditures.columns = expenditures_headers

expenditures.to_csv('./data/expenditures_transposed_30082020.csv', sep='|', index=False)