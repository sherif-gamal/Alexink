class RawMaterial < ActiveRecord::Base

	before_save :init_stock


	private
		def init_stock
			self.in_stock |= 0
		end
end
