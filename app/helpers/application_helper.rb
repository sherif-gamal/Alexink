module ApplicationHelper
	def f(num)
		num.round(2)
	end

	def d(date)
		date.strftime("%Y/%m/%d")
	end
end
