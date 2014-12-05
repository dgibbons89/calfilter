class Calendar < ActiveRecord::Base
	has_many :events
	belongs_to :school
end
