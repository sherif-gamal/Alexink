class Client < ActiveRecord::Base
	has_many :purchases

	before_save :validate

	private
		def validate
			self.debt ||= 0
			self.deleted  ||= 0
		end
end
