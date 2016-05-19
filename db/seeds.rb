# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Stock.destroy_all

require 'csv'

csv_text = File.read('db/assets/companylist-amex.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
    hash = row.to_hash
    Stock.create!({
        symbol: hash["Symbol"],
        name: hash["Name"],
        exchange: "AMEX"
    })
end

csv_text = File.read('db/assets/companylist-nasdaq.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
    hash = row.to_hash
    Stock.create!({
        symbol: hash["Symbol"],
        name: hash["Name"],
        exchange: "NASDAQ"
    })
end

csv_text = File.read('db/assets/companylist-nyse.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
    hash = row.to_hash
    Stock.create!({
        symbol: hash["Symbol"],
        name: hash["Name"],
        exchange: "NYSE"
    })
end
