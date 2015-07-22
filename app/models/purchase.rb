class Purchase < ActiveRecord::Base
	has_one :invoice, :class_name => 'Invoice', :foreign_key => 'invoice_id'
	belongs_to :client

	before_save :verify_payment_state

	serialize :product_ids, Array
	serialize :quantities, Array
	serialize :prices, Array

	def price_with_taxes
		after_add = price + price * 0.1
		if calc_sub_tax
			after_sub = after_add - price * 0.005
			after_sub.round(2)
		end
	end

	def added_tax
		price * 0.1
	end

	def sub_tax
		price * 0.005
	end


	private
		def verify_payment_state
			if self.debt > 0
				self.payment_state = "آجل"
			else
				self.payment_state = "تم الدفع"
			end
		end
end
