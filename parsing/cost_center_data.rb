require 'json'
require 'open-uri'
require 'csv'


url = 'https://docigp.alerj.rj.gov.br/api/v1/cost-centers?query=%7B%22filter%22:%7B%22text%22:null,%22checkboxes%22:%7B%22filler%22:false%7D,%22selects%22:%7B%22filler%22:false%7D%7D,%22pagination%22:%7B%22per_page%22:10,%22current_page%22:1%7D,%22order%22:%7B%7D%7D'
doc = open(url).read

data = JSON.parse(doc)

cost_center_id   = []
cost_center_name = []

cost_center_range = (0..(data['data'].length - 1))

cost_center_range.each do |n|
	cost_center_id    << data['data'][n]['id']
	cost_center_name  << data['data'][n]['name']
end

filepath = './data/cost_center_data.csv'

CSV.open(filepath, 'wb') do |csv|
  # csv << ['name', 'nickname', 'congressman_id', 'party_code', 'party_name', 'email']
  csv << cost_center_id
  csv << cost_center_name
end



