require 'json'
require 'open-uri'
require 'csv'

url  = "https://docigp.alerj.rj.gov.br/api/v1/congressmen/2/budgets?query=%7B%22filter%22:%7B%22text%22:null,%22checkboxes%22:%7B%22filler%22:false%7D,%22selects%22:%7B%22filler%22:false%7D%7D,%22pagination%22:%7B%22total%22:11,%22per_page%22:%22250%22,%22current_page%22:1,%22last_page%22:2,%22from%22:1,%22to%22:10,%22pages%22:[1,2]%7D%7D"
doc  = open(url).read
data = JSON.parse(doc)

range_entries = (0...data['data'].size)

range_pair = []

congressman_legislature_id = []
congressman_name 					 = []
congressman_nickname 			 = []
date 											 = []
value 										 = []
object										 = []
to 												 = []
code 											 = []
parent_code  							 = []
cost_center_name  				 = []
cost_center_id 	    			 = []

range_entries.each do |entry|
  entries_per_month = (0...data['data'][entry]['entries'].size)
  entries_per_month.each do |number|
    range_pair << [entry, number]
  end
end

# p range_entries

# p range_pair

# p data.dig('data', 0, 'entries', 0, 'value')
# p data.dig('data', 1, 'entries', 0, 'value')
# p data.dig('data', 2, 'entries', 0, 'value')
# p data.dig('data', 2, 'entries', 1, 'value')
# p data.dig('data', 2, 'entries', 2, 'value')
# p data.dig('data', 2, 'entries', 3, 'value')
# p data.dig('data', 2, 'entries', 4, 'value')
# p data.dig('data', 2, 'entries', 5, 'value')
# p data.dig('data', 2, 'entries', 6, 'value')
# p data.dig('data', 2, 'entries', 7, 'value')

range_pair.each do |e, n|
  congressman_legislature_id << data.dig('data', 0, 'congressman_legislature_id')
  congressman_name 					 << data.dig('data', 0, 'congressman_legislature', 'congressman', 'name')
  congressman_nickname 			 << data.dig('data', 0, 'congressman_legislature', 'congressman', 'nickname')
  date 											 << data.dig('data', e, 'entries', n, 'date')
  value 										 << data.dig('data', e, 'entries', n, 'value')
  object 										 << data.dig('data', e, 'entries', n, 'object')
  to 												 << data.dig('data', e, 'entries', n, 'to')
  code 											 << data.dig('data', e, 'entries', n, 'cost_center', 'code')
  parent_code 							 << data.dig('data', e, 'entries', n, 'cost_center', 'parent_code')
  cost_center_name					 << data.dig('data', e, 'entries', n, 'cost_center', 'name')
  cost_center_id						 << data.dig('data', e, 'entries', n, 'cost_center_id')
end

filepath = './data/alexandre.csv'

CSV.open(filepath, 'wb', col_sep: "|") do |csv|
  csv << congressman_legislature_id
  csv << congressman_name
  csv << congressman_nickname
  csv << date
  csv << value
  csv << object
  csv << to
  csv << code
  csv << parent_code
  csv << cost_center_name
  csv << cost_center_id
end