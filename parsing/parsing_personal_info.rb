require 'json'
require 'open-uri'
require 'csv'

url = 'https://docigp.alerj.rj.gov.br/api/v1/congressmen?query=%7B%22filter%22:%7B%22text%22:null,%22checkboxes%22:%7B%22withMandate%22:false,%22withoutMandate%22:false,%22withPendency%22:false,%22withoutPendency%22:false,%22unread%22:false,%22joined%22:true,%22notJoined%22:false,%22filler%22:false%7D,%22selects%22:%7B%22filler%22:false%7D%7D,%22pagination%22:%7B%22total%22:57,%22per_page%22:%22250%22,%22current_page%22:1,%22last_page%22:6,%22from%22:1,%22to%22:10,%22pages%22:[1,2,3,4,5]%7D%7D'
doc = open(url).read

data = JSON.parse(doc)

name           = []
nickname 			 = []
congressman_id = []
party_code     = []
party_name 		 = []
email 				 = []

congress_range = (0..(data['data'].length - 1))

congress_range.each do |n|
	name           << data['data'][n]['name']
	nickname       << data['data'][n]['nickname']
	congressman_id << data['data'][n]['user']['congressman_id']
	party_code     << data['data'][n]['party']['code']
	party_name     << data['data'][n]['party']['name']
	email          << data['data'][n]['user']['email']
end

filepath = '../data/alerj_data.csv'

CSV.open(filepath, 'wb') do |csv|
  # csv << ['name', 'nickname', 'congressman_id', 'party_code', 'party_name', 'email']
  csv << name
  csv << nickname
  csv << congressman_id
  csv << party_code
  csv << party_name
  csv << email
end