class Invoice < ActiveRecord::Base
	belongs_to :purchase, :class_name => 'Purchase', :foreign_key => 'purchase_id'
end
