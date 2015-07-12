class RawMaterial < ActiveRecord::Base

	before_save :validate


	private
		def validate
			self.in_stock ||= 0
			self.deleted ||= 0
		end
end
