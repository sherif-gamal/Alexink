class EhlakOsool < ActiveRecord::Base

	def acc_ehlak
		self.last_year_acc + ehlak
	end

	def ehlak
		self.rate * self.value / 100
	end

	def total_value
		self.value - acc_ehlak
	end
end
