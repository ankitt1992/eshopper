class Address < ActiveRecord::Base
  belongs_to :user
  has_many :orders

  validates :mobile_no, :presence => {:message => 'Mobile number invalid'},
                    		:numericality => true,
                    		:length => { :minimum => 10, :maximum => 10 }

  validates :postal_code, :presence => {:message => 'Postal code invalid'},
                    			:numericality => true,
                    			:length => { :minimum => 6, :maximum => 6 }
end
