class EhlakOsool < ActiveRecord::Base

	before_save :init

	def acc_ehlak
		self.last_year_acc + ehlak
	end

	def ehlak
		self.rate * self.value / 100
	end

	def total_value
		self.value - acc_ehlak
	end


	private
		def init
			self.last_year_acc ||= 0
			self.rate ||= 0
			self.value ||= 0
		end
end
