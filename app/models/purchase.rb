class Purchase < ActiveRecord::Base
	has_one :invoice, :class_name => 'Invoice', :foreign_key => 'invoice_id'
	belongs_to :client
end
