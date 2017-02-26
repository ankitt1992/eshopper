class Report < ActiveRecord::Base
	scope :successful, -> {where(status: 'successfull')}
end