class Event < ActiveRecord::Base
	require 'roo'
	
	acts_as_taggable

	belongs_to :calendar
	def accessible_attributes
 		[name, time1, time2, details, clock1, clock2]
	end

	def self.import(file)
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).each do |i|
  		row = Hash[[header, spreadsheet.row(i)].transpose]
  		event = find_by_id(row["id"]) || new
  		event.attributes = row.to_hash.slice(*row.to_hash.keys)
  		event.save!
	end
end

	def self.open_spreadsheet(file)
		  case File.extname(file.original_filename)
		  when ".csv" then Csv.new(file.path, nil, :ignore)
		  when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
		  when ".xlsx" then Excelx.new(file.path, nil, :ignore)
		  else raise "Unknown file type: #{file.original_filename}"
  	end
	end

end
