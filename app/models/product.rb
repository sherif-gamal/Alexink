class Product < ActiveRecord::Base

	before_save :validate

	private
		def validate
			self.deleted  ||= 0
		end

end
