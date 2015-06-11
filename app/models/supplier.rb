class Supplier < ActiveRecord::Base
	has_many :materials
	before_save :init_credit

	private
		def init_credit
			self.credit |= 0
		end
end
