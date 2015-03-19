module ApplicationHelper
	def date_format datetime
		datetime.strftime("%F")
	rescue
		"-"	
	end
end
