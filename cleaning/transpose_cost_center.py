import pandas as pd 

file_path_expendituers = './data/cost_center_data.csv'

expenditures_headers = ['id', 'name']

expenditures = pd.read_csv(file_path_expendituers, index_col=False, low_memory=False).T
expenditures.reset_index(level=0, inplace=True)
expenditures.columns = expenditures_headers

expenditures.to_csv('./data/cost_center_transposed.csv', sep='|', index=False)