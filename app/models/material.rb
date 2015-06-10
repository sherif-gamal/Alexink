class Material < ActiveRecord::Base
	belongs_to :supplier
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
