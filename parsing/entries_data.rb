require 'json'
require 'open-uri'
require 'csv'
require 'pry'


dep_ids = []

dep_info_fp = './data/alerj_personal_info.csv'
csv_options = { headers: :first_row, header_converters: :symbol }

CSV.foreach(dep_info_fp, csv_options) do |row|
  dep_ids << row[:congressman_id].to_i
end

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

dep_ids.each do |id|
  url  = "https://docigp.alerj.rj.gov.br/api/v1/congressmen/#{id}/budgets?query=%7B%22filter%22:%7B%22text%22:null,%22checkboxes%22:%7B%22filler%22:false%7D,%22selects%22:%7B%22filler%22:false%7D%7D,%22pagination%22:%7B%22total%22:11,%22per_page%22:%22250%22,%22current_page%22:1,%22last_page%22:2,%22from%22:1,%22to%22:10,%22pages%22:[1,2]%7D%7D"
  doc  = open(url).read
  data = JSON.parse(doc)

  range_entries = (0...data['data'].size)

  range_pair = []

  range_entries.each do |entry|
    entries_per_month = (0...data['data'][entry]['entries'].size)
    entries_per_month.each do |number|
      range_pair << [entry, number]
    end
  end

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
  sleep(2)
end

filepath = './data/expenditures_30082020.csv'

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

