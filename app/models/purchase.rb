class Purchase < ActiveRecord::Base
	has_one :invoice, :class_name => 'Invoice', :foreign_key => 'invoice_id'
	belongs_to :client

	before_save :verify_payment_state


	private
		def verify_payment_state
			if self.debt > 0
				self.payment_state = "آجل"
			else
				self.payment_state = "تم الدفع"
			end
		end
end
